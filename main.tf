provider "google" {
  project = "practice1-430917"
  region  = "asia-south2"
}

resource "google_compute_network" "vpc_network" {
  name                    = "instance-test1"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
  name          = "instance-test-pub1"
  ip_cidr_range = "10.143.1.0/24"
  network       = google_compute_network.vpc_network.self_link
  region        = "asia-south2"
}

resource "google_compute_instance" "vm_instance" {
  name         = "my-vm-instance1"
  machine_type = "e2-small"
  zone         = "asia-south2-a"

  boot_disk {
    initialize_params {
      image = "ubuntu-2404-noble-amd64-v20240806"
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.self_link
    subnetwork = google_compute_subnetwork.subnet.self_link
    access_config {
      // Ephemeral IP
    }
  }
}
