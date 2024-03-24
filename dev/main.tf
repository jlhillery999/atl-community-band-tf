resource "google_project_service" "firebase_api" {
  project = var.project_id
  service = "firebase.googleapis.com"

  disable_dependent_services = true
}

resource "google_firebase_web_app" "this" {
    provider = google-beta
    project = var.project_id
    display_name = var.firebase_web_app_name
}