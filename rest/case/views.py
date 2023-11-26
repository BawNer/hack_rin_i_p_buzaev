import json
import requests
from django.http import JsonResponse
from rest_framework.decorators import api_view
from .models import Users, History
import xml.etree.ElementTree as ET
from random import randint, uniform
from time import sleep
import bcrypt
import jwt
import datetime
from . import constants
from .serializers import HistorySerializer


@api_view(['POST'])
def registration(request):
    all_logins = Users.objects.values_list('login', flat=True)
    data = json.loads(request.body)
    if data.get('login') not in all_logins:
        password = encrypt(data.get('password'))
        user = Users(
            name="Иван",
            surname="Иванович",
            lastname="Иванов",
            occupation="Врач",
            login=data.get('login'),
            age=34,
            annual_income=34,
            monthly_inhand_salary=534,
            num_bank_accounts=3,
            num_credit_card=1,
            num_of_loan=3,
            num_credit_inquiries=num_credit_inquiries(),
            credit_history_age=10,
            amount_invested_monthly=12000,
            payment_behaviour="High_spent_Small_value_payments",
            monthly_balance=monthly_balance(),
            password=password,

        )
        user.save()
        return JsonResponse({'success': 'true'})
    else:
        return JsonResponse({'success': 'false',
                             'error': 'this login already exists'})


@api_view(['POST'])
def login(request):
    data = json.loads(request.body)
    log_password = bytes(data.get('password'), 'utf-8')
    user = Users.objects.get(login=data.get('login'))
    db_password = user.password.tobytes()
    if bcrypt.checkpw(log_password, db_password):
        token = generate_token(user.id)
        return JsonResponse({'success': 'True',
                             'token': token})
    return JsonResponse({'success': 'False'})


@api_view(['GET'])  # Получение актуальных курсов валют
def currency(request):
    response = requests.get(constants.URL)
    course = [{
        'currency': "RUB",
        'name': 'Российский рубль',
        'course': 1
    }]
    if response.status_code == 200:
        root = ET.fromstring(response.content)
        for valute in root.findall('Valute'):
            curency = valute.find('CharCode').text
            if curency in constants.CURRS:
                value = valute.find('VunitRate').text
                name = valute.find('Name').text
                course.append({
                    'currency': curency,
                    'name': name,
                    'course': float(value.replace(',', '.'))
                })
        return JsonResponse({'success': 'true', 'data': course})
    return JsonResponse({'success': 'false'})


@api_view(['GET'])
def user_info(request):
    if request.headers.get('Token'):
        data = decode_token(request.headers.get('Token'))
        user = Users.objects.get(id=data.get('user_id'))
        user_details = {}
        for field in user._meta.fields:
            if field.name not in constants.EXCEPTION:
                user_details[field.name] = getattr(user, field.name)
        return JsonResponse(user_details)
    return JsonResponse({'success': 'false',
                         'error': 'invalid token'})


@api_view(['POST', 'GET'])
def loan_application(request):
    if request.method == "POST":  # Создание заявки
        sleep(randint(2, 5))
        if request.headers.get('Token'):
            token = decode_token(request.headers.get('Token'))
            hist = History(
                user_id=token.get('user_id'),
                credit_amount=4
            )
            hist.save()
        return JsonResponse({'success': 'true'})
    elif request.method == "GET":  # Возвращение списка заявок
        if request.headers.get('Token'):
            data = decode_token(request.headers.get('Token'))
            hist = History.objects.filter(user=data.get('user_id'))
            serializer = HistorySerializer(hist, many=True)
            return JsonResponse({'success': 'true', 'history': serializer.data}, safe=False)
    return JsonResponse({'success': 'false'})


@api_view(['GET'])
def loan_index_application(request, index):  # Возвращение конкретной заявки
    hist = History.objects.filter(id=index)
    serializer = HistorySerializer(hist, many=True)
    if request.headers.get('Token'):
        data = decode_token(request.headers.get('Token'))
        first_object = serializer.data[0].get("user")
        if data.get('user_id') == first_object:
            return JsonResponse({'success': 'true', 'history': serializer.data}, safe=False)
    return JsonResponse({'success': 'false', 'error': 'Invalid Token'})


def encrypt(password):  # Шифрование пароля
    byte = password.encode('utf-8')
    salt = bcrypt.gensalt()
    hashed = bcrypt.hashpw(byte, salt)
    return hashed


def generate_token(userid):
    payload = {
        'status': None,
        'user_id': userid,
        'exp': datetime.datetime.utcnow() + datetime.timedelta(days=1),
        'credit_amount': None,
        'credit_period': None,
        'payment_per_month': None,
        'pure_amount': None,
        'course': None,
        'pure_currency_name': None,
    }
    token = jwt.encode(payload, constants.SECRET_KEY, algorithm='HS256')
    return token


def decode_token(token):
    try:
        decoded_token = jwt.decode(token, constants.SECRET_KEY, algorithms=['HS256'])
        return decoded_token
    except jwt.ExpiredSignatureError:
        return "Токен просрочен"
    except jwt.InvalidTokenError:
        return "Невалидный токен"


def monthly_balance():
    return uniform(1, 1000)


def num_credit_inquiries():
    return randint(1, 5)


def pure_amount():
    pass


def pure_currency_name():
    pass
