data template_file "etl_app_values_template" {
  for_each = toset(var.BTCL_CHAINS)
  template = file(format("%s/templates/%s.tpl", path.module, "btc"))
  vars = {
    # FIXME endpoint port hardcoded
    provider_uri      = join(",", [for node_name in var.NODES_NAMES[each.key] : format("http://%s:%s@%s:8332", var.NODES_ENDPOINTS[node_name]["rpcuser"], var.NODES_ENDPOINTS[node_name]["rpcpassword"], var.NODES_ENDPOINTS[node_name]["internalIP"])])
    project           = var.GCP_PROJECT_ID
    topic_name_prefix = format("%s%s", var.PUBSUB.topic_name_prefix, each.key)
    gcs_prefix        = format("gs://%s/%s-etl/streaming", var.STATE_BUCKET_NAME, each.key)
  }
}
resource "local_file" "etl_app_values_output" {
  for_each          = toset(var.BTCL_CHAINS)
  filename          = format("%s/values-%s-%s.yaml", var.VALUES_PATH, var.ENV_NAME, each.key)
  file_permission   = "0644"
  sensitive_content = data.template_file.etl_app_values_template[each.key].rendered
}
