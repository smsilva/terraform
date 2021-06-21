terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.72.0"
    }
  }
}

provider "google" {
  project = "crested-plexus-280002"
  region  = "us-central1"
  zone    = "us-central1-a"
}
