provider "kubernetes" {
  config_context = var.K8S_CONTEXT
  version        = "1.10"
}

provider "helm" {
  service_account = "tiller"
  install_tiller  = true
  version         = "1.0"
}

provider "null" {
  version = "~> 2.1"
}
