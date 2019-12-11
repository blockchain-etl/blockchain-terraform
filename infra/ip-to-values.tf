data template_file "node_values_template" {
  for_each = var.IP_LIST
  template = file(format("templates/%s.tpl", each.value))
  vars = {
    externalIP = google_compute_address.chain[each.key].address
    internalIP = google_compute_address.ilb[each.key].address
    # check NODES_USERS for override or use node name
    rpcuser = lookup(var.NODES_USERS, each.key, each.key)
    # check NODES_PASSWORDS for override or use generated
    rpcpassword = lookup(var.NODES_PASSWORDS, each.key, random_string.node_rpc_password[each.key].result)
  }
}
resource "random_string" "node_rpc_password" {
  for_each = var.IP_LIST
  length   = 16
  special  = false
}
resource "local_file" "node_values_output" {
  for_each          = var.IP_LIST
  filename          = format("%s/values-%s-%s.yaml", var.VALUES_PATH, var.ENV_NAME, each.key)
  file_permission   = "0644"
  sensitive_content = data.template_file.node_values_template[each.key].rendered
}
