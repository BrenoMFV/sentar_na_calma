from rest_framework import generics, permissions
from .models import MeditationSession
from .serializers import MeditationSessionsSerializer


class MeditationSessionCreateListAPI(generics.ListCreateAPIView):
    queryset = MeditationSession.objects.all()
    serializer_class = MeditationSessionsSerializer
    permission_classes = [permissions.IsAuthenticated]

    def get_queryset(self):
        queryset = super().get_queryset().filter(user=self.request.user).all()
        return queryset

    def perform_create(self, serializer):
        serializer.save(user=self.request.user)
