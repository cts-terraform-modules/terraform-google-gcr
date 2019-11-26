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

variable "project" {
  description = "The project ID to deploy to."
}

variable "image_region" {
  description = "The region of the GCR's storage. Can be one of eu, us, asia or \"\". If blank, the GCR will be global."
  default = ""
}

variable "public" {
  description = "Whether the GCR is public or not."
  type = bool
  default = false
}
