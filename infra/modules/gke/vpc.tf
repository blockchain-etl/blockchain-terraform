resource "google_compute_network" "container_network" {
  project = var.GCP_PROJECT_ID
  //  depends_on              = [google_project_service.compute_svc]
  name                    = var.GKE_NETWORK_NAME
  description             = "auto-created network for cluster ${var.GKE_CLUSTER_NAME}"
  auto_create_subnetworks = false
  routing_mode            = "GLOBAL"
}

resource "google_compute_subnetwork" "container_subnetwork" {
  name          = var.GKE_SUBNETWORK_NAME
  description   = "auto-created subnetwork for cluster ${var.GKE_CLUSTER_NAME}"
  ip_cidr_range = var.GKE_SUBNETWORK_ADDRESS_RANGE
  network       = google_compute_network.container_network.self_link
  region        = var.GKE_MASTER_REGION
  secondary_ip_range = [
    {
      ip_cidr_range = var.GKE_SECONDARY_PODS_ADDRESS_RANGE
      range_name    = var.GKE_SECONDARY_PODS_NAME
    },
    {
      ip_cidr_range = var.GKE_SECONDARY_SERVICES_ADDRESS_RANGE
      range_name    = var.GKE_SECONDARY_SERVICES_NAME
    }
  ]
}
