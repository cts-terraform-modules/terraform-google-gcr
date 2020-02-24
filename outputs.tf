/**
 * Copyright 2018 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

output "gcr_bucket_name" {
  value       = google_container_registry.default.id
  description = "The URI of the created resource."
}

output "gcr_bucket_self_link" {
  value       = google_container_registry.default.bucket_self_link
  description = "The name of the bucket that supports the Container Registry. In the form of artifacts.{project}.appspot.com or {location}.artifacts.{project}.appspot.com if location is specified."
}
