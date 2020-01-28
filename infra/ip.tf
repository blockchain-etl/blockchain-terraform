resource "google_compute_address" "chain" {
  project    = var.GCP_PROJECT_ID
  depends_on = [google_project_service.compute_svc]
  region     = var.IP_ADDRESS_REGION
  for_each   = var.IP_LIST
  name       = format("%s-%s", var.IP_ADDRESS_NAME_PREFIX, each.key)
}
resource "google_compute_address" "ilb" {
  project = var.GCP_PROJECT_ID
  //  depends_on = ["google_compute_subnetwork.container_subnetwork"]
  subnetwork   = google_compute_subnetwork.container_subnetwork.self_link
  region       = var.IP_ADDRESS_REGION
  for_each     = var.IP_LIST
  address_type = "INTERNAL"
  purpose      = "GCE_ENDPOINT"
  name         = format("%s-%s", var.ILB_IP_ADDRESS_NAME_PREFIX, each.key)
}
