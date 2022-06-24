from django.contrib import admin
from meditationsessions import models


class MeditationSessionAdmin(admin.ModelAdmin):
    list_display = [
        'user',
        'timer',
        'start',
        'end',
        'total_duration',
        'created_at',
    ]


admin.site.register(models.MeditationSession, MeditationSessionAdmin)
