import uuid

from django.db import models

from users.models import CustomUser


class MeditationSession(models.Model):
    id = models.UUIDField(
        primary_key=True,
        editable=False,
        default=uuid.uuid4
    )
    user = models.ForeignKey(CustomUser, on_delete=models.CASCADE, related_name="meditation_sessions")
    timer = models.IntegerField()
    start = models.DateTimeField()
    end = models.DateTimeField()
    total_duration = models.IntegerField()
    created_at = models.DateTimeField(auto_now_add=True)
