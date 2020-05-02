resource "google_container_cluster" "k8s" {
  description = "Main k8s cluster for all angrydev services/apps"

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1

  name = var.name
  location   = var.location
  network    = var.k8s_vpc.id
}
