resource "google_project" "this" {
  name       = var.project_name
  project_id = var.project_id
}