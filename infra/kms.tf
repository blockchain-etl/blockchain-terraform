resource "google_kms_key_ring" "key_ring_0" {
  project  = var.GCP_PROJECT_ID
  name     = "key-ring-0"
  location = var.GKE_MASTER_REGION
}

resource "google_kms_crypto_key" "crypto_key_0" {
  name     = "crypto-key-0"
  key_ring = google_kms_key_ring.key_ring_0.self_link
  # 30 days
  rotation_period = "2592000s"
  #https://cloud.google.com/kms/docs/reference/rest/v1/projects.locations.keyRings.cryptoKeys#CryptoKeyPurpose
  purpose = "ENCRYPT_DECRYPT"

  lifecycle {
    prevent_destroy = true
  }
}

data "google_project" "project" {
  project_id = var.GCP_PROJECT_ID
}

# allow GKE master to encrypt/decrypt secrets using kms key
resource "google_kms_crypto_key_iam_binding" "crypto_key_iam_binding_0" {
  crypto_key_id = google_kms_crypto_key.crypto_key_0.id
  role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  members = [
    format("serviceAccount:%s%s@%s", "service-", data.google_project.project.number, "container-engine-robot.iam.gserviceaccount.com"),
  ]
}
