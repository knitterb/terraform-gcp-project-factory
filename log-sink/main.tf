provider "google" {
  project     = "${var.project_id}"
  region      = "us-central1"
}

resource "google_logging_project_sink" "my-sink" {
    name = "my-pubsub-instance-sink"
    destination = "pubsub.googleapis.com/projects/${var.project_id}/topics/${google_pubsub_topic.pubsub-sink.name}"
}

resource "google_pubsub_topic" "pubsub-sink" {
  name = "log-sink"
}


