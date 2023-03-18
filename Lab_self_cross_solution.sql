/*lab-sql-self-cross-join*/
/*Luis*/
use sakila;

##Q1
select 
fa1.actor_id
,a.first_name as 'FistName_actor1'
,a.last_name as 'LastName_actor1'
,fa2.actor_id
,a2.first_name as 'FistName_actor2'
,a2.last_name as 'LastName_actor2'

from film_actor fa1 #Join
	inner join film_actor fa2 #self join on film_id and different actor id. Gives the films and the different actors in each film. 
		on fa1.film_id=fa2.film_id 
			and fa1.actor_id<>fa2.actor_id
	inner join actor a	#join to get the names for actor 1
		on fa1.actor_id=a.actor_id
	inner join actor a2 #join to get the names for actor 2
		on fa2.actor_id=a2.actor_id
;
##Q2
select 
	distinct r1.customer_id
    , i1.film_id
    , count(*) as 'num_rentals'
    , r2.customer_id
    #, i2.film_id
    #, count(i2.film_id)
from rental r1
	inner join rental r2
		on r1.customer_id<r2.customer_id and # Get all possible combinations for 2 customers. 23-45 is the same as 45-23
        r2.inventory_id=r1.inventory_id #Rental customer1 =rental customer 2
	inner join inventory i1 
		on r1.inventory_id=i1.inventory_id #Join the films id
group by r1.customer_id, i1.film_id, r2.customer_id#, i2.film_id
having num_rentals>1 #There is only one pais of customers that rented the same film and they have rent it in total only 2 times
;

##Q3
select 
	distinct f.film_id
	, a.actor_id
from film f
	cross join actor a #Cross Join to get all distinct combination between films and actors. 
;
