

# Query  1 For a high-level overview of the hotels, provide us the top 5 most voted hotels in the delivery category

select name ,votes ,rating ,rank1 from (
	SELECT name,votes,rating ,Rank () over( order by votes desc) as rank1 
	FROM gdb041.zomatocleaned_v1 
    WHERE type='delivery') as t 
where rank1<=5;

/* 
Output

name						votes   rating 	rank
Udupi Ruchi Grand			5352	4.2		1
Onesta						6470	4.6		2
Mojo Pizza - 2X Toppings	5448	4.2		3
Corner House Ice Cream		6385	4.3		4
Ayodhya Upachar				5913	4.3		5


 Query 2  The rating of a hotel is a key identifier in determining a restaurant’s performance. 
Hence for a particular location called Banashankari find out the top 5 highly rated hotels in the delivery category.

*/

 Select name,rating  FROM(
	SELECT name,rating,location,type,
	rank() over (order by rating DESC) as rnk
	from gdb041.zomatocleaned_v1
	where location='Banashankari' and type='delivery') t
 where t.rnk<=5;
 
 /* 
 Output 
name						rating
Onesta						4.6
Corner House Ice Cream		4.3
Ayodhya Upachar				4.3
Mojo Pizza - 2X Toppings	4.2
Udupi Ruchi Grand			4.2
Smacznego					4.2
Frozen Bottle				4.2
Cafe Shuffle				4.2
Szechuan Dragon				4.2
*/

# query 3  compare the ratings of the cheapest and most expensive hotels in Indiranagar

select
(SELECT rating from gdb041.zomatocleaned_v1 
where approx_cost=(
	select MIN(approx_cost) from gdb041.zomatocleaned_v1 
    where location= "Indiranagar") 
and location="Indiranagar" )as Rating_of_cheapest_hotel ,
(SELECT rating from gdb041.zomatocleaned_v1 
where approx_cost=(
	select max(approx_cost) from gdb041.zomatocleaned_v1 
    where location= "Indiranagar")
and location="Indiranagar") as rating_of_expensive_hotel;

/*
Output

Rating_of_cheapest_hotel	Rating_of_expensive_hotel
3.7 						4.5

*/

#Query 4 Online ordering of food has exponentially increased over time. 
#Compare the total votes of restaurants that provide online ordering services and those who don’t provide online ordering service.

(Select sum(votes) , online_order 
	FROM gdb041.zomatocleaned_v1 
    WHERE online_order='Yes') 
union all 
(Select sum(votes),online_order 
	FROM gdb041.zomatocleaned_v1  
    WHERE online_order='No') ;

/* 
Output

Total votes		online order
1412577			Yes
852442			No

Query 5 Number of votes defines how much the customers are involved with the service provided by the restaurants 
For each Restaurant type, find out the number of restaurants, total votes, and average rating. 
Display the data with the highest votes on the top( if the first row of output is NA display the remaining rows).

*/


SELECT type,count(name) as number_of_retaurants,sum(votes) as total_votes ,avg(rating) as avg_rating  
FROM gdb041.zomatocleaned_v1 
where type!='NA' 
group by type 
order by total_votes desc;


/*
Output

Type of Restraunt   Number  Votes   Avg_rating	
Delivery			5955	1503467	3.2747103274559244
Dine-out			2162	304520	3.4086956521739085
Cafes				357		196400	3.3369747899159674
Buffet				155		87407	3.652903225806451
Desserts			485		84635	3.446185567010313
Pubs and bars		16		1670	3.9374999999999996
Drinks & nightlife	24		899		3.5625


 
Query 6  What is the most liked dish of the most-voted restaurant on Zomato(as the restaurant has a tie-up with Zomato,
 the restaurant compulsorily provides online ordering and delivery facilities.
 
 */
 
 SELECT name,dish_liked , rating,votes 
 FROM gdb041.zomatocleaned_v1
 where online_order='Yes' and type='delivery'
 order by votes desc 
 limit 1;
 
 
 /*
Output
 name 		dish liked																						rating	votes
 Onesta		Farmhouse Pizza, Chocolate Banana, Virgin Mojito, Pasta, Paneer Tikka, Lime Soda, Prawn Pizza	4.6		6470
 
 
 Query 7 
 To increase the maximum profit, Zomato is in need to expand its business. 
 For doing so Zomato wants the list of the top 15 restaurants which have min 150 votes, have a rating greater than 3, and is currently not providing online ordering.
 Display the restaurants with highest votes on the top.
 */
 
 select name ,rating, votes ,online_order  from(
	SELECT name ,rating, votes ,online_order, rank () over (order by votes desc) as rnk 
	from  gdb041.zomatocleaned_v1
	WHERE votes>150 and rating >3 and online_order='No')t
where t.rnk <=15


/*	
Output

name											rating  votes	online order			
Addhuri Udupi Bhojana							3.7		14956	No
Grand Village									3.8		14726	No
Rosewood International Hotel - Bar & Restaurant	3.6		12121	No
Caf-Eleven										4		9085	No
T3H Cafe										3.9		8304	No
Cafe Coffee Day									3.6		7284	No
Hide Out Cafe									3.7		7238	No
CAFE NOVA										3.2		7154	No
Sea Green Cafe									3.3		7064	No
Cuppa											3.3		6998	No
Srinathji's Cafe								3.8		6959	No
Corner House Ice Cream							4.3		6385	No
Gustoes Beer House								4.1		4845	No
The Biryani Cafe								4.1		4781	No
1947											4		4705	No
 
 */