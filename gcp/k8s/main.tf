resource "google_container_cluster" "k8s" {
  description = "Main k8s cluster for all angrydev services/apps"

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1

  # Need this to create a VPC-native k8s cluster
  # We need a VPC-native cluster so that cloudsql proxy container can talk to the main CloudSQL server via private IP
  ip_allocation_policy{
    cluster_ipv4_cidr_block = "10.0.0.0/16"
  }

  name = var.name
  location   = var.location
  network    = var.k8s_vpc.id
}

resource "google_container_node_pool" "k8s_node_pool" {
  name       = "${var.name}-node-pool"
  location   = var.location
  cluster    = var.name
  node_count = 1

  node_config {
    preemptible  = true
    machine_type = "n1-standard-1"

    metadata = {
      disable-legacy-endpoints = "true"
    }

    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}
