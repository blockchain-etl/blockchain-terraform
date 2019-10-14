provider "kubernetes" {
  config_context = var.K8S_CONTEXT
}

provider "helm" {
  service_account = "tiller"
  install_tiller  = true
}
