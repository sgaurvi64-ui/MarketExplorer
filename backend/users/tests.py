from django.contrib.auth.models import User
from rest_framework import status
from rest_framework.test import APITestCase


class UserRegistrationTests(APITestCase):
    def test_register_user_creates_profile_without_captcha(self):
        response = self.client.post(
            '/api/users/register/',
            {
                'username': 'trader001',
                'name': 'Trader One',
                'first_name': 'Trader',
                'last_name': 'One',
                'email': 'trader@example.com',
                'firebase_uid': 'firebase-uid-123',
            },
            format='json',
        )

        self.assertEqual(response.status_code, status.HTTP_201_CREATED)
        self.assertEqual(response.data['user']['username'], 'trader001')
        self.assertTrue(User.objects.filter(username='trader001').exists())

    def test_register_user_updates_existing_user(self):
        User.objects.create(
            username='trader001',
            email='old@example.com',
            first_name='Old',
            last_name='Name',
        )

        response = self.client.post(
            '/api/users/register/',
            {
                'username': 'trader001',
                'name': 'Trader One',
                'first_name': 'Trader',
                'last_name': 'One',
                'email': 'trader@example.com',
            },
            format='json',
        )

        self.assertEqual(response.status_code, status.HTTP_200_OK)
        user = User.objects.get(username='trader001')
        self.assertEqual(user.email, 'trader@example.com')
        self.assertEqual(user.first_name, 'Trader')
