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

variable "GKE_NODE_IMAGE_TYPE" {
  default = ""
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

variable "BTCL_CHAINS" {
  default = ["bitcoin", "bitcoin_cash", "dogecoin", "litecoin", "dash", "zcash"]
  type    = list(string)
}

//variable "BTCL_ENTITY_TYPES" {
//  default = ["blocks", "transactions"]
//  type    = list(string)
//}
//
//variable "ETHL_CHAINS" {
//  default = ["ethereum"]
//  type    = list(string)
//}

variable "ETHL_ENTITY_TYPES" {
  default = ["blocks", "transactions", "logs", "token_transfers", "traces", "contracts", "tokens"]
  type    = list(string)
}

variable "PUBSUB" {
  # 7 days
  default = {
    message_retention_duration = "604800s"
    retain_acked_messages      = true
    ack_deadline_seconds       = 30
    topic_name_prefix          = "crypto_"
    subscription_name_prefix   = "crypto_"
    subscription_name_suffix   = "dataflow.bigquery"
  }
  type = map(any)
}
