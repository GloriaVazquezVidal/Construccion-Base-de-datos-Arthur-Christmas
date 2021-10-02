# Welcome to this README! #

This repository contains **my final work of Databases** (Bases de datos) course in my BSc Mathematics in July 2021.

## What is this project about?

This project consists of **modeling a problem**, using an **Entity-Relationship Model (ER/M)** and a **Relational Model (RM)** to organize the different elements in a database, and the **construction of a database in MySQL** to resolve an organization problem (Arthur Christmas problem).

* In the _Entity-Relationship Model_, we'll see a diagram relating all the elements, studying the cardinalities and the restrictions not included in the ER/M.
* In the _Relational Model_ will be studied the connection among relationships and attributes, as well as their foreign keys and their restrictions not included in the model. Besides this, it's shown the normalization of the relationships.
* In the _database scripts in MySQL_, we'll create a database, add triggers, fill tables, write queries and make trigger tests.

## Execution order ##

1. *create database Gloria_Vázquez_Vidal.sql*
2. *add triggers Gloria_Vázquez_Vidal.sql*
3. *fill tables Gloria_Vázquez_Vidal.sql*
4. *queries Gloria_Vázquez_Vidal.sql*
5. *trigger tests Gloria_Vázquez_Vidal.sql*
 

## Explanation of the content of each file ##

1. In *create database Gloria_Vázquez_Vidal.sql* the database tables are defined, as well as the primary and foreign keys.
2. In *add triggers Gloria_Vázquez_Vidal.sql* the triggers of the database are shown. It includes, among other things, the comments of each *trigger*, to know what each one does and certain clarifications when I consider it appropriate.
3. The file *fill tables Gloria_Vázquez_Vidal.sql* contains all the data to fill the tables already created in the database. In the same way, the data of the elves who are in charge of all the departments are updated.
	>	In this file there are no extreme cases where *triggers* stop code execution. This is done in file 5.
4. The *queries Gloria_Vázquez_Vidal.sql* file stores the queries made in the database.
5. In the file *trigger tests Gloria_Vázquez_Vidal.sql* we test, with extreme cases, the proper functioning of the *triggers*.
	> For example, one of the triggers evaluates whether a person is under 18 years old; if he/she is a minor, then that new row enters the children table, and if he/she is of legal age, then the trigger has to stop the entry of that data, notifying us with an error message. Thus, we will see that we will assign a "child" of legal age and the trigger will stop, giving us a warning message.
