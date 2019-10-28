resource "google_compute_address" "btc-0" {
  project    = var.GCP_PROJECT_ID
  depends_on = ["google_project_service.compute_svc"]
  name       = "${var.IP_ADDRESS_NAME_PREFIX}-btc-0"
  region     = var.IP_ADDRESS_REGION
}
resource "google_compute_address" "btc-1" {
  project    = var.GCP_PROJECT_ID
  depends_on = ["google_project_service.compute_svc"]
  name       = "${var.IP_ADDRESS_NAME_PREFIX}-btc-1"
  region     = var.IP_ADDRESS_REGION
}
resource "google_compute_address" "eth-0" {
  project    = var.GCP_PROJECT_ID
  depends_on = ["google_project_service.compute_svc"]
  name       = "${var.IP_ADDRESS_NAME_PREFIX}-eth-0"
  region     = var.IP_ADDRESS_REGION
}
resource "google_compute_address" "eth-1" {
  project    = var.GCP_PROJECT_ID
  depends_on = ["google_project_service.compute_svc"]
  name       = "${var.IP_ADDRESS_NAME_PREFIX}-eth-1"
  region     = var.IP_ADDRESS_REGION
}
