locals {
  # use GCP_PROJECT_ID, when specific var isn't changed from default value
  GCP_NODES_PROJECT_ID = var.GCP_NODES_PROJECT_ID == "" ? var.GCP_PROJECT_ID : var.GCP_NODES_PROJECT_ID
  GCP_ETL_PROJECT_ID   = var.GCP_ETL_PROJECT_ID == "" ? var.GCP_PROJECT_ID : var.GCP_ETL_PROJECT_ID
}

module "gke_nodes" {
  source                               = "./modules/gke"
  GCP_PROJECT_ID                       = local.GCP_NODES_PROJECT_ID
  GKE_NODES_SA_NAME                    = var.GKE_NODES_SA_NAME
  GKE_CLUSTER_NAME                     = var.GKE_CLUSTER_NAME
  GKE_MASTER_REGION                    = var.GKE_MASTER_REGION
  GKE_NODE_POOL_NAME                   = var.GKE_NODE_POOL_NAME
  GKE_NODE_LOCATIONS                   = var.GKE_NODE_LOCATIONS
  GKE_NETWORK_NAME                     = var.GKE_NETWORK_NAME
  GKE_SUBNETWORK_NAME                  = var.GKE_SUBNETWORK_NAME
  GKE_SUBNETWORK_ADDRESS_RANGE         = var.GKE_SUBNETWORK_ADDRESS_RANGE
  GKE_SECONDARY_PODS_NAME              = var.GKE_SECONDARY_PODS_NAME
  GKE_SECONDARY_PODS_ADDRESS_RANGE     = var.GKE_SECONDARY_PODS_ADDRESS_RANGE
  GKE_SECONDARY_SERVICES_NAME          = var.GKE_SECONDARY_SERVICES_NAME
  GKE_SECONDARY_SERVICES_ADDRESS_RANGE = var.GKE_SECONDARY_SERVICES_ADDRESS_RANGE
  GKE_MASTER_AUTHORIZED_NETWORKS       = var.GKE_MASTER_AUTHORIZED_NETWORKS
  GKE_NODE_DISK_SIZE                   = var.GKE_NODE_DISK_SIZE
  GKE_NODE_DISK_TYPE                   = var.GKE_NODE_DISK_TYPE
  GKE_NODE_MACHINE_TYPE                = var.GKE_NODE_MACHINE_TYPE
  GKE_NODE_IMAGE_TYPE                  = var.GKE_NODE_IMAGE_TYPE
  GKE_NODE_PREEMPTIBLE                 = var.GKE_NODE_PREEMPTIBLE
  K8S_CONTEXT                          = var.K8S_CONTEXT
}

module "nodes" {
  source                     = "./modules/nodes"
  SUBNETWORK                 = module.gke_nodes.container_subnetwork_self_link
  GCP_PROJECT_ID             = local.GCP_NODES_PROJECT_ID
  IP_ADDRESS_REGION          = var.IP_ADDRESS_REGION
  IP_ADDRESS_NAME_PREFIX     = var.IP_ADDRESS_NAME_PREFIX
  ILB_IP_ADDRESS_NAME_PREFIX = var.ILB_IP_ADDRESS_NAME_PREFIX
  IP_LIST                    = var.IP_LIST
  NODES_USERS                = var.NODES_USERS
  NODES_PASSWORDS            = var.NODES_PASSWORDS
  VALUES_PATH                = format("%s/%s", path.root, var.NODES_VALUES_PATH)
  ENV_NAME                   = var.ENV_NAME
}

module "etl" {
  source            = "./modules/etl"
  GCP_PROJECT_ID    = local.GCP_ETL_PROJECT_ID
  BTCL_CHAINS       = var.BTCL_CHAINS
  BTCL_DEPLOYS      = var.BTCL_DEPLOYS
  ETHL_CHAINS       = var.ETHL_CHAINS
  ETHL_DEPLOYS      = var.ETHL_DEPLOYS
  ETHL_ENTITY_TYPES = var.ETHL_ENTITY_TYPES
  PUBSUB            = var.PUBSUB
  NODES_ENDPOINTS   = module.nodes.nodes_endpoints
  VALUES_PATH       = format("%s/%s", path.root, var.ETL_VALUES_PATH)
  ENV_NAME          = var.ENV_NAME
  STATE_BUCKET_NAME = var.ETL_STATE_BUCKET_NAME
}
