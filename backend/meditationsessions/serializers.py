from rest_framework import serializers
from meditationsessions import models


class MeditationSessionsSerializer(serializers.ModelSerializer):
    user = serializers.ReadOnlyField(source='user.username')

    class Meta:
        model = models.MeditationSession
        fields = '__all__'
