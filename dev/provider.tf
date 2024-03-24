terraform {
  required_providers {
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "5.21.0"
    }
  }
}

provider "google-beta" {
  project   = var.project_name
  region    = var.project_region
  zone      = var.project_zone
}