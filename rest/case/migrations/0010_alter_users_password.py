# Generated by Django 4.2.7 on 2023-11-25 11:47

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('case', '0009_users_credit_history_age_alter_users_password'),
    ]

    operations = [
        migrations.AlterField(
            model_name='users',
            name='password',
            field=models.BinaryField(),
        ),
    ]
