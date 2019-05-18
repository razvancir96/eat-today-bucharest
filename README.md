# eat-today-bucharest
A dockerized web app that centralizes menus of different restaurants, using Django and MySQL stored procedures.

To run the app you need to have Docker installed.

Clone this repository and change to menu_app folder. Then run the following commands:

- docker-compose build

- docker-compose up -d

- docker-compose run app python manage.py migrate

Then access the following link in your browser:
localhost:8000/restaurants/

If the page is not loading, run the following command:

- docker-compose run -p 8001:8001 app python manage.py runserver 0.0.0.0:8001

Then access the following link in your browser:
localhost:8000/restaurants/


Features:

- Restaurante: Diplays restaurants from the app. Then if you click on each restaurant, their menus are displayed.

- Meniul zilei: Displays special menu offers from the restaurants.

- Cauta meniul zilei ideal: whe clicked, a complex search form is displayed, where you can search through special menu offers easily.

In the Database folder, proiect.sql file is the SQL script that creates and populates the database. It also contains stored procedures. Also, in the same folder, there is the Dockerfile from the mySQL image used in the main app. The image was pushed on Docker hub.

https://cloud.docker.com/u/razvancir96/repository/docker/razvancir96/mysql01
