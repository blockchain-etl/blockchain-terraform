terraform {
  source = "github.com/blockchain-etl/blockchain-terraform.git//infra?ref=master"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  GCP_PROJECT_ID                 = "your-staging-project"
  GKE_NODES_SA_NAME              = "baas-gke-nodes"
  GKE_CLUSTER_NAME               = "baas0"
  GKE_MASTER_ZONE                = "us-central1-b"
  GKE_NODE_POOL_NAME             = "pool-0"
  GKE_NODE_LOCATIONS             = ["us-central1-c", ]
  K8S_CONTEXT                    = "your-staging-project-baas0"
  GKE_MASTER_AUTHORIZED_NETWORKS = ["203.0.113.1/32", "198.51.100.0/24", ]
  IP_ADDRESS_REGION              = "us-central1"
  IP_ADDRESS_NAME_PREFIX         = "staging"
  GKE_NODE_MACHINE_TYPE          = "n1-standard-8"
}
