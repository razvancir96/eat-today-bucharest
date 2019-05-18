drop database if exists bd2;
create database bd2;
use bd2;

#tables
create table restaurant(
	id int primary key auto_increment,
    rname varchar(50) not null,
    address varchar(100) not null,
    phone char(10) not null, 
    email varchar(50),
    logo varchar(1000)
);


create table employee(
	id int primary key auto_increment,
    ename varchar(40) not null,
    esurname varchar(40) not null,
    job varchar(40) not null,
    hiredate date,
    is_admin tinyint default 0,
    photo varchar(255) default 'https://acs.curs.pub.ro/2018/theme/image.php/boost/core/1539156858/u/f1',
    id_restaurant int not null,
    foreign key fk_emp (id_restaurant)
    references restaurant(id)
    on delete cascade
);


# drop table todays_menu;
create table todays_menu(
	id int primary key auto_increment,
    deadline date,
    start_hour time,
    end_hour time,
    soup varchar(50),
    main_course varchar(50),
    side varchar(50),
    salad varchar(50),
    dessert varchar(50),
    drink varchar(50),
    price float(3,1),
    is_mixed tinyint default 0,
    id_restaurant int not null,
    foreign key fk_tm (id_restaurant)
    references restaurant(id)
    on delete cascade
);

# drop table product;
create table product(
	id int primary key auto_increment,
    pname varchar(100) not null,
    category enum('Supa','Starter', 'Fel principal', 'Garnitura', 'Salata', 'Bautura', 'Altele') not null,
    quantity int,
    price float(7, 1) not null,
    tags varchar(200),
    id_restaurant int not null,
    foreign key fk_prod (id_restaurant)
    references restaurant(id)
    on delete cascade
);

# drop table dml_logs;
create table dml_logs(
	id int primary key auto_increment,
    message varchar(700) not null,
    date_dml timestamp not null
);

# disable safe updates
SET SQL_SAFE_UPDATES = 0;

# triggers to complete dml_logs

# set @test = concat( ifnull(null, 'null'), 'eo');
# select @test;

# trigger for insert
# drop trigger insert_log;
delimiter //
create trigger insert_log after insert on todays_menu for each row
begin
	declare v_text varchar(300);
    declare v_line varchar(200);
    declare v_message varchar(500);
    set v_text = 'Inserted for (id, deadline, start_hour, end_hour, soup, main_course, side, salad, dessert, drink, price, is_mixed, id_restaurant) values: ';
    set v_line = concat_ws(', ', new.id, ifnull(new.deadline, 'null'), ifnull(new.start_hour, 'null'), ifnull(new.end_hour, 'null'),
						ifnull(new.soup, 'null'), ifnull(new.main_course, 'null'), ifnull(new.side, 'null'), ifnull(new.salad, 'null'),
                        ifnull(new.dessert, 'null'), ifnull(new.drink, 'null'), ifnull(new.price, 'null'), ifnull(new.is_mixed, 'null'),
                        ifnull(new.id_restaurant, 'null'));
    set v_message = concat(v_text, v_line);
    insert into dml_logs
		values(null, v_message, current_timestamp());
end;
//
delimiter ; 

# trigger for update
# drop trigger update_log;
delimiter //
create trigger update_log after update on todays_menu for each row
begin
	declare v_text varchar(300);
    declare v_old_line varchar(200);
    declare v_new_line varchar(200);
    declare v_message varchar(700);
    set v_text = 'Updated (id, deadline, start_hour, end_hour, soup, main_course, side, salad, dessert, drink, price, is_mixed, id_restaurant)';
    set v_new_line = concat_ws(', ', new.id, ifnull(new.deadline, 'null'), ifnull(new.start_hour, 'null'),ifnull(new.end_hour, 'null'),
						ifnull(new.soup, 'null'), ifnull(new.main_course, 'null'), ifnull(new.side, 'null'), ifnull(new.salad, 'null'),
                        ifnull(new.dessert, 'null'), ifnull(new.drink, 'null'), ifnull(new.price, 'null'), ifnull(new.is_mixed, 'null'),
                        ifnull(new.id_restaurant, 'null'));
    set v_old_line = concat_ws(', ', old.id, ifnull(old.deadline, 'null'), ifnull(old.start_hour, 'null'), ifnull(old.end_hour, 'null'),
						ifnull(old.soup, 'null'), ifnull(old.main_course, 'null'), ifnull(old.side, 'null'), ifnull(old.salad, 'null'),
                        ifnull(old.dessert, 'null'), ifnull(old.drink, 'null'), ifnull(old.price, 'null'), ifnull(old.is_mixed, 'null'),
                        ifnull(old.id_restaurant, 'null'));
    set v_message = concat(v_text, ' old line: ' ,v_old_line, ' became new line: ', v_new_line);
    insert into dml_logs
		values(null, v_message, current_timestamp());
