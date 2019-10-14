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

variable "GKE_MASTER_ZONE" {
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

variable "K8S_CONTEXT" {
  default = ""
  type    = string
}

variable "IP_ADDRESS_REGION" {
  default = ""
  type    = string
}

variable "IP_ADDRESS_NAME_PREFIX" {
  default = ""
  type    = string
}
