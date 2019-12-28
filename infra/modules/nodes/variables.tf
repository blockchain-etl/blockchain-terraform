variable "GCP_PROJECT_ID" {
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
variable "VALUES_PATH" {
  default = ""
  type    = string
}
variable "ENV_NAME" {
  default = ""
  type    = string
}

variable "SUBNETWORK" {
  type    = string
  default = ""
}

