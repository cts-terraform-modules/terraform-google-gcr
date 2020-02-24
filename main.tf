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

data "google_container_registry_repository" "default" {
  project = var.project
  region  = var.image_region
}

data "google_container_registry_image" "bootstrapper" {
  project = var.project
  name    = "bootstrapper"
  region  = var.image_region
}

resource "null_resource" "bootstrap_image_build" {
  triggers = {
    time = timestamp()
  }
  provisioner "local-exec" {
    command = "${path.module}/src/bootstrapper.sh"

    environment = {
      REGION          = var.image_region
      PROJECT         = var.project
      IMAGE_NAME      = data.google_container_registry_image.bootstrapper.image_url
      DOCKERFILE_PATH = "${path.module}/src"
    }
  }
}

locals {
  gcr_bucket = var.image_region == "" ? "artifacts.${var.project}.appspot.com" : "${var.image_region}.artifacts.${var.project}.appspot.com"
}

resource "google_storage_default_object_access_control" "public_rule" {
  count  = var.public ? 1 : 0
  bucket = local.gcr_bucket
  role   = "READER"
  entity = "allUsers"

  depends_on = [
    null_resource.bootstrap_image_build
  ]
}

resource "google_storage_bucket_acl" "image-store-acl" {
  count  = var.public ? 1 : 0
  bucket = local.gcr_bucket

  predefined_acl = "publicRead"
  depends_on = [
    null_resource.bootstrap_image_build
  ]
}