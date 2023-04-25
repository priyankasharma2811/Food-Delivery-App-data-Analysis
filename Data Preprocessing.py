Python 3.9.13 (tags/v3.9.13:6de2ca5, May 17 2022, 16:36:42) [MSC v.1929 64 bit (AMD64)] on win32
Type "help", "copyright", "credits" or "license()" for more information.
>>> 

import pandas as pd
import numpy as np
import warnings
warnings.filterwarnings("ignore")

def read_data_from_csv():
    hotels=pd.read_csv('zomato.csv')
    
    return hotels


def remove_unwanted_columns():
    #call read_data_from_csv() function to get dataframe
    hotels=read_data_from_csv()
    hotels.drop(['address','phone'],axis=1,inplace=True)
   
    
    return hotels


def rename_columns():
    #DO NOT REMOVE FOLLOWING LINE
    #call remove_unwanted_columns() function to get dataframe
    hotels = remove_unwanted_columns()
    
    hotels.rename(columns={'rate':'rating','votes':'votes' ,'approx_cost(for two people)':'approx_cost', 'listed_in(type)' :'type'},inplace=True)
    
    
    #task2: rename columns,  only these columns are allowed in the dataset
    # 1.	Id
    # 2.	Name
    # 3.	online_order
    # 4.	book_table
    # 5.	rating
    # 6.	votes
    # 7.	location
    # 8.	rest_type
    # 9.	dish_liked
    # 10.	cuisines
    # 11.	approx_cost
    # 12.	type
    return hotels


#task3: handle  null values of each column
def null_value_check():
    #DO NOT REMOVE FOLLOWING LINE
    #call rename_columns() function to get dataframe
    hotels=rename_columns()
    
    #deleting null values of name column
    
    #handling null values of online_order
    
    #handling null values of book_table
    
    #handling null values of rating
    
    #handling null values of votes
    
    #handling null values of location
    
    #handling null values of rest_type
    
    #handling null values of dishliked
    
    #handling null values of cuisines
    
    #handling null values of approxcost
    
    #handling null values of type
    
    hotels.name= hotels.name.dropna()
    hotels.online_order=hotels.online_order.fillna('NA')
    hotels.rating= hotels.rating.fillna(0)
    hotels.votes= hotels.votes.fillna(0)
    hotels.location.value_counts()
    hotels.location= hotels.location.fillna('NA')
    hotels.rest_type = hotels.rest_type.fillna('NA')
    hotels.dish_liked=hotels.dish_liked.fillna('NA')
    hotels.cuisines= hotels.cuisines.fillna('NA')
    hotels.approx_cost=hotels.approx_cost.fillna(0)
    hotels.type= hotels.type.fillna('NA')
        
    return hotels


#task4 #find duplicates in the dataset
def find_duplicates():
    #DO NOT REMOVE FOLLOWING LINE
    #call null_value_check() function to get dataframe
    hotels=null_value_check()
    hotels.drop_duplicates(inplace=True)
    
    
    #droping the duplicates value keeping the first
    return hotels


#task5 removing irrelevant text from all the columns
def removing_irrelevant_text():
    #DO NOT REMOVE FOLLOWING LINE
    #call find_duplicates() function to get dataframe
    hotels= find_duplicates()
    hotels=hotels[hotels['name'].str.contains('RATED|Rated')== False]
    hotels=hotels[hotels['online_order'].str.contains('RATED|Rated')== False]
    hotels=hotels[hotels['book_table'].str.contains('RATED|Rated')== False]
    hotels=hotels[hotels['rating'].str.contains('RATED|Rated')== False]
    hotels=hotels[hotels['votes'].str.contains('RATED|Rated')== False]
    hotels=hotels[hotels['location'].str.contains('RATED|Rated')== False]
    hotels=hotels[hotels['rest_type'].str.contains('RATED|Rated')== False]
    hotels=hotels[hotels['dish_liked'].str.contains('RATED|Rated')== False]
    hotels=hotels[hotels['cuisines'].str.contains('RATED|Rated')== False]
    hotels=hotels[hotels['approx_cost'].str.contains('RATED|Rated')== False]
    hotels=hotels[hotels['type'].str.contains('RATED|Rated')== False]
        
    return hotels


#task6: check for unique values in each column and handle the irrelevant values
def check_for_unique_values():
    #DO NOT REMOVE FOLLOWING LINE
    #call removing_irrelevant_text() function to get dataframe
    hotels=removing_irrelevant_text()
    hotels= hotels[hotels['online_order'].str.contains('Yes|No')== True]
    hotels['rating'] = hotels['rating'].apply(lambda x: x.replace('/5', ''))
    hotels['rating'] = hotels['rating'].replace(['NEW','-'],0)



    return hotels


#task7: remove the unknown character from the dataset and export it to "zomatocleaned.csv"
def remove_the_unknown_character():
    #DO NOT REMOVE FOLLOWING LINE
    #call check_for_unique_values() function to get dataframe
    dataframe=check_for_unique_values()
    dataframe['name'] = dataframe['name'].str.replace('[Ãx][^A-Za-z]+','',regex=True)

    #remove unknown character from dataset
    
    #export cleaned Dataset to newcsv file named "zomatocleaned.csv"
    dataframe.to_csv('zomatocleaned1.csv')
    return dataframe



def start():
    remove_the_unknown_character()

def task_runner():
    start()
