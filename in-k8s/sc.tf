resource "kubernetes_storage_class" "sc_ssd_regional" {
  metadata {
    name = "ssd-regional-${var.K8S_SC_SUFFIX}"
  }
  storage_provisioner = "kubernetes.io/gce-pd"
  reclaim_policy      = "Retain"
  parameters = {
    type             = "pd-ssd"
    replication-type = "regional-pd"
    zones            = var.K8S_REGIONAL_DISK_LOCATIONS
  }
}
resource "kubernetes_storage_class" "sc_standard_regional" {
  metadata {
    name = "standard-regional-${var.K8S_SC_SUFFIX}"
  }
  storage_provisioner = "kubernetes.io/gce-pd"
  reclaim_policy      = "Retain"
  parameters = {
    type             = "pd-standard"
    replication-type = "regional-pd"
    zones            = var.K8S_REGIONAL_DISK_LOCATIONS
  }
}