end;
//
delimiter ; 

# trigger for delete
# drop trigger delete_log;
delimiter //
create trigger delete_log after delete on todays_menu for each row
begin
	declare v_text varchar(300);
    declare v_line varchar(200);
    declare v_message varchar(500);
    set v_text = 'Deleted for (id, deadline, start_hour, end_hour, soup, main_course, side, salad, dessert, drink, price, is_mixed, id_restaurant) values: ';
    set v_line = concat_ws(', ', old.id, ifnull(old.deadline, 'null'), ifnull(old.start_hour, 'null'), ifnull(old.end_hour, 'null'), 
					ifnull(old.soup, 'null'), ifnull(old.main_course, 'null'), ifnull(old.side, 'null'), ifnull(old.salad, 'null'), 
					ifnull(old.dessert, 'null'), ifnull(old.drink, 'null'), ifnull(old.price, 'null'), ifnull(old.is_mixed, 'null'), 
					ifnull(old.id_restaurant, 'null'));
    set v_message = concat(v_text, v_line);
    insert into dml_logs
		values(null, v_message, current_timestamp());
end;
//
delimiter ; 

# truncate dml_logs;

# restaurants insertion
# truncate restaurant;
insert into restaurant
values(null, 'Stadio', 'Ion Campineanu 11', '0731333311', 'contact@stadio.ro', 'http://horaromania.org/wp-content/uploads/2017/09/Stadio.jpg'),
	(null, 'Simbio', 'Strada Negustori 26', '0756746246', 'rezervari@simbiokb.ro', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRSCtGuWU4oi5kmgaePdnGDs3VlPLoHrQ2f_KDLJ3ag-KQr6SBi'),
    (null, 'Trattoria Buongiorno', 'Covaci 6', '0799402306', 'office@centrulistoric@citygrill.ro', 'http://www.festivalitalian.ro/2016/2016/wp-content/uploads/2015/05/buongiorno1.png'),
    (null, 'Lente', 'Arcului 8', '0212109696', null, 'https://i1.wp.com/www.saveorcancel.tv/wp-content/uploads/2017/06/logo_lupu-e1497020370703.png?resize=500%2C492');
    
    
# employees insertion
# truncate employee;
insert into employee
		# for first restaurant
values(null, 'Popescu', 'Ionel', 'Manager', null, 1, default, 1),
	(null, 'Duroaia', 'Dan', 'Chef', null, 0, default, 1),
    (null, 'Criste', 'Mihai', 'Ospatar', null, 0, default, 1),
    (null, 'Buldur', 'Radu', 'Ospatar', null, 0, default, 1),
    # for second restaurant
    (null, 'Ionescu', 'Tudor', 'Manager', null, 1, default, 2),
    (null, 'Gradinaru', 'Catalin', 'Chef', null, 0, default, 2),
    (null, 'Dumitrascu', 'Daniel', 'Ospatar', null, 0, default, 2),
    (null, 'Stoenete', 'Catalin', 'Ospatar', null, 0, default, 2),
    # for third restaurant
    (null, 'Tanase', 'Radu', 'Manager', null, 1, default, 3),
    (null, 'Cate', 'Lucian', 'Chef', null, 0, default, 3),
    (null, 'Dobinda', 'Tudor', 'Ospatar', null, 0, default, 3),
    (null, 'Moldovan', 'Alexandru', 'Ospatar', null, 0, default, 3),
    # for fourth restaurant
    (null, 'Moldoveanu', 'Ion', 'Manager', null, 1, default, 4),
    (null, 'Patras', 'Octavian', 'Chef', null, 0, default, 4),
    (null, 'Bercu', 'Bogdan', 'Ospatar', null, 0, default, 4),
    (null, 'Mircea', 'Vlad', 'Ospatar', null, 0, default, 4);

# todays menus insertion
# truncate todays_menu;
insert into todays_menu
values (null, null, '12:00:00', '16:00:00', 'Supa crema de ciuperci', 'Snitel de pui', 'Piure', null, null, null, 23.9, 0, 1),
	(null, current_date(), '12:00:00', '15:00:00', 'Supa de pui cu taitei', 'Tocanita', 'Mamaliguta', null, null, null, 18.0, 0, 2),
    (null, null, '12:00:00', '16:00:00', 'Ciorba de perisoare', 'Cotlet de porc', 'Cartofi wedges', 'Salata de varza', null, 'Apa plata', 22.3, 0, 3),
    (null, null, '12:00:00', '16:00:00', null, 'Pui asiatic', 'Noodles', null, 'Negresa', null, 19.2, 0, 4);
    
#products insertion
# truncate product;
insert into product
# first restaurant
	# Soup
values (null, 'Bors de pui', 'Supa', 250, 12, null, 1),
	(null, 'Crema de legume', 'Supa', 300, 12, null, 1),
    (null, 'Ciorba de vacuta', 'Supa', 275, 13, null, 1),
    # Starter
    (null, 'Bruschete cu rosii si masline', 'Starter', 200, 14, null, 1),
    (null, 'Hummus', 'Starter', 200, 15, null, 1),
    # Fel principal
    (null, 'Snitel de pui reinterpretat', 'Fel principal', 250, 30, null, 1),
    (null, 'Piept de pui la gratar', 'Fel principal', 300, 19, null, 1),
    (null, 'Spaghete carbonara', 'Fel principal', 400, 29, null, 1),
    # Garnitura
    (null, 'Orez sarbesc', 'Garnitura', 200, 10, null, 1),
    (null, 'Cartofi copti cu rozmarin', 'Garnitura', 200, 9, null, 1),
    (null, 'Legume la cuptor', 'Garnitura', 200, 8, null, 1),
    # Salata
    (null, 'Salata de varza', 'Salata', 150, 8, null, 1),
    (null, 'Salata de rosii', 'Salata', 150, 8, null, 1),
    # Bautura
    (null, 'Apa plata', 'Bautura', 330, 8, null, 1),
    (null, 'Sprite', 'Bautura', 330, 8, null, 1),
    (null, 'Bere Heineken', 'Bautura', 400, 9, null, 1),
# second restaurant
	# Soup
	(null, 'Supa de pui cu taitei', 'Supa', 250, 10, null, 2),
	(null, 'Crema de linte', 'Supa', 250, 10, null, 2),
    (null, 'Ciorba de perisoare', 'Supa', 300, 10, null, 2),
    # Starter
    (null, 'Bruschete cu avocado si rosii', 'Starter', 250, 15, null, 2),
    (null, 'Halloumi grill', 'Starter', 200, 23, null, 2),
    # Fel principal
    (null, 'Snitel de pui Simbio', 'Fel principal', 350, 25, null, 2),
    (null, 'Muschi de porc impletit', 'Fel principal', 300, 21, null, 2),
    (null, 'Tagliatele cu somon fume', 'Fel principal', 450, 32, null, 2),
    # Garnitura
    (null, 'Orez basmati', 'Garnitura', 200, 9, null, 2),
    (null, 'Cartofi wedges', 'Garnitura', 200, 9, null, 2),
    (null, 'Cartofi frantuzesti', 'Garnitura', 200, 10, null, 2),
    # Salata
    (null, 'Salata de varza', 'Salata', 150, 7, null, 2),
    (null, 'Salata Caesar', 'Salata', 350, 8, null, 2),
    # Bautura
    (null, 'Apa plata', 'Bautura', 500, 7, null, 2),
    (null, 'Coca Cola', 'Bautura', 330, 8, null, 2),
    (null, 'Bere Ciuc', 'Bautura', 400, 8, null, 2),
# third restaurant
	(null, 'Ciorba de pui', 'Supa', 300, 9, null, 3),
    (null, 'Ciorba de vacuta', 'Supa', 300, 9, null, 3),
    # Fel principal
    (null, 'Pulpa de pui', 'Fel principal', 300, 18, null, 3),
    (null, 'Cotlet de porc', 'Fel principal', 300, 20, null, 3),
    (null, 'Muschi de vita', 'Fel principal', 300, 36, null, 3),
    (null, 'Salau', 'Fel principal', 300, 26, '#peste', 3),
    # Garnitura
    (null, 'Orez cu ciuperci', 'Garnitura', 250, 8, null, 3),
    (null, 'Cartofi prajiti', 'Garnitura', 250, 8, null, 3),
    (null, 'Mamaliga', 'Garnitura', 250, 7, null, 3),
    # Salata
    (null, 'Salata de muraturi', 'Salata', 150, 6, null, 3),
    (null, 'Salata de varza asortata', 'Salata', 150, 6, null, 3),
    # Bautura
    (null, 'Apa plata', 'Bautura', 500, 7, null, 3),
    (null, 'Fanta', 'Bautura', 500, 7, null, 3),
    (null, 'Bere Carlsberg', 'Bautura', 500, 9, null, 3),
    (null, 'Vin alb', 'Bautura', 150, 12, null, 3),
# fourth restaurant
	(null, 'Supa asiatica de fructe de mare', 'Supa', 250, 20, null, 4),
	(null, 'Supa crema de porumb', 'Supa', 250, 15, null, 4),
    (null, 'Supa toscana cu ciuperci si pui', 'Supa', 250, 15, null, 4),
    # Starter
    (null, 'Couscous cu rosii urcate', 'Starter', 300, 27, null, 4),
    (null, 'Quesadilla de vita', 'Starter', 400, 35, null, 4),
    # Fel principal
    (null, 'Lasagna', 'Fel principal', 400, 32, null, 4),
    (null, 'Burger Maestro', 'Fel principal', 400, 38, '#gorgonzola#ceapacaramelizata#jalapeno', 4),
    (null, 'Piept de curcan in sos de afine', 'Fel principal', 350, 28, null, 4),
    (null, 'Pui picant', 'Fel principal', 300, 24, '#chinezesc', 4),
    # Peste (tot fel principal da' cu tag)
    (null, 'Dorada', 'Fel principal', 400, 30, '#peste', 4),
    (null, 'Salau Meuniere', 'Fel principal', 400, 30, '#peste', 4),
    # Garnitura
    (null, 'Cartofi natur condimentati', 'Garnitura', 250, 10, null, 4),
    (null, 'Orez chinezesc cu ou si legume', 'Garnitura', 250, 9, null, 4),
    (null, 'Cartofi dulci', 'Garnitura', 250, 12, null, 4),
    # Bautura
    (null, 'Apa plata Evian', 'Bautura', 500, 12, null, 4),
    (null, 'Gin tonic', 'Bautura', 250, 22, null, 4),
    (null, 'Bere Edelweiss', 'Bautura', 500, 15, null, 4);
    
# inspect our tables, including the one written by the triggers
/*
select * from restaurant;
select * from todays_menu;
select * from employee;
select * from product;
select * from dml_logs;
*/

# we copy the structure of the daily menu
create table todays_menu_copy as select * from todays_menu LIMIT 0;
alter table todays_menu_copy change id id int primary key auto_increment;


# drop procedure filter_tm_price;
delimiter //
create procedure filter_tm_price(in p_price float(8,2), in p_start_hour time, in p_end_hour time,
					in p_has_soup tinyint, in p_has_dessert tinyint, in p_has_drink tinyint,
					in p_soup varchar(50), in p_main_course varchar(50), in p_dessert varchar(50), in p_drink varchar(50), in p_side varchar(50))
begin
	declare v_start_hour time;
    declare v_end_hour time;
    declare v_soup varchar(50);
    declare v_main_course varchar(50);
    declare v_side varchar(50);
    declare v_salad varchar(50);
    declare v_dessert varchar(50);
    declare v_drink varchar(50);
    declare v_price varchar(50);
    declare v_deadline date;
    declare v_id_restaurant int;
    declare v_test varchar(1000);
    # when set to -1, the menu is not what the client requested in his search
    declare v_bad_menu tinyint default 0;
    declare ok tinyint default 0;
    # cursor that filters by price and interval between hours
	declare c1 cursor for select deadline, start_hour, end_hour, soup, main_course, side, salad, dessert, drink, price, id_restaurant
						from todays_menu
                        where price <= p_price
                        and (start_hour <= p_start_hour or end_hour >= p_end_hour);
	declare continue handler for not found
    begin
		set ok = 1;
    end;
    
    # we truncate the temporary table
    truncate todays_menu_copy;
    
	# we iterate through cursor
    open c1;
    bucla: loop
		# retrieve information
		fetch c1 into v_deadline, v_start_hour, v_end_hour, v_soup, v_main_course, v_side, v_salad, v_dessert, v_drink, v_price, v_id_restaurant;
		# leaving condition
        if ok = 1 then
			leave bucla;
		end if;
        # reinitialize v_bad_menu
        set v_bad_menu = 0;
        # we check if we have soup in the menu
        if p_has_soup = 1 then 
			if v_soup is null then
				set v_bad_menu = -1;
			end if;
        end if;
        # we check if we have drink in the menu
        if p_has_drink = 1 then
			if v_drink is null then
				set v_bad_menu = -1;
			end if;
        end if;
        # we check if we have dessert in the menu 
        if p_has_dessert = 1 then
			if v_dessert is null then
				set v_bad_menu = -1;
			end if;
        end if;
        # we check if we have a specified soup 
        if p_soup <> '' then
			# if we do not have the required soup  
			if (locate(lower(p_soup), lower(v_soup)) = 0) or (v_soup is null) then 
				set v_bad_menu = -1;
			end if;
		end if;
        # we check if we have a specified main course
        if p_main_course <> '' then
			# if we do not have the required soup 
			if (locate(lower(p_main_course), lower(v_main_course)) = 0) or (v_main_course is null) then 
				set v_bad_menu = -1;
			end if;
        end if;
        # we check if we have a specified dessert
        if p_dessert <> '' then
			# if we do not have the required dessert 
			if (locate(lower(p_dessert), lower(v_dessert)) = 0) or (v_dessert is null) then 
				set v_bad_menu = -1;
			end if;
        end if;
        # we check if we have a specified drink
        if p_drink <> '' then
			# if we do not have the required drink 
			if (locate(lower(p_drink), lower(v_drink)) = 0) or (v_drink is null) then 
				set v_bad_menu = -1;
			end if;
        end if;
        # we check if we have a specified side
        if p_side <> '' then
			# if we do not have the required side
			if (locate(lower(p_side), lower(v_side)) = 0) or (v_side is null) then 
				set v_bad_menu = -1;
			end if;
        end if;
        
        # if all the conditions have been met, we insert the line in the temporary table
        if v_bad_menu = 0 then
			insert into todays_menu_copy
			values (null, v_deadline, v_start_hour, v_end_hour, v_soup, v_main_course, v_side, v_salad, v_dessert, v_drink, v_price, null, v_id_restaurant);
        end if;
        
    end loop bucla;
    close c1;
    
    select * from todays_menu_copy;
    
end;
//
delimiter ;

# call filter_tm_price(25, '16:00:00', '12:00:00', 0, 0, 0, '', 'pui', '', '', '' );


# accidentally inserted a line
# delete from todays_menu where id=5;

# just testing
# select deadline, start_hour, end_hour, soup, main_course, side, salad, dessert, drink, price, id_restaurant
#						from todays_menu
#                        where price <= 25
#                        and (start_hour <= '10:00:00'or end_hour >= '16:00:00');



# to show available todays_menus
delimiter //
create procedure todays_menu_list()
begin
	select * from todays_menu;
end;
//
delimiter ; 

# to show available restaurants
delimiter //
create procedure restaurant_list()
begin
	select * from restaurant;
end;
//
delimiter ; 

# call restaurant_list();

# procedure to get a specific restaurant
delimiter //
create procedure get_restaurant_by_id(in p_id int)
begin
	select * from restaurant
    where id = p_id;
end;
//
delimiter ;

# call get_restaurant_by_id(1);

# procedure to get products for a specific restaurant
delimiter //
create procedure get_restaurant_products(in p_id_restaurant int)
begin
	select * from product
    where id_restaurant = p_id_restaurant;
end;
//
delimiter ;

# call get_restaurant_products(1);

# function that verifies if a restaurant has starters
delimiter //
create function starters_number(p_id_restaurant int)
returns int
begin
	declare v_nr_starter int;
	select count(pname) nr_starter
		into v_nr_starter
    from product
    where id_restaurant = p_id_restaurant
    and lower(category) = 'starter';
    return v_nr_starter;
end;
//
delimiter ;

# select starters_number(2);

# procedure that uses function to show starters
delimiter //
create procedure get_restaurant_starters(in p_id_restaurant int)
begin
	declare v_starter_nr int;
    set v_starter_nr = starters_number(p_id_restaurant);
	select * from product
    where id_restaurant = p_id_restaurant
    and lower(category) = 'starter'
    and v_starter_nr <> 0;
end;
//
delimiter ;

# call get_restaurant_starters(2);

# function that verifies if a restaurant has soups
# drop function soup_number;
delimiter //
create function soup_number(p_id_restaurant int)
returns int
begin
	declare v_nr_soup int;
	select count(pname) nr_soup
		into v_nr_soup
    from product
    where id_restaurant = p_id_restaurant
    and lower(category) = 'supa';
    return v_nr_soup;
end;
//
delimiter ;

# select soup_number(2);

# procedure that uses function to show soups
# drop procedure get_restaurant_soups;
delimiter //
create procedure get_restaurant_soups(in p_id_restaurant int)
begin
	declare v_soup_nr int;
    set v_soup_nr = soup_number(p_id_restaurant);
	select * from product
    where id_restaurant = p_id_restaurant
    and lower(category) = 'supa'
    and v_soup_nr <> 0;
end;
//
delimiter ;

# call get_restaurant_soups(2);

# procedure to get employee info
# drop procedure employee_list;
delimiter //
create procedure employee_list(in p_id_restaurant int)
begin
	select * from employee
    where id_restaurant = p_id_restaurant;
end;
//
delimiter ; 

# select * from dml_logs;