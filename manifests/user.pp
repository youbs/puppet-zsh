define zsh::user(
  $ensure = present,
  $path   = "/usr/bin/zsh",
  $source = ""
  ) {

  exec { "chsh -s $path $name":
    unless => "grep -E '^${name}.+:${$path}$' /etc/passwd",
  }

  if $name != "root" {
    file { "/home/${name}/.zshrc":
      source => $source,
      owner  => $name,
      group  => $name,
      ensure => file,
    }
  }

  if $name == "root" {
    file { "/root/.zshrc":
      source => $source,
      ensure => file,
    }
  }

}
