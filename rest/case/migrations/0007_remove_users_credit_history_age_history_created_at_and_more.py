# Generated by Django 4.2.7 on 2023-11-25 09:01

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('case', '0006_alter_users_created_at'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='users',
            name='credit_history_age',
        ),
        migrations.AddField(
            model_name='history',
            name='created_at',
            field=models.DateTimeField(auto_now_add=True, null=True),
        ),
        migrations.AddField(
            model_name='history',
            name='credit_score',
            field=models.FloatField(null=True),
        ),
        migrations.AddField(
            model_name='history',
            name='updated_at',
            field=models.DateTimeField(auto_now=True, null=True),
        ),
        migrations.AlterField(
            model_name='history',
            name='user',
            field=models.ForeignKey(default=models.AutoField(primary_key=True, serialize=False), on_delete=django.db.models.deletion.PROTECT, to='case.users'),
        ),
    ]