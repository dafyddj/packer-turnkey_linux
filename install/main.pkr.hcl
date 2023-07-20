variable "headless" {
  type    = bool
  default = true
}

variable "shutdown_command" {
  type    = string
  default = "shutdown -h now"
}

variable "ssh_password" {
  type    = string
  default = "Vagrant1"
}

variable "ssh_username" {
  type    = string
  default = "root"
}

source "virtualbox-vm" "install" {
  boot_wait               = "-1s"
  force_delete_snapshot   = true
  guest_additions_mode    = "disable"
  headless                = var.headless
  keep_registered         = true
  shutdown_command        = var.shutdown_command
  skip_export             = true
  ssh_password            = var.ssh_password
  ssh_timeout             = "10000s"
  ssh_username            = var.ssh_username
  target_snapshot         = "installed"
  virtualbox_version_file = ""
  vm_name                 = source.name
}

build {
  name = "install"

  source "virtualbox-vm.install" {
    name    = "tkl142"
  }

  source "virtualbox-vm.install" {
    name    = "tkl15"
  }

  source "virtualbox-vm.install" {
    name    = "tkl16"
  }

  source "virtualbox-vm.install" {
    name    = "tkl17"
  }
}
