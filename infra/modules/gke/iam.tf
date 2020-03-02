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

resource "google_project_iam_binding" "gke_nodes_iam_binding" {
  # we need to wait some time after service account creation to add iam bindings to this account
  depends_on = [null_resource.delay]
  project    = var.GCP_PROJECT_ID
  for_each   = var.GKE_NODES_IAM_BINDING
  role       = each.key
  members = [
    "serviceAccount:${var.GKE_NODES_SA_NAME}@${var.GCP_PROJECT_ID}.iam.gserviceaccount.com",
  ]
}
