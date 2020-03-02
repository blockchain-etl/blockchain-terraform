resource "google_project_service" "iam_svc" {
  project                    = local.GCP_NODES_PROJECT_ID
  service                    = "iam.googleapis.com"
  disable_on_destroy         = false
  disable_dependent_services = true
}

resource "google_project_service" "compute_svc" {
  project                    = local.GCP_NODES_PROJECT_ID
  service                    = "compute.googleapis.com"
  disable_on_destroy         = false
  disable_dependent_services = true
}

resource "google_project_service" "container_svc" {
  project                    = local.GCP_NODES_PROJECT_ID
  service                    = "container.googleapis.com"
  disable_on_destroy         = false
  disable_dependent_services = true
}
resource "google_project_service" "pubsub_svc" {
  project                    = local.GCP_ETL_PROJECT_ID
  service                    = "pubsub.googleapis.com"
  disable_on_destroy         = false
  disable_dependent_services = true
}
