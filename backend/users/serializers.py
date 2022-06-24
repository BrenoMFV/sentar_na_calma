from meditationsessions.models import MeditationSession
from .models import CustomUser, UserProfile
from rest_framework import serializers
from drf_extra_fields.fields import Base64ImageField
from rest_auth.serializers import UserDetailsSerializer


class UserSerializer(UserDetailsSerializer):
    profile_picture = Base64ImageField(required=False)
    meditation_sessions = serializers.PrimaryKeyRelatedField(many=True, queryset=MeditationSession.objects.all())

    class Meta:
        fields = UserDetailsSerializer.Meta.fields + tuple('profile_picture')

    def update(self, instance, validated_data):
        profile_data = validated_data.pop('userprofile', {})
        profile_picture = profile_data.get('profile_picture')

        instance = super(UserSerializer, self).update(instance, validated_data)

        # get and update user profile
        profile = instance.userprofile
        if profile_data and profile_picture:
            profile.profile_picture = profile_picture
            profile.save()
        return instance
