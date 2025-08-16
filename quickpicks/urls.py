from django.urls import path
from .views import quick_pick_view

urlpatterns = [
    path('', quick_pick_view, name= 'quickpicks')
]