variable "GCP_PROJECT_ID" {
  default = ""
  type    = string
}
variable "GKE_NODES_SA_NAME" {
  default = ""
  type    = string
}
variable "GKE_CLUSTER_NAME" {
  default = ""
  type    = string
}

# there is no reason to have single zone GKE master, as regional master is free
variable "GKE_MASTER_REGION" {
  default = ""
  type    = string
}

variable "GKE_NODE_POOL_NAME" {
  default = ""
  type    = string
}

variable "GKE_NODE_LOCATIONS" {
  default = []
  type    = list(string)
}

variable "GKE_NETWORK_NAME" {
  default = "default"
  type    = string
}
variable "GKE_SUBNETWORK_NAME" {
  default = ""
  type    = string
}
variable "GKE_SUBNETWORK_ADDRESS_RANGE" {
  default = "10.50.36.0/22"
  type    = string
}
variable "GKE_SECONDARY_PODS_NAME" {
  default = "gke-pods"
  type    = string
}
variable "GKE_SECONDARY_PODS_ADDRESS_RANGE" {
  default = "10.52.0.0/14"
  type    = string
}
variable "GKE_SECONDARY_SERVICES_NAME" {
  default = "gke-services"
  type    = string
}
variable "GKE_SECONDARY_SERVICES_ADDRESS_RANGE" {
  default = "10.50.0.0/20"
  type    = string
}
variable "GKE_MASTER_AUTHORIZED_NETWORKS" {
  default = []
  type    = list(string)
}

variable "GKE_NODE_DISK_SIZE" {
  default = "20"
  type    = string
}

variable "GKE_NODE_DISK_TYPE" {
  default = "pd-standard"
  type    = string
}

variable "GKE_NODE_MACHINE_TYPE" {
  default = "n1-standard-1"
  type    = string
}

variable "GKE_NODE_IMAGE_TYPE" {
  default = ""
  type    = string
}

variable "GKE_NODE_PREEMPTIBLE" {
  default = true
  type    = bool
}

variable "GKE_NODES_IAM_BINDING" {
  type = set(string)
  default = [
    "roles/logging.logWriter",
    "roles/monitoring.metricWriter",
    "roles/monitoring.viewer",
    "roles/storage.objectViewer",
    "roles/stackdriver.resourceMetadata.writer"
  ]
}

variable "K8S_CONTEXT" {
  default = ""
  type    = string
}
