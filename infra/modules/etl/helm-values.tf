//data template_file "etl_app_values_template" {
//  for_each = toset(var.BTCL_CHAINS)
//  template = file(format("%s/templates/%s.tpl", path.module, "btc"))
//  vars = {
//    # FIXME endpoint port and schema hardcoded
//    provider_uri      = join(",", [for node_name in var.NODES_NAMES[each.key] : format("http://%s:%s@%s:8332", var.NODES_ENDPOINTS[node_name]["rpcuser"], var.NODES_ENDPOINTS[node_name]["rpcpassword"], var.NODES_ENDPOINTS[node_name]["internalIP"])])
//    project           = var.GCP_PROJECT_ID
//    topic_name_prefix = format("%s%s", var.PUBSUB.topic_name_prefix, each.key)
//    gcs_prefix        = format("gs://%s/%s-etl/streaming", var.STATE_BUCKET_NAME, each.key)
//  }
//}
//resource "local_file" "etl_app_values_output" {
//  for_each          = toset(var.BTCL_CHAINS)
//  filename          = format("%s/values-%s-%s.yaml", var.VALUES_PATH, var.ENV_NAME, each.key)
//  file_permission   = "0644"
//  sensitive_content = data.template_file.etl_app_values_template[each.key].rendered
//}

data template_file "etl_app_values_btcl" {
  for_each = toset(var.BTCL_CHAINS)
  template = file(format("%s/templates/%s.tpl", path.module, "btc"))
  vars = {
    # FIXME endpoint port and schema hardcoded
    provider_uri = var.BTCL_DEPLOYS[each.key].endpoints == "" ? join(",",
      [for node_name in var.BTCL_DEPLOYS[each.key].endpoints_ref :
        format("http://%s:%s@%s:8332",
          var.NODES_ENDPOINTS[node_name]["rpcuser"],
          var.NODES_ENDPOINTS[node_name]["rpcpassword"],
          var.NODES_ENDPOINTS[node_name]["internalIP"]
        )
      ]
    ) : var.BTCL_DEPLOYS[each.key].endpoints
    project           = var.GCP_PROJECT_ID
    topic_name_prefix = format("%s%s", var.PUBSUB.topic_name_prefix, each.key)
    gcs_prefix        = format("gs://%s/%s-etl/streaming", var.STATE_BUCKET_NAME, each.key)
  }
}
resource "local_file" "etl_app_values_btcl" {
  for_each          = toset(var.BTCL_CHAINS)
  filename          = format("%s/NEW-values-%s-%s.yaml", var.VALUES_PATH, var.ENV_NAME, each.key)
  file_permission   = "0644"
  sensitive_content = data.template_file.etl_app_values_btcl[each.key].rendered
}

data template_file "etl_app_values_ethl" {
  for_each = toset(var.ETHL_CHAINS)
  template = file(format("%s/templates/%s.tpl", path.module, "ethereum"))
  vars = {
    # FIXME endpoint port and schema hardcoded
    provider_uri = var.ETHL_DEPLOYS[each.key].endpoints == "" ? join(",",
      [for node_name in var.ETHL_DEPLOYS[each.key].endpoints_ref :
        format("http://%s:8545",
          var.NODES_ENDPOINTS[node_name]["internalIP"]
        )
      ]
    ) : var.ETHL_DEPLOYS[each.key].endpoints
    project           = var.GCP_PROJECT_ID
    topic_name_prefix = format("%s%s", var.PUBSUB.topic_name_prefix, each.key)
  }
}
resource "local_file" "etl_app_values_ethl" {
  for_each          = toset(var.ETHL_CHAINS)
  filename          = format("%s/NEW-values-%s-%s.yaml", var.VALUES_PATH, var.ENV_NAME, each.key)
  file_permission   = "0644"
  sensitive_content = data.template_file.etl_app_values_ethl[each.key].rendered
}

data template_file "etl_app_values_ethl_block" {
  for_each = toset(var.ETHL_CHAINS)
  template = file(format("%s/templates/%s.tpl", path.module, "ethereum-block"))
  vars = {
    gcs_prefix = format("gs://%s/%s-etl/streaming", var.STATE_BUCKET_NAME, each.key)
  }
}
resource "local_file" "etl_app_values_output11" {
  for_each          = toset(var.ETHL_CHAINS)
  filename          = format("%s/NEW-values-%s-%s-%s.yaml", var.VALUES_PATH, var.ENV_NAME, each.key, "block")
  file_permission   = "0644"
  sensitive_content = data.template_file.etl_app_values_ethl_block[each.key].rendered
}

data template_file "etl_app_values_ethl_trace" {
  for_each = toset(var.ETHL_CHAINS)
  template = file(format("%s/templates/%s.tpl", path.module, "ethereum-trace"))
  vars = {
    gcs_prefix = format("gs://%s/%s-etl/streaming-trace", var.STATE_BUCKET_NAME, each.key)
  }
}
resource "local_file" "etl_app_values_output12" {
  for_each          = toset(var.ETHL_CHAINS)
  filename          = format("%s/NEW-values-%s-%s-%s.yaml", var.VALUES_PATH, var.ENV_NAME, each.key, "trace")
  file_permission   = "0644"
  sensitive_content = data.template_file.etl_app_values_ethl_trace[each.key].rendered
}
