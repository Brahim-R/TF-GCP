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
  description = "The machine type for the database instance."
  type        = string
  default     = "db-f1-micro"
}

variable "db_name" {
  description = "create multiple database names"
  type        = list(string)
}

variable "db_username" {
  type      = string
  sensitive = true
}

variable "secret_name" {
  type = string
}

variable "fw_rule" {
  type = string
}

variable "db_firewall_tag" {
  description = "A tag to apply to instances that need to access the database."
  type        = string
  default     = "db-access"
}
