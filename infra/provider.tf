## The default project specification
provider "google" {
  project = var.GCP_PROJECT_ID
  # gke requires this, incorrectly?
  region  = var.GKE_MASTER_REGION
  version = "3.9"
}

provider "local" {
  version = "~> 1.4"
}

## beta provider
provider "google-beta" {
  project = var.GCP_PROJECT_ID
  # gke requires this, incorrectly?
  region = var.GKE_MASTER_REGION
}
