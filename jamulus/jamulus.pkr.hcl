source "googlecompute" "jamulus" {
  image_name = "ubuntu2004-jamulus"
  project_id = "varokas"
  source_image = "ubuntu-minimal-2004-focal-v20210416"
  ssh_username = "packer"
  zone = "us-central1-a"


}

build {
  sources = ["sources.googlecompute.jamulus"]

  provisioner "file"{
    source = "Caddyfile"
    destination = "/etc/caddy/Caddyfile"
  }

  provisioner "file"{
    source = "index.html"
    destination = "/etc/html/index.html"
  }

  provisioner "shell" {
    script = "jamulus.sh"
  }


}