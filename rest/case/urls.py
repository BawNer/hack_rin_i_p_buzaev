from django.urls import path
from . import views

urlpatterns = [
    path('register/', views.registration),
    path('login/', views.login),
    path('currency/', views.currency),
    path('user/', views.user_info),
    path('hold/', views.loan_application),
    path('hold/<int:index>/', views.loan_index_application),
]
