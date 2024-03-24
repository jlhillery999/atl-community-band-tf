variable "project_name" {
    type    = string
}

variable "project_id" {
    type    = string
}

variable "project_region" {
    type    = string
    default = "us-east1"
}

variable "project_zone" {
    type    = string
    default = "us-east1-c"
}

variable "firebase_web_app_name" {
    type    = string
}