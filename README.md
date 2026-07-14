# Data Management Case Study - NumeriScan

This repository contains all SQL files I used for task 4 (the SQL implementation task), to set up the Database for NumeriScan

# Repository Content

- NumeriScan_Tables.sql creates all Tables for our Database 
- NumeriScan_Insert.sql inserts sample data into all Tables 
- NumeriScan_Views.sql creates Views, that I found helpful when writing queries
- NumeriScan_Queries.sql Queries from task 4, which outputs useful information NumeriScan might needs 

# How to start the Database with Docker

You can initialize and run this entire database using a single command utilizing docker compose

Step 1: Make sure you have [Docker Desktop](https://www.docker.com/products/docker-desktop/) installed and running on your System

Step 2: Clone this Repository or download all files into the same directory

Step 3: open bash and navigate to your directory, where you cloned this repository and execute 
this command: docker compose up -d

step 4: open your Database IDE and connect it to your fresh new docker container

step 5: you should no have all Tables with all sample data inserted and all views created. To test the querys please add 
NumeriScan_Queries.sql to your IDE and execute it.
