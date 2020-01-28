resource "google_service_account" "gke_nodes" {
  //  depends_on = [google_project_service.iam_svc]
  project      = var.GCP_PROJECT_ID
  account_id   = var.GKE_NODES_SA_NAME
  display_name = "GKE nodes service account"
}

resource "null_resource" "delay" {
  provisioner "local-exec" {
    command = "sleep 10"
  }
  triggers = {
    "before" = google_service_account.gke_nodes.id
  }
}

resource "google_project_iam_binding" "gke_nodes_logWriter" {
  depends_on = [null_resource.delay]
  project    = var.GCP_PROJECT_ID
  role       = "roles/logging.logWriter"

  members = [
    "serviceAccount:${var.GKE_NODES_SA_NAME}@${var.GCP_PROJECT_ID}.iam.gserviceaccount.com",
  ]
}

resource "google_project_iam_binding" "gke_nodes_metricWriter" {
  depends_on = [null_resource.delay]
  project    = var.GCP_PROJECT_ID
  role       = "roles/monitoring.metricWriter"

  members = [
    "serviceAccount:${var.GKE_NODES_SA_NAME}@${var.GCP_PROJECT_ID}.iam.gserviceaccount.com",
  ]
}

resource "google_project_iam_binding" "gke_nodes_monitoring_viewer" {
  depends_on = [null_resource.delay]
  project    = var.GCP_PROJECT_ID
  role       = "roles/monitoring.viewer"

  members = [
    "serviceAccount:${var.GKE_NODES_SA_NAME}@${var.GCP_PROJECT_ID}.iam.gserviceaccount.com",
  ]
}

resource "google_project_iam_binding" "gke_nodes_objectViewer" {
  depends_on = [null_resource.delay]
  project    = var.GCP_PROJECT_ID
  role       = "roles/storage.objectViewer"

  members = [
    "serviceAccount:${var.GKE_NODES_SA_NAME}@${var.GCP_PROJECT_ID}.iam.gserviceaccount.com",
  ]
}

resource "google_project_iam_binding" "gke_nodes_resourceMetadata_writer" {
  depends_on = [null_resource.delay]
  project    = var.GCP_PROJECT_ID
  role       = "roles/stackdriver.resourceMetadata.writer"

  members = [
    "serviceAccount:${var.GKE_NODES_SA_NAME}@${var.GCP_PROJECT_ID}.iam.gserviceaccount.com",
  ]
}
