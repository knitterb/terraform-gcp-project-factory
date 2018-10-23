provider "google" {
  project = "${var.project_id}"
  credentials = "${var.credentials_path}"
}

resource "google_storage_bucket" "terraform-bucket" {
  project  = "${var.project_id}"
  name     = "${var.project_id}-terraform"
  location = "us-west2"
}
resource "google_storage_bucket" "credential-bucket" {
  name     = "${var.project_id}-credentials"
  location = "us-west2"
}
resource "google_storage_bucket_object" "credentials" {
  name   = "credentials.json"
  source = "${var.credentials_path}"
  bucket = "${google_storage_bucket.credential-bucket.name}"
}

resource "google_cloudbuild_trigger" "build_trigger" {
  trigger_template {
    branch_name = "master"
    repo_name   = "${var.repository}"
  }
  build {
    step {
      name = "gcr.io/cloud-builders/gsutil"
      args = "cp gs://${google_storage_bucket.credential-bucket.name}/credentials.json ."
    }
    step {
      name = "gcr.io/cloud-builders/docker"
      args = "build --network=host --build-arg BUCKET=${google_storage_bucket.terraform-bucket.name} -t gcr.io/$PROJECT_ID/$REPO_NAME:$SHORT_SHA -f Dockerfile ."
    }
    step {
      name = "gcr.io/cloud-builders/docker"
      args = "run --network=host gcr.io/$PROJECT_ID/$REPO_NAME:$SHORT_SHA terraform plan -lock=true -lock-timeout=${var.lock_timeout}s -var organization_id=${var.organization_id} -var billing_account=${var.billing_account} -var repository=${var.repository} -var project_prefix=knitter-build"
    }
    step {
      name = "gcr.io/cloud-builders/docker"
      args = "run --network=host gcr.io/$PROJECT_ID/$REPO_NAME:$SHORT_SHA terraform apply -lock=true -lock-timeout=${var.lock_timeout}s -auto-approve -var organization_id=${var.organization_id} -var billing_account=${var.billing_account} -var repository=${var.repository} -var project_prefix=knitter-build"
    }
  }
}
