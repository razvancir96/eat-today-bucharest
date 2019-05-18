FROM mysql:5.7
ENV MY_SQL_ROOT_PASSWORD root
ENV MY_SQL_USER razvan
ENV MY_SQL_PASSWORD razvan
ADD proiect.sql /docker-entrypoint-initdb.d
EXPOSE 3306
