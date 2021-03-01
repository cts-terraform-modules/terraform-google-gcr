resource "google_container_registry" "default" {
  project  = var.project
  location = var.image_region
}

resource "google_storage_default_object_access_control" "public_rule" {
  count  = var.public ? 1 : 0
  bucket = google_container_registry.default.id
  role   = "READER"
  entity = "allUsers"
}

resource "google_storage_bucket_acl" "image-store-acl" {
  count  = var.public ? 1 : 0
  bucket = google_container_registry.default.id

  predefined_acl = "publicRead"
}
