# views.py
from .models import User
from rest_framework.response import Response
from rest_framework.decorators import api_view
from rest_framework_simplejwt.tokens import RefreshToken
from rest_framework import status
import json
from rest_framework_simplejwt.authentication import JWTAuthentication
from rest_framework.permissions import IsAuthenticated
from rest_framework import status, views
from rest_framework.response import Response
from .models import User
from .serializers import UserSerializer

# Helper function to generate JWT token
def get_tokens_for_user(user):
    refresh = RefreshToken.for_user(user)
    return str(refresh.access_token)


def get_tokens_for_user(user):
    refresh = RefreshToken.for_user(user)
    return str(refresh.access_token)

@api_view(['POST'])
def signup(request):
    data = request.data
    email = data.get('email')
    password = data.get('password')
    name = data.get('name')
    role = data.get('role', 'patient')

    if not email or not password or not name:
        return Response({"error": "Email, password, and name are required"},
                        status=status.HTTP_400_BAD_REQUEST)

    if User.objects.filter(username=email).exists():
        return Response({"error": "User already exists"},
                        status=status.HTTP_400_BAD_REQUEST)

    user = User.objects.create_user(
        username=email,
        email=email,
        password=password,
        first_name=name,
        role=role
    )

    token = get_tokens_for_user(user)

    return Response({
        "token": token,
        "user": {
            "id": user.id,
            "name": user.first_name,
            "email": user.email,
            "role": user.role
        }
    }, status=status.HTTP_201_CREATED)


@api_view(['POST'])
def signin(request):
    """
    Sign in existing user and return JWT token with user info
    """
    data = request.data
    email = data.get('email')
    password = data.get('password')

    if not email or not password:
        return Response({"error": "Email and password are required"},
                        status=status.HTTP_400_BAD_REQUEST)

    try:
        user = User.objects.get(username=email)
    except User.DoesNotExist:
        return Response({"error": "Invalid credentials"},
                        status=status.HTTP_401_UNAUTHORIZED)

    if not user.check_password(password):
        return Response({"error": "Invalid credentials"},
                        status=status.HTTP_401_UNAUTHORIZED)

    token = get_tokens_for_user(user)

    # You can get role from profile if you have a profile model

    return Response({
        "token": token,
        "user": {
            "id": user.id,
            "name": user.first_name,
            "email": user.email,
            "role": user.role 
        }
    })

class ProfileView(views.APIView):
    authentication_classes = [JWTAuthentication]
    permission_classes = [IsAuthenticated]  # Ensures the user is authenticated

    def get(self, request):
        # Get the authenticated user from the request
        user = request.user

        # Serialize the user data (you can add more fields if necessary)
        user_data = UserSerializer(user).data

        return Response(user_data, status=status.HTTP_200_OK)
