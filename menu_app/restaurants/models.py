from django.db import models

# Create your models here.

# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Make sure each ForeignKey has `on_delete` set to the desired behavior.
#   * Remove `managed = False` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
from django.db import models
from django.db import connection


class DmlLogs(models.Model):
    message = models.CharField(max_length=700)
    date_dml = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'dml_logs'


class Employee(models.Model):
    ename = models.CharField(max_length=40)
    esurname = models.CharField(max_length=40)
    job = models.CharField(max_length=40)
    hiredate = models.DateField(blank=True, null=True)
    is_admin = models.IntegerField(blank=True, null=True)
    id_restaurant = models.ForeignKey('Restaurant', models.DO_NOTHING, db_column='id_restaurant')
    photo = models.CharField(max_length=1000)

    class Meta:
        managed = False
        db_table = 'employee'

    @staticmethod
    def show_employees(p_restaurant_id):
        # create a cursor
        cur = connection.cursor()
        # execute the stored procedure passing in
        # the parameter
        cur.callproc('employee_list', [p_restaurant_id, ])
        # grab the results
        results = cur.fetchall()
        cur.close()
        # wrap the results up into Restaurant domain objects
        return [Employee(*row) for row in results]


class Product(models.Model):
    pname = models.CharField(max_length=100)
    category = models.CharField(max_length=13)
    quantity = models.IntegerField(blank=True, null=True)
    price = models.FloatField()
    tags = models.CharField(max_length=200, blank=True, null=True)
    id_restaurant = models.ForeignKey('Restaurant', models.DO_NOTHING, db_column='id_restaurant')

    class Meta:
        managed = False
        db_table = 'product'

    @staticmethod
    def show_restaurant_products(p_restaurant_id):
        # create a cursor
        cur = connection.cursor()
        # execute the stored procedure passing in
        # the parameter
        cur.callproc('get_restaurant_products', [p_restaurant_id, ])
        # grab the results
        results = cur.fetchall()
        cur.close()
        # wrap the results up into Restaurant domain objects
        return [Product(*row) for row in results]

    @staticmethod
    def get_restaurant_starters(p_restaurant_id):
        # create a cursor
        cur = connection.cursor()
        # execute the stored procedure passing in
        # the parameter
        cur.callproc('get_restaurant_starters', [p_restaurant_id, ])
        # grab the results
        results = cur.fetchall()
        cur.close()
        # wrap the results up into Restaurant domain objects
        return [Product(*row) for row in results]

    @staticmethod
    def get_restaurant_soups(p_restaurant_id):
        # create a cursor
        cur = connection.cursor()
        # execute the stored procedure passing in
        # the parameter
        cur.callproc('get_restaurant_soups', [p_restaurant_id, ])
        # grab the results
        results = cur.fetchall()
        cur.close()
        # wrap the results up into Restaurant domain objects
        return [Product(*row) for row in results]


class Restaurant(models.Model):
    rname = models.CharField(max_length=50)
    address = models.CharField(max_length=100)
    phone = models.CharField(max_length=10)
    email = models.CharField(max_length=50, blank=True, null=True)
    logo = models.CharField(max_length=1000, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'restaurant'

    @staticmethod
    def show_restaurants():
        # create a cursor
        cur = connection.cursor()
        # execute the stored procedure passing in
        # the parameter
        cur.callproc('restaurant_list', [])
        # grab the results
        results = cur.fetchall()
        cur.close()
        # wrap the results up into Restaurant domain objects
        return [Restaurant(*row) for row in results]

    @staticmethod
    def show_restaurant_detail(p_restaurant_id):
        # create a cursor
        cur = connection.cursor()
        # execute the stored procedure passing in
        # the parameter
        cur.callproc('get_restaurant_by_id', [p_restaurant_id, ])
        # grab the results
        results = cur.fetchall()
        cur.close()
        # wrap the results up into Restaurant domain objects
        return [Restaurant(*row) for row in results]


class TodaysMenu(models.Model):
    deadline = models.DateField(blank=True, null=True)
    start_hour = models.TimeField(blank=True, null=True)
    end_hour = models.TimeField(blank=True, null=True)
    soup = models.CharField(max_length=50, blank=True, null=True)
    main_course = models.CharField(max_length=50, blank=True, null=True)
    side = models.CharField(max_length=50, blank=True, null=True)
    salad = models.CharField(max_length=50, blank=True, null=True)
    dessert = models.CharField(max_length=50, blank=True, null=True)
    drink = models.CharField(max_length=50, blank=True, null=True)
    price = models.FloatField(blank=True, null=True)
    is_mixed = models.IntegerField(blank=True, null=True)
    id_restaurant = models.ForeignKey(Restaurant, models.DO_NOTHING, db_column='id_restaurant')

    class Meta:
        managed = False
        db_table = 'todays_menu'

    @staticmethod
    def show_filtered_tm(price, start_hour, end_hour, has_soup, has_dessert, has_drink,
                         soup, main_course, dessert, drink, side):
        # create a cursor
        cur = connection.cursor()
        # execute the stored procedure passing in
        # the parameter
        cur.callproc('filter_tm_price', [price, start_hour, end_hour, has_soup, has_dessert, has_drink,
                                         soup, main_course, dessert, drink, side])
        # grab the results
        results = cur.fetchall()
        cur.close()
        # wrap the results up into Restaurant domain objects
        return [TodaysMenu(*row) for row in results]

    @staticmethod
    def show_todays_menu():
        # create a cursor
        cur = connection.cursor()
        # execute the stored procedure passing in
        # the parameter
        cur.callproc('todays_menu_list', [])
        # grab the results
        results = cur.fetchall()
        cur.close()
        # wrap the results up into Restaurant domain objects
        return [TodaysMenu(*row) for row in results]


# NU UITA CA AICI S-AR PUTEA SA TREBUIASCA SA FACI NISTE MIGRARI
class TodaysMenuCopy(models.Model):
    deadline = models.DateField(blank=True, null=True)
    start_hour = models.TimeField(blank=True, null=True)
    end_hour = models.TimeField(blank=True, null=True)
    soup = models.CharField(max_length=50, blank=True, null=True)
    main_course = models.CharField(max_length=50, blank=True, null=True)
    side = models.CharField(max_length=50, blank=True, null=True)
    salad = models.CharField(max_length=50, blank=True, null=True)
    dessert = models.CharField(max_length=50, blank=True, null=True)
    drink = models.CharField(max_length=50, blank=True, null=True)
    price = models.FloatField(blank=True, null=True)
    is_mixed = models.IntegerField(blank=True, null=True)
    id_restaurant = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'todays_menu_copy'

