resource "google_pubsub_topic" "btcl_blocks" {
  project    = var.GCP_PROJECT_ID
  depends_on = ["google_project_service.pubsub_svc"]
  for_each   = toset(var.BTCL_CHAINS)
  name       = format("%s%s.%s", var.PUBSUB.topic_name_prefix, each.key, "blocks")
}

resource "google_pubsub_topic" "btcl_transactions" {
  project    = var.GCP_PROJECT_ID
  depends_on = ["google_project_service.pubsub_svc"]
  for_each   = toset(var.BTCL_CHAINS)
  name       = format("%s%s.%s", var.PUBSUB.topic_name_prefix, each.key, "transactions")
}

resource "google_pubsub_subscription" "btcl_blocks" {
  project                    = var.GCP_PROJECT_ID
  depends_on                 = ["google_pubsub_topic.btcl_blocks"]
  for_each                   = toset(var.BTCL_CHAINS)
  name                       = format("%s%s.%s.%s", var.PUBSUB.subscription_name_prefix, each.key, var.PUBSUB.subscription_name_suffix, "blocks")
  topic                      = google_pubsub_topic.btcl_blocks[each.key].name
  message_retention_duration = var.PUBSUB.message_retention_duration
  retain_acked_messages      = var.PUBSUB.retain_acked_messages
  ack_deadline_seconds       = var.PUBSUB.ack_deadline_seconds
  expiration_policy {
    ttl = var.PUBSUB.expiration_policy_ttl
  }
}

resource "google_pubsub_subscription" "btcl_transactions" {
  project                    = var.GCP_PROJECT_ID
  depends_on                 = ["google_pubsub_topic.btcl_transactions"]
  for_each                   = toset(var.BTCL_CHAINS)
  name                       = format("%s%s.%s.%s", var.PUBSUB.subscription_name_prefix, each.key, var.PUBSUB.subscription_name_suffix, "transactions")
  topic                      = google_pubsub_topic.btcl_transactions[each.key].name
  message_retention_duration = var.PUBSUB.message_retention_duration
  retain_acked_messages      = var.PUBSUB.retain_acked_messages
  ack_deadline_seconds       = var.PUBSUB.ack_deadline_seconds
  expiration_policy {
    ttl = var.PUBSUB.expiration_policy_ttl
  }
}

resource "google_pubsub_topic" "ethl" {
  project    = var.GCP_PROJECT_ID
  depends_on = ["google_project_service.pubsub_svc"]
  for_each   = toset(var.ETHL_ENTITY_TYPES)
  name       = format("%s%s.%s", var.PUBSUB.topic_name_prefix, "ethereum", each.key)
}

resource "google_pubsub_subscription" "ethl" {
  project                    = var.GCP_PROJECT_ID
  depends_on                 = ["google_pubsub_topic.ethl"]
  for_each                   = toset(var.ETHL_ENTITY_TYPES)
  name                       = format("%s%s.%s.%s", var.PUBSUB.subscription_name_prefix, "ethereum", var.PUBSUB.subscription_name_suffix, each.key)
  topic                      = google_pubsub_topic.ethl[each.key].name
  message_retention_duration = var.PUBSUB.message_retention_duration
  retain_acked_messages      = var.PUBSUB.retain_acked_messages
  ack_deadline_seconds       = var.PUBSUB.ack_deadline_seconds
  expiration_policy {
    ttl = var.PUBSUB.expiration_policy_ttl
  }
}
