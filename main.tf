data "google_compute_network" "existing_vpc" {
  name    = "default"
  project = var.project_id
}

data "google_compute_subnetwork" "existing_subnet" {
  name    = "default"
  region  = var.region
  project = var.project_id
}

resource "google_storage_bucket" "static-site" {
  name                     = var.bucket_name
  location                 = var.location
  project                  = var.project_id
  public_access_prevention = "enforced"
  versioning {
    enabled = true
  }
}

resource "google_service_account" "default" {
  account_id   = "my-custom-sa"
  display_name = "Custom SA for VM Instance"
}

resource "google_compute_instance" "default" {
  name         = var.vm_name
  machine_type = var.machine_type
  zone         = var.zone
  tags         = [var.db_firewall_tag] # Add the firewall tag to the VM
  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-minimal-2504-amd64"
      size  = var.disk_size
    }
  }
  network_interface {
    subnetwork = data.google_compute_subnetwork.existing_subnet.self_link
  }
}

resource "google_sql_database_instance" "instance" {
  name             = var.sql_instance_name
  region           = var.region
  database_version = var.database_version
  settings {
    tier = var.db_type
  }
  deletion_protection = true
}

resource "google_sql_database" "main_database" {
  for_each   = toset(var.db_name)
  name       = each.key
  instance   = google_sql_database_instance.instance.name
  depends_on = [google_sql_database_instance.instance]
}

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "google_sql_user" "main_user" {
  name       = var.db_username
  instance   = google_sql_database_instance.instance.name
  password   = random_password.password.result
  depends_on = [random_password.password, google_sql_database_instance.instance]
}

resource "google_secret_manager_secret" "my_secret" {
  project   = var.project_id
  secret_id = var.secret_name

  replication {
    user_managed {
      replicas {
        location = var.region
      }
    }
  }
}

resource "google_secret_manager_secret_version" "my_secret_version" {
  secret      = google_secret_manager_secret.my_secret.id
  secret_data = random_password.password.result
}

resource "google_compute_firewall" "postgres-rules" {
  name    = var.fw_rule
  network = data.google_compute_network.existing_vpc.self_link

  allow {
    protocol = "tcp"
    ports    = ["5432"] # Port for PostgreSQL
  }

  source_tags = [var.db_firewall_tag] # Allow traffic from instances with this tag
}

