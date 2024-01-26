terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.51.0"
    }
  }
}

provider "google" {
  project = var.GOOGLE_PROJECT
  region  = var.GOOGLE_REGION
}

resource "google_storage_bucket" "demo-bucket" {
  name     = var.GOOGLE_BUCKET_NAME
  location = "US"

  # Optional, but recommended settings:
  storage_class         = "STANDARD"
  uniform_bucket_level_access = true

  versioning {
    enabled = true
  }

  lifecycle_rule {
    action {
      type = "Delete"
    }
    condition {
      age = 1 // days
    }
  }

  force_destroy = true
}

# resource "google_bigquery_dataset" "dataset" {
#   dataset_id = var.GOOGLE_BIGQUERY_DATASET_ID
#   project    = var.GOOGLE_PROJECT
#   location   = "US"
# }
