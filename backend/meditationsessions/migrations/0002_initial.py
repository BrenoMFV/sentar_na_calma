# Generated by Django 4.0.5 on 2022-06-16 17:31

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
        ('meditationsessions', '0001_initial'),
    ]

    operations = [
        migrations.AddField(
            model_name='meditationsession',
            name='user',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='meditation_sessions', to=settings.AUTH_USER_MODEL),
        ),
    ]
