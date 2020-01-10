output "nodes_endpoints" {
  description = "nodes rpc endpoints"
  value = {
    for node in data.template_file.node_values_template :
    node.vars.name => { rpcuser = node.vars.rpcuser, rpcpassword = node.vars.rpcpassword, internalIP = node.vars.internalIP }
  }
}
