from rest_framework import serializers
from .models import Users, History


class HistorySerializer(serializers.ModelSerializer):
    user = serializers.PrimaryKeyRelatedField(queryset=Users.objects.all())

    class Meta:
        model = History
        fields = '__all__'
