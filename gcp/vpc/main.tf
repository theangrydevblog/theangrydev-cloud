resource "google_compute_network" "theangrydev_vpc" {
  name = var.vpc_name
  auto_create_subnetworks = var.vpc_create_subnets
}
