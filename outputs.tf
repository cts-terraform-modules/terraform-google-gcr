output "gcr_bucket_name" {
  value       = google_container_registry.default.id
  description = "The URI of the created resource."
}

output "gcr_bucket_self_link" {
  value       = google_container_registry.default.bucket_self_link
  description = "The name of the bucket that supports the Container Registry. In the form of artifacts.{project}.appspot.com or {location}.artifacts.{project}.appspot.com if location is specified."
}
