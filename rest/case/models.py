from django.db import models


class Users(models.Model):
    id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=25)
    surname = models.CharField(max_length=25)
    lastname = models.CharField(max_length=25)
    occupation = models.CharField(max_length=50)
    login = models.CharField(max_length=50)
    age = models.FloatField(null=True)
    created_at = models.DateTimeField(editable=False, auto_now_add=True)
    annual_income = models.FloatField(null=True)
    monthly_inhand_salary = models.FloatField(null=True)
    num_bank_accounts = models.FloatField(null=True)
    num_credit_card = models.FloatField(null=True)
    num_of_loan = models.FloatField(null=True)
    num_credit_inquiries = models.FloatField(null=True)
    credit_history_age = models.FloatField(null=True)
    amount_invested_monthly = models.FloatField(null=True)
    payment_behaviour = models.CharField(max_length=50)
    monthly_balance = models.FloatField(null=True)
    password = models.BinaryField()
    access_token = models.TextField()


class History(models.Model):
    id = models.AutoField(primary_key=True)
    user = models.ForeignKey(Users, on_delete=models.CASCADE)
    status = models.CharField()
    created_at = models.DateTimeField(editable=False, auto_now_add=True, null=True)
    updated_at = models.DateTimeField(auto_now=True, null=True)
    credit_amount = models.FloatField(null=True)
    credit_period = models.IntegerField(null=True)
    payment_per_month = models.FloatField(null=True)
    pure_amount = models.FloatField(null=True)
    course = models.FloatField(null=True)
    pure_currency_name = models.CharField()
