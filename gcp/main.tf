provider "google" {
  credentials = file("./credentials.json")
  project = "theangrydevblog"
}

module "vpc" {
  source = "./vpc"
}

module "k8s" {
  source = "./k8s"
  location = "us-east1"
  name = "theangrydev-block-zero"
  k8s_vpc = module.vpc
}

module "sql" {
  source = "./cloudsql"
  name = "${module.k8s.name}-cloudsql-instance"
  vpc = module.vpc
  location = module.k8s.location
}
