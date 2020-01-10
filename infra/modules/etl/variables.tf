variable "GCP_PROJECT_ID" {
  default = ""
  type    = string
}

variable "BTCL_CHAINS" {
  default = []
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
  default = []
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

# path where to store generated helm values
variable "VALUES_PATH" {
  default = ""
  type    = string
}

variable "ENV_NAME" {
  default = ""
  type    = string
}

variable "NODES_ENDPOINTS" {
  default = {}
  type    = map(any)
}

variable "NODES_NAMES" {
  default = {
    bitcoin  = ["btc-0", "btc-1"],
    ethereum = ["eth-0", "eth-1"],
  }
  type = map(list(string))
}

variable "STATE_BUCKET_NAME" {
  default = ""
  type    = string
}
