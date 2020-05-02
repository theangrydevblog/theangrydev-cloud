resource "google_compute_global_address" "private_ip_address" {
  name          = "private-ip-address"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = var.vpc.self_link
}

# The memmber needs Service Networking Admin role in order to create this resource
resource "google_service_networking_connection" "private_vpc_connection" {
  network                 = var.vpc.self_link
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
}

resource "google_sql_database_instance" "cloud_sql" {
    name   = var.name
    region = var.location
    database_version = "POSTGRES_11"
    depends_on = [google_service_networking_connection.private_vpc_connection]
    settings {
        tier = "db-f1-micro"
        ip_configuration {
            ipv4_enabled    = false
            private_network = var.vpc.self_link
        }
    }
}
