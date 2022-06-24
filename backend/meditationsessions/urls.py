from django.urls import path

from meditationsessions import views

urlpatterns = [
    path('sessions/', views.MeditationSessionCreateListAPI.as_view(), name='sessions'),
]
