resource "google_compute_address" "chain" {
  project    = var.GCP_PROJECT_ID
  depends_on = ["google_project_service.compute_svc"]
  region     = var.IP_ADDRESS_REGION
  for_each   = var.IP_LIST
  name       = format("%s-%s", var.IP_ADDRESS_NAME_PREFIX, each.key)
}
