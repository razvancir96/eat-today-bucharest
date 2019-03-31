from django.shortcuts import render
from .models import Restaurant, Product, TodaysMenu, Employee
from .forms import SearchForm

# Create your views here.


def index(request):
    results = Restaurant.show_restaurants()
    return render(request, 'restaurants/index.html', {'results': results})


def restaurant_details(request, restaurant_id):
    results = Restaurant.show_restaurant_detail(restaurant_id)
    soup_results = Product.get_restaurant_soups(restaurant_id)
    starter_results = Product.get_restaurant_starters(restaurant_id)
    product_results = Product.show_restaurant_products(restaurant_id)
    return render(request, 'restaurants/restaurant_details.html',
                  {'results': results,
                   'product_results': product_results,
                   'soup_results': soup_results,
                   'starter_results': starter_results})


def search_form(request):
    # this form is for GET method
    form = SearchForm()
    return render(request, 'restaurants/magic_form.html', {'form': form})


def filtered_tm(request):
    # we parse the data posted by the form
    if request.method == 'POST':
        form = SearchForm(request.POST)
        if form.is_valid():
            # we get the posted price and set default value
            price = form.cleaned_data['price']
            if price is None:
                global price
                price = 1000
            # we get the posted start_hour and set default value
            start_hour = form.cleaned_data['start_hour']
            if start_hour is None:
                global start_hour
                start_hour = '20:00:00'
            else:
                start_hour = str(start_hour) + ':00:00'
            # we get the posted end_hour and set default value
            end_hour = form.cleaned_data['end_hour']
            if end_hour is None:
                global end_hour
                end_hour = '10:00:00'
            else:
                end_hour = str(end_hour) + ':00:00'
            # we get the choice having soup in the menu
            has_soup = form.cleaned_data['has_soup']
            if has_soup is True:
                global has_soup
                has_soup = 1
            else:
                global has_soup
                has_soup = 0
            # we get the choice having drink in the menu
            has_drink = form.cleaned_data['has_drink']
            if has_drink is True:
                global has_drink
                has_drink = 1
            else:
                global has_drink
                has_drink = 0
            # we get the choice having drink in the menu
            has_dessert = form.cleaned_data['has_dessert']
            if has_dessert is True:
                global has_dessert
                has_dessert = 1
            else:
                global has_dessert
                has_dessert = 0
            # we parse data from soup, main_course, side, dessert and drink
            soup = form.cleaned_data['soup']
            side = form.cleaned_data['side']
            dessert = form.cleaned_data['dessert']
            drink = form.cleaned_data['drink']
            main_course = form.cleaned_data['main_course']
            if soup is None:
                global soup
                soup = ''
            if main_course is None:
                global main_course
                main_course = ''
            if side is None:
                global side
                side = ''
            if dessert is None:
                global dessert
                dessert = ''
            if drink is None:
                global drink
                drink = ''
            # we get the filtered menus, using our stored procedure
            print(price, has_soup, soup)
            todays_menus = TodaysMenu.show_filtered_tm(price, start_hour, end_hour, has_soup, has_dessert, has_drink,
                                                       soup, main_course, dessert, drink, side)
            restaurant_info = Restaurant.show_restaurants()
            return render(request, 'restaurants/filtered_tm.html', {'todays_menus': todays_menus,
                                                                    'restaurant_info': restaurant_info})
    else:
        return render(request, 'restaurants/filtered_tm.html')


def todays_menu(request):
    todays_menus = TodaysMenu.show_todays_menu()
    restaurant_info = Restaurant.show_restaurants()
    return render(request, 'restaurants/filtered_tm.html', {'todays_menus': todays_menus,
                                                            'restaurant_info': restaurant_info})


def restaurants(request):
    results = Restaurant.show_restaurants()
    return render(request, 'restaurants/restaurants.html', {'results': results})


def show_employees(request, restaurant_id):
    employees = Employee.show_employees(restaurant_id)
    return render(request, 'restaurants/staff.html', {'employees': employees})
