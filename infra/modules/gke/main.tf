resource "google_container_cluster" "gke_cluster_0" {
  //  depends_on     = [google_project_service.container_svc]
  project        = var.GCP_PROJECT_ID
  name           = var.GKE_CLUSTER_NAME
  location       = var.GKE_MASTER_REGION
  node_locations = var.GKE_NODE_LOCATIONS

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1

  # --enable-stackdriver-kubernetes
  monitoring_service = "monitoring.googleapis.com/kubernetes"
  logging_service    = "logging.googleapis.com/kubernetes"
  master_auth {
    username = ""
    password = ""

    client_certificate_config {
      issue_client_certificate = false
    }
  }
  ip_allocation_policy {
    cluster_secondary_range_name  = var.GKE_SECONDARY_PODS_NAME
    services_secondary_range_name = var.GKE_SECONDARY_SERVICES_NAME
  }
  subnetwork = google_compute_subnetwork.container_subnetwork.name
  network    = google_compute_network.container_network.name
  network_policy {
    enabled = true
  }
  addons_config {
    network_policy_config {
      disabled = false
    }
  }
  master_authorized_networks_config {
    dynamic "cidr_blocks" {
      for_each = var.GKE_MASTER_AUTHORIZED_NETWORKS
      content {
        cidr_block = cidr_blocks.value
      }
    }
  }

  min_master_version = "latest"
  timeouts {
    create = "30m"
    update = "60m"
    delete = "30m"
  }
}

resource "null_resource" "local_k8s_context" {
  depends_on = [google_container_cluster.gke_cluster_0]
  provisioner "local-exec" {
    command = "gcloud container clusters get-credentials ${var.GKE_CLUSTER_NAME} --project=${var.GCP_PROJECT_ID} --zone=${var.GKE_MASTER_REGION} && ( kubectl config delete-context ${var.K8S_CONTEXT}; kubectl config rename-context gke_${var.GCP_PROJECT_ID}_${var.GKE_MASTER_REGION}_${var.GKE_CLUSTER_NAME} ${var.K8S_CONTEXT} )"
  }
}

resource "google_container_node_pool" "gke_pool_0" {

  depends_on = [google_container_cluster.gke_cluster_0]
  project    = var.GCP_PROJECT_ID
  name       = var.GKE_NODE_POOL_NAME
  location   = var.GKE_MASTER_REGION
  cluster    = google_container_cluster.gke_cluster_0.name

  //  this is default behavior
  //  node_locations = var.GKE_NODE_LOCATIONS

  node_count = 1
  autoscaling {
    min_node_count = 1
    max_node_count = 1
  }

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  timeouts {
    create = "30m"
    update = "20m"
    delete = "20m"
  }

  node_config {
    disk_size_gb = var.GKE_NODE_DISK_SIZE
    disk_type    = var.GKE_NODE_DISK_TYPE

    preemptible  = var.GKE_NODE_PREEMPTIBLE
    machine_type = var.GKE_NODE_MACHINE_TYPE
    image_type   = var.GKE_NODE_IMAGE_TYPE
    metadata = {
      disable-legacy-endpoints = "true"
    }

    service_account = google_service_account.gke_nodes.unique_id
  }
}
