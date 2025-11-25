from django.urls import path
from .views import signup, signin

urlpatterns = [
    path('signup/', signup),
    path('signin/', signin),
    path('profile/', ProfileView.as_view(), name='profile'),
]
