from django.urls import path
from . import views

app_name = 'restaurants'

urlpatterns = [
    path('', views.index, name='index'),
    path('<int:restaurant_id>/', views.restaurant_details, name='restaurant_details'),
    path('search_tm/', views.search_form, name='search_form'),
    path('search_tm/filtered_tm', views.filtered_tm, name='filtered_tm'),
    path('todays_menus/', views.todays_menu, name='todays_menus'),
    path('restaurants/', views.restaurants, name='restaurants'),
    path('staff/<int:restaurant_id>/', views.show_employees, name='staff_details')
]
