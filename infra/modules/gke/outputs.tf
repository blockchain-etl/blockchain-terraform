output "container_subnetwork_self_link" {
  description = "GKE subnetwork self link"
  value       = google_compute_subnetwork.container_subnetwork.self_link
}
