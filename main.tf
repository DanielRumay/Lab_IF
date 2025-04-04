terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

provider "docker"{}

resource "docker_container" "container_nginx"{
	name = "nginx2"
	image = "nginx:latest"
	ports {
		external = var.nginx_external_port[terraform.workspace]
		internal = 80
	}
}