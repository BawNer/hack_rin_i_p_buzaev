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
    data = json.loads(request.body)
    password = encrypt(data.get('password'))
    user = Users(
        # name=data.get('name'),
        # surname=data.get('surname'),
        # lastname=data.get('lastname'),
        # occupation=data.get('occupation'),
        login=data.get('login'),
        # age=data.get('age'),
        # annual_income=data.get('annual_income'),
        # monthly_inhand_salary=data.get('monthly_inhand_salary'),
        # num_bank_accounts=data.get('num_bank_accounts'),
        # num_credit_card=data.get('num_credit_card'),
        # num_of_loan=data.get('num_of_loan'),
        num_credit_inquiries=num_credit_inquiries(),
        # credit_history_age=data.get('credit_history_age'),
        # amount_invested_monthly=data.get('amount_invested_monthly'),
        # payment_behaviour=None,
        monthly_balance=monthly_balance(),
        password=password,

    )
    user.save()
    return JsonResponse({'success': 'true'})


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


@api_view(['GET'])
def currency(request):
    currs = ["TRY", "USD", "EUR", "KZT", "BYN", "CNY"]
    url = 'https://www.cbr.ru/scripts/XML_daily.asp'
    response = requests.get(url)
    course = [{
        'currency': "RUB",
        'name': 'Российский рубль',
        'course': 1
    }]
    if response.status_code == 200:
        root = ET.fromstring(response.content)
        for valute in root.findall('Valute'):
            curency = valute.find('CharCode').text
            if curency in currs:
                value = valute.find('Value').text
                name = valute.find('Name').text
                course.append({
                    'currency': curency,
                    'name': name,
                    'course': float(value.replace(',', '.'))
                })
        return JsonResponse({'success': 'true', 'data': course})


@api_view(['GET'])
def user_info(request):
    exceptions = ['password', 'access_token']
    data = json.loads(request.body)
    user = Users.objects.get(login=data.get('login'))
    user_details = {}
    for field in user._meta.fields:
        if field.name not in exceptions:
            user_details[field.name] = getattr(user, field.name)
    return JsonResponse(user_details)


@api_view(['POST', 'GET'])
def loan_application(request):
    if request.method == "POST":
        sleep(randint(2, 5))
        return JsonResponse({'success': 'true'})
    elif request.method == "GET":
        if request.headers.get('Token'):
            data = decode_token(request.headers.get('Token'))
            hist = History.objects.filter(user=data['user_id'])
            serializer = HistorySerializer(hist, many=True)
            return JsonResponse({'success': 'true', 'history': serializer.data}, safe=False)
    return JsonResponse({'success': 'false'})


@api_view(['GET'])
def loan_index_application(request, index):
    hist = History.objects.filter(id=index)
    serializer = HistorySerializer(hist, many=True)
    return JsonResponse({'success': 'true', 'history': serializer.data}, safe=False)


@api_view(['GET'])
def list_of_applications(request):
    pass


def encrypt(password):
    byte = password.encode('utf-8')
    salt = bcrypt.gensalt()
    hashed = bcrypt.hashpw(byte, salt)
    return hashed


def generate_token(userid):
    payload = {
        'user_id': userid,
        'exp': datetime.datetime.utcnow() + datetime.timedelta(days=1)
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
