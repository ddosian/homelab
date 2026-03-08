resource "adguard_rewrite" "fw-prod-01" {
  domain = "fw-prod-01.local.dontddos.me"
  answer = "10.0.1.1"
}

resource "adguard_rewrite" "pve-prod-01" {
  domain = "pve-prod-01.local.dontddos.me"
  answer = "10.0.1.11"
}

resource "adguard_rewrite" "docker-prod-01" {
  domain = "docker-prod-01.local.dontddos.me"
  answer = "10.0.1.102"
}

resource "adguard_rewrite" "docker-prod-02" {
  domain = "docker-prod-02.local.dontddos.me"
  answer = "10.0.1.104"
}

resource "adguard_rewrite" "dns-prod-01" {
  domain = "dns-prod-01.local.dontddos.me"
  answer = "10.0.1.103"
}

resource "adguard_rewrite" "adguard-home-prod-01" {
  domain = "adguard-home-prod-01.local.dontddos.me"
  answer = "10.0.1.103"
}

resource "adguard_rewrite" "nas-prod-01" {
  domain = "nas-prod-01.local.dontddos.me"
  answer = "10.0.1.5"
}

# services:
resource "adguard_rewrite" "vaultwarden" {
  domain = "vaultwarden.local.dontddos.me"
  answer = "10.0.1.102"
}

resource "adguard_rewrite" "prowlarr" {
  domain = "prowlarr.local.dontddos.me"
  answer = "10.0.1.104"
}

resource "adguard_rewrite" "qbittorrent" {
  domain = "qbittorrent.local.dontddos.me"
  answer = "10.0.1.104"
}

resource "adguard_rewrite" "radarr" {
  domain = "radarr.local.dontddos.me"
  answer = "10.0.1.104"
}

resource "adguard_rewrite" "sonarr" {
  domain = "sonarr.local.dontddos.me"
  answer = "10.0.1.104"
}