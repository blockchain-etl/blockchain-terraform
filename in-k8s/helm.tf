## we should not remove SA and binding before removing all helm releases
resource "kubernetes_service_account" "tiller" {
  //  count = 0
  metadata {
    name      = "tiller"
    namespace = "kube-system"
  }

  automount_service_account_token = true

  lifecycle {
    prevent_destroy = true
  }
}

resource "kubernetes_cluster_role_binding" "tiller" {
  //  count = 0
  depends_on = [
    kubernetes_service_account.tiller,
  ]

  metadata {
    name = "tiller-clusterrolebinding"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }

  subject {
    kind      = "ServiceAccount"
    name      = "tiller"
    namespace = "kube-system"
  }

  lifecycle {
    prevent_destroy = true
  }
}

// workaround as we don't have helm releases via tf
resource "null_resource" "tiller_install" {
  depends_on = [kubernetes_cluster_role_binding.tiller]
  provisioner "local-exec" {
    command = "helm init --service-account ${kubernetes_service_account.tiller.metadata[0].name} && sleep 10"
  }
}
