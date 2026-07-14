# Data Management Case Study - NumeriScan

This repository contains all SQL files I used for task 4 (the SQL implementation task), to set up the Database for NumeriScan

# Repository Content

** NumeriScan_Tables.sql ** creates all Tables for our Database 
** NumeriScan_Insert.sql ** inserts sample data into all Tables 
** NumeriScan_Views.sql ** creates Views, that I found helpful when writing queries
** NumeriScan_Queries.sql ** Queries from task 4, which output useful information NumeriScan might needs 

# How to start the Database with Docker

You can initialize and run this entire database using a single command utilizing docker compose

Step 1: Make sure you have [Docker Desktop](https://www.docker.com/products/docker-desktop/) installed and running on your System

Step 2: Clone this Repository or download all files into the same directory

Step 3: open bash and navigate to your directory, where you cloned this repository and execute 
this command: docker compose up -d

