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

resource "google_firebase_web_app" "this" {
    project = var.project_id
    display_name = var.firebase_web_app_name

    depends_on = [ google_project_service.firebase_api ]
}