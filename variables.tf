variable "project_id" {
  type = string
}

variable "region" {
  type    = string
  default = "us-east1"
}

variable "vpc_name" {
  type    = string
  default = "default"
}

variable "subnet_name" {
  type    = string
  default = "default"
}

variable "bucket_name" {
  type    = string
  default = "brahim-bucket-storage"
}

variable "location" {
  type    = string
  default = "US"
}

variable "zone" {
  type    = string
  default = "us-east1-b"
}

variable "machine_type" {
  type = string
}

variable "vm_name" {
  type = string
}

variable "disk_size" {
  type    = number
  default = 20
}

variable "sql_instance_name" {
  type = string
}

variable "database_version" {
  type    = string
  default = "POSTGRES_17"
}

variable "db_type" {
  type = string
}

variable "db_name" {
  description = "create multiple database names"
  type        = list(string)
}

variable "db_username" {
  type = string
}

variable "secret_name" {
  type = string
}

variable "fw_rule" {
  description = "Name of the firewall rule"
  type        = string
  default     = "postgres-firewall-rule"
}