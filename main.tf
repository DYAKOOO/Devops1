
provider "google" {
  project = "mlops-387500"
  region  = "us-central1"  # Change this to your desired region
  
}

locals {
  instance_names = ["jenkins", "master", "nexus", "node1", "sonar"]
}

resource "google_compute_instance" "vm_instance" {
  count        = length(local.instance_names)
  name         = local.instance_names[count.index]
  machine_type = "e2-medium"
  zone         = "us-central1-a"  # Change this to your desired zone
  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
      size  = 20
    }
  }

  network_interface {
    network = "default"
    access_config {
      // Allow HTTP and HTTPS ports
      nat_ip = google_compute_address.vm_public_ip[count.index].address
    }
  }

  // Tags to allow HTTP and HTTPS traffic
  tags = ["http-server", "https-server"]

  metadata_startup_script = <<-EOT
    #!/bin/bash
    # Enable all Cloud APIs
    gcloud services enable --all
  EOT
}

resource "google_compute_address" "vm_public_ip" {
  count = length(local.instance_names)
  name  = "my-public-ip-${local.instance_names[count.index]}" #dfdf
}