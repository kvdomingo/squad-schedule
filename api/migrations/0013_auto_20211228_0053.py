# Generated by Django 3.2.10 on 2021-12-27 16:53

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0012_auto_20210926_2233'),
    ]

    operations = [
        migrations.AlterModelOptions(
            name='birthday',
            options={'ordering': ['date__month', 'date__day']},
        ),
        migrations.AlterModelOptions(
            name='event',
            options={'ordering': ['date', 'group', 'name']},
        ),
    ]