output "nodes_endpoints" {
  description = "nodes rpc endpoints"
  # FIXME schema and port hardcode, eth w/o auth and password unsupported
  value = {
    for node in data.template_file.node_values_template :
    node.vars.name => {
      rpcuser     = node.vars.rpcuser,
      rpcpassword = node.vars.rpcpassword,
      internalIP  = node.vars.internalIP,
      endpoint    = format("%s://%s:%s@%s:%s", "http", node.vars.rpcuser, node.vars.rpcpassword, node.vars.internalIP, "8332"),
    }
  }
}
