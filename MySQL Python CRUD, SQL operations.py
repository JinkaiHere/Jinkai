#!/usr/bin/env python
# coding: utf-8

# In[2]:


import mysql.connector
mydb = mysql.connector.connect(
    host="localhost",
    port = "3306",
    user="root",
    password=""
)
print(mydb)


# In[ ]:


# Create database named mydatabase

mycursor = mydb.cursor()
mycursor.execute("CREATE DATABASE mydatabase")


# In[5]:


# Show databases

import mysql.connector
mydb = mysql.connector.connect(
    host="localhost",
    port = "3306",
    user="root",
    password="",
    database="mydatabase"
)
mycursor = mydb.cursor()
mycursor.execute("SHOW DATABASES")

for x in mycursor:
  print(x)


# In[50]:


# Create table named customers
import mysql.connector
mydb = mysql.connector.connect(
    host="localhost",
    port = "3306",
    user="root",
    password="",
    database = "mydatabase"
)

mycursor = mydb.cursor()

# mycursor.execute("CREATE TABLE customers (id INT AUTO_INCREMENT PRIMARY KEY, name VARCHAR(255), address VARCHAR(255))")
# Example no primary key
mycursor.execute("CREATE TABLE customers (name VARCHAR(255), address VARCHAR(255))")


# In[6]:


# Show all tables

import mysql.connector
mydb = mysql.connector.connect(
    host="localhost",
    port = "3306",
    user="root",
    password="",
    database = "mydatabase"
)

mycursor = mydb.cursor()
mycursor.execute("SHOW TABLES")

for x in mycursor:
  print(x)


# In[52]:


# If the table already exists but you want to add an extra field

mycursor.execute("ALTER TABLE customers ADD COLUMN id INT AUTO_INCREMENT PRIMARY KEY")


# In[53]:


# Inserting values into customers table

sql = "INSERT INTO customers (name, address) VALUES (%s, %s)"
val = ("John", "Highway 21")
mycursor.execute(sql, val)

mydb.commit()

print(mycursor.rowcount, "record inserted.")


# In[55]:


import mysql.connector

mydb = mysql.connector.connect(
  host="localhost",
  user="root",
  password="",
  database="mydatabase"
)

mycursor = mydb.cursor()

sql = "INSERT INTO customers (name, address) VALUES (%s, %s)"
val = [
  ('Peter', 'Lowstreet 4'),
  ('Amy', 'Apple st 652'),
  ('Hannah', 'Mountain 21'),
  ('Michael', 'Valley 345'),
  ('Sandy', 'Ocean blvd 2'),
  ('Betty', 'Green Grass 1'),
  ('Richard', 'Sky st 331'),
  ('Susan', 'One way 98'),
  ('Vicky', 'Yellow Garden 2'),
  ('Ben', 'Park Lane 38'),
  ('William', 'Central st 954'),
  ('Chuck', 'Main Road 989'),
  ('Viola', 'Sideway 1633')
]

mycursor.executemany(sql, val)

mydb.commit()

print(mycursor.rowcount, "was inserted.")


# In[56]:


# Get inserted ID / How many has been inserted

sql = "INSERT INTO customers (name, address) VALUES (%s, %s)"
val = ("Michelle", "Blue Village")
mycursor.execute(sql, val)

mydb.commit()

print("1 record inserted, ID:", mycursor.lastrowid)


# In[90]:


import mysql.connector

mydb = mysql.connector.connect(
  host="localhost",
  user="root",
  password="",
  database="mydatabase"
)

mycursor = mydb.cursor()

# Selecting Customers table and showing all values

# To only select specific columns, use:
# mycursor.execute("SELECT name, address FROM customers")
mycursor.execute("SELECT * FROM users")

# To only select 1 row:
# myresult = mycursor.fetchone()
myresult = mycursor.fetchall()

for x in myresult:
  print(x)


# In[58]:


# Selecting with a filter

import mysql.connector

mydb = mysql.connector.connect(
  host="localhost",
  user="root",
  password="",
  database="mydatabase"
)

mycursor = mydb.cursor()

sql = "SELECT * FROM customers WHERE address ='Park Lane 38'"

mycursor.execute(sql)

myresult = mycursor.fetchall()

for x in myresult:
  print(x)


# In[26]:


# Selecting records where the address contains the word "way"
import mysql.connector

mydb = mysql.connector.connect(
  host="localhost",
  user="root",
  password="",
  database="mydatabase"
)

mycursor = mydb.cursor()

sql = "SELECT * FROM customers WHERE address LIKE '%way%'"

mycursor.execute(sql)

myresult = mycursor.fetchall()

for x in myresult:
  print(x)


# In[28]:


# To prevent SQL Injection
import mysql.connector

mydb = mysql.connector.connect(
  host="localhost",
  user="root",
  password="",
  database="mydatabase"
)

mycursor = mydb.cursor()

sql = "SELECT * FROM customers WHERE address = %s"
adr = ("Yellow Garden 2", )

mycursor.execute(sql, adr)

myresult = mycursor.fetchall()

for x in myresult:
  print(x)


# In[61]:


# Sorting the result ORDER by name
import mysql.connector

mydb = mysql.connector.connect(
  host="localhost",
  user="root",
  password="",
  database="mydatabase"
)

mycursor = mydb.cursor()

sql = "SELECT * FROM customers ORDER BY name"

mycursor.execute(sql)

myresult = mycursor.fetchall()

for x in myresult:
  print(x)


# In[60]:


# Order by DESC gives you a reverse order
import mysql.connector

