from django.contrib import admin
from .models import UserProfile


@admin.register(UserProfile)
class UserProfileAdmin(admin.ModelAdmin):
    list_display = ('display_name', 'user', 'virtual_balance', 'is_demo_account', 'updated_at')
    search_fields = ('display_name', 'user__username', 'user__email')
