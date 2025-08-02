#Project
project_id = "pacific-booking-467217-u4e"

#VPC
vpc_name = "default"
subnet_name = "default"

#Bucket 
bucket_name = "brahim-bucket-dev"

#Virtual machine
machine_type = "e2-micro"
vm_name      = "brahim-vm"
zone         = "us-east1-b"

#SQL instance
sql_instance_name = "brahim-sql-postgres17"
db_type           = "db-f1-micro"
db_name           = ["customer-db", "payments-db"]
db_username       = "adminuser"
secret_name       = "adminuser"

#Firewall rule
fw_rule = "postgres-fw"