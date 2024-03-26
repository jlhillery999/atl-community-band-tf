resource "google_project_service" "cloud_resource_manager_api" {
  project = var.project_id
  service = "cloudresourcemanager.googleapis.com"

  disable_dependent_services = true
}

resource "google_project_service" "firebase_api" {
  project = var.project_id
  service = "firebase.googleapis.com"

  disable_dependent_services = true
  
  depends_on = [ google_project_service.cloud_resource_manager_api ]
}

resource "google_firebase_project" "this" {
  provider = google-beta
  project  = var.project_id

  depends_on = [ google_project_service.firebase_api ]
}

resource "google_firebase_web_app" "this" {
  provider = google-beta
  project = var.project_id
  display_name = var.firebase_web_app_name

  depends_on = [ google_firebase_project.this ]
}

resource "google_kms_key_ring" "web_app" {
  project  = var.project_id
  name     = var.web_app_key_ring_name
  location = var.project_region
}

resource "google_kms_crypto_key" "firebase_api_key" {
  name     = var.firebase_api_key_name
  key_ring = google_kms_key_ring.web_app.id
  purpose  = "ENCRYPT_DECRYPT"
  rotation_period = "7776000s"
  version_template {
    algorithm         = "GOOGLE_SYMMETRIC_ENCRYPTION"
    protection_level  = "SOFTWARE"
  }
}

resource "google_kms_secret_ciphertext" "my_password" {
  crypto_key = google_kms_crypto_key.firebase_api_key.id
  plaintext  = var.firebase_api_key_text
}