mydb = mysql.connector.connect(
  host="localhost",
  user="root",
  password="",
  database="mydatabase"
)

mycursor = mydb.cursor()

sql = "SELECT * FROM customers ORDER BY name DESC"

mycursor.execute(sql)

myresult = mycursor.fetchall()

for x in myresult:
  print(x)


# In[62]:


# Deleting records
import mysql.connector

mydb = mysql.connector.connect(
  host="localhost",
  user="root",
  password="",
  database="mydatabase"
)

mycursor = mydb.cursor()

# Make sure to have a WHERE or else all records get deleted
sql = "DELETE FROM customers WHERE address = 'Mountain 21'"

mycursor.execute(sql)

# mydb.commit is required to commit the changes
mydb.commit()

print(mycursor.rowcount, "record(s) deleted")


# In[63]:


# Preventing SQL injection in delete
import mysql.connector

mydb = mysql.connector.connect(
  host="localhost",
  user="root",
  password="",
  database="mydatabase"
)

mycursor = mydb.cursor()

sql = "DELETE FROM customers WHERE address = %s"
adr = ("Yellow Garden 2", )

mycursor.execute(sql, adr)

mydb.commit()

print(mycursor.rowcount, "record(s) deleted")


# In[76]:


# Drop to delete the table
import mysql.connector

mydb = mysql.connector.connect(
  host="localhost",
  user="root",
  password="",
  database="mydatabase"
)

mycursor = mydb.cursor()

sql = "DROP TABLE IF EXISTS products"

mycursor.execute(sql)


# In[59]:


# To update a table
#Changing address of customers valley 345 to canyon 123

import mysql.connector

mydb = mysql.connector.connect(
  host="localhost",
  user="root",
  password="",
  database="mydatabase"
)

mycursor = mydb.cursor()

sql = "UPDATE customers SET address = 'Canyon 123' WHERE address = 'Valley 345'"

mycursor.execute(sql)

mydb.commit()

print(mycursor.rowcount, "record(s) affected")


# In[64]:


# To prevent SQL injection in Update statements

import mysql.connector

mydb = mysql.connector.connect(
  host="localhost",
  user="root",
  password="",
  database="mydatabase"
)

mycursor = mydb.cursor()

sql = "UPDATE customers SET address = %s WHERE address = %s"
val = ("Valley 345", "Canyon 123")

mycursor.execute(sql, val)

mydb.commit()

print(mycursor.rowcount, "record(s) affected")


# In[65]:


# LIMIT to limit the number of results returned by the query
import mysql.connector

mydb = mysql.connector.connect(
  host="localhost",
  user="root",
  password="",
  database="mydatabase"
)

mycursor = mydb.cursor()

mycursor.execute("SELECT * FROM customers LIMIT 5")

myresult = mycursor.fetchall()

for x in myresult:
  print(x)


# In[66]:


# Limit starting from another position
# Position 3 
import mysql.connector

mydb = mysql.connector.connect(
  host="localhost",
  user="root",
  password="",
  database="mydatabase"
)

mycursor = mydb.cursor()

mycursor.execute("SELECT * FROM customers LIMIT 5 OFFSET 2")

myresult = mycursor.fetchall()

for x in myresult:
  print(x)


# In[67]:


# Create table named users
import mysql.connector
mydb = mysql.connector.connect(
    host="localhost",
    port = "3306",
    user="root",
    password="",
    database = "mydatabase"
)

mycursor = mydb.cursor()
mycursor.execute("CREATE TABLE users (id INT AUTO_INCREMENT PRIMARY KEY, name VARCHAR(255), fav VARCHAR(255))")

sql = "INSERT INTO users (name, fav) VALUES (%s, %s)"
val = [
  ('John', '154'),
  ('Peter', '154'),
  ('Amy', '155'),
  ('Hannah', ''),
  ('Michael', '')
]

mycursor.executemany(sql, val)

mydb.commit()

print(mycursor.rowcount, "record inserted.")


# In[84]:


# Create table named products
import mysql.connector
mydb = mysql.connector.connect(
    host="localhost",
    port = "3306",
    user="root",
    password="",
    database = "mydatabase"
)

mycursor = mydb.cursor()
# mycursor.execute("CREATE TABLE products (id INT AUTO_INCREMENT PRIMARY KEY, name VARCHAR(255))")

sql = "INSERT INTO products (name) VALUES (%s)"
val = [('Chocolate Heaven',),('Tasty Lemons',),('Vanilla Dreams',)]

mycursor.executemany(sql, val)

mydb.commit()

print(mycursor.rowcount, "record inserted.")


# In[92]:


# Join 2 tables together 
# Connecting to show users and their favourite products
import mysql.connector

mydb = mysql.connector.connect(
  host="localhost",
  user="root",
  password="",
  database="mydatabase"
)

mycursor = mydb.cursor()

sql = "SELECT   users.name AS user,   products.name AS favorite   FROM users   INNER JOIN products ON users.fav = products.id"

mycursor.execute(sql)

myresult = mycursor.fetchall()

for x in myresult:
  print(x)


# In[86]:


# LEFT JOIN
# This is to join every user to the table including those that dont have a favourite product 

sql = "SELECT   users.name AS user,   products.name AS favorite   FROM users   LEFT JOIN products ON users.fav = products.id"


# In[87]:


# RIGHT JOIN
# This is to join every products to the table including those that arent favourited by a user

sql = "SELECT   users.name AS user,   products.name AS favorite   FROM users   RIGHT JOIN products ON users.fav = products.id"


# In[ ]:




