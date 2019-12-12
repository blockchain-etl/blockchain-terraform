## The default project specification
provider "google" {
  project = var.GCP_PROJECT_ID
  # gke requires this, incorrectly?
  region = var.GKE_MASTER_REGION
}

