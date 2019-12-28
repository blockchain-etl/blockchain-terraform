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

