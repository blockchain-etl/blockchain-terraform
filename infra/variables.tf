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

variable "ILB_IP_ADDRESS_NAME_PREFIX" {
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
    expiration_policy_ttl      = "" # empty means never expire
  }
  type = map(any)
}
# list of IPs to create and tf template name to render values files to helm
variable "IP_LIST" {
  default = {}
  type    = map(string)
}
# cryptonodes RPC user override, when required
variable "NODES_USERS" {
  default = {}
  type    = map(string)
}
# cryptonodes RPC password override, when required
variable "NODES_PASSWORDS" {
  default = {}
  type    = map(string)
}
# path where to store generated cryptonode helm values
variable VALUES_PATH {
  default = ""
  type    = string
}
variable "ENV_NAME" {
  default = ""
  type    = string
}
