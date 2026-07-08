# DevOps Assessment – Terraform & Database Reliability

## Overview

This project was completed as part of a DevOps assessment to demonstrate infrastructure provisioning using Terraform and database reliability tasks using PostgreSQL and Docker Compose.

The project includes reusable Terraform modules, separate environments for development and production, local database setup, seed data generation, indexing, backup, and restore automation.
## Infrastructure
Terraform modules were created for:
- Network
- ECS (Fargate)
- RDS

The infrastructure follows the architecture below.

Internet
|
Application Load Balancer
|
ECS Fargate Service
|
Amazon RDS (Private)
The RDS instance is deployed inside private subnets and only accepts traffic from the ECS security group.

Environment Configuration:
Separate environments have been created for development and production.

Development
•	Smaller database instance
•	Backup retention: 1 day
•	Deletion protection disabled
Production
•	Larger database instance
•	Backup retention: 7 days
•	Deletion protection enabled

Terraform Validation

The infrastructure was verified using:

terraform fmt
terraform init
terraform validate
terraform plan

Local Database Setup

Start PostgreSQL using Docker Compose.

cd database

docker compose up -d

Verify the container:

docker ps

Connect to PostgreSQL:

docker exec -it hotel-db psql -U admin -d hotel
Database Migration

Tables are created automatically during container initialization using the SQL migration file.

Created tables:

hotel_bookings
booking_events
Seed Data

Seed data includes:

100 hotel bookings
Multiple cities
Multiple booking statuses
Multiple organizations
Booking events

Execute:

docker exec -i hotel-db psql -U admin -d hotel < seed/seed.sql

Verify:

SELECT COUNT(*) FROM hotel_bookings;
Query Optimization

The following reporting query was optimized.

SELECT
org_id,
status,
COUNT(*),
SUM(amount)
FROM hotel_bookings
WHERE city='delhi'
AND created_at >= NOW() - INTERVAL '30 days'
GROUP BY org_id,status;

A composite index was created.

CREATE INDEX idx_hotel_city_created
ON hotel_bookings(city, created_at);

The index was chosen because the query filters by city and created_at, reducing unnecessary table scans and improving lookup efficiency.

Backup

Run:

cd scripts

./backup.sh

The script creates a timestamped SQL dump inside the backups directory.

Example:

hotel_backup_20260708_072905.sql
Restore

Run:

cd scripts

./restore.sh

The restore script recreates the database schema and restores the latest backup automatically.

Verification

Verify booking data.

SELECT COUNT(*) FROM hotel_bookings;

Verify booking events.

SELECT COUNT(*) FROM booking_events;

Technologies Used
Terraform
AWS
Docker
Docker Compose
PostgreSQL
Bash
Git
GitHub

