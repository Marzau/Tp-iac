terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.0"
    }
  }
}

provider "docker" {}

# Déploiement du conteneur HTTP (NGINX)
resource "docker_image" "nginx" {
  name = "nginx:1.27"
}

resource "docker_container" "http_container" {
  image = docker_image.nginx.name
  name  = "http-container"
  ports {
    internal = 80
    external = 8080
  }
}

# Déploiement du conteneur PHP-FPM
resource "docker_image" "php_fpm" {
  name = "php:7.4-fpm"
}

resource "docker_container" "php_container" {
  image = docker_image.php_fpm.name
  name  = "php-container"
}

# Déploiement du conteneur de base de données MySQL
resource "docker_image" "mysql" {
  name = "mysql:8.0"
}

resource "docker_container" "db_container" {
  image = docker_image.mysql.name
  name  = "db-container"
  env = [
    "MYSQL_ROOT_PASSWORD=rootpassword",
    "MYSQL_DATABASE=testdb"
  ]
  ports {
    internal = 3306
    external = 3306
  }
}
