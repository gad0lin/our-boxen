# This file manages Puppet module dependencies.
#
# It works a lot like Bundler. We provide some core modules by
# default. This ensures at least the ability to construct a basic
# environment.

# Shortcut for a module from GitHub's boxen organization
def github(name, *args)
  options ||= if args.last.is_a? Hash
    args.last
  else
    {}
  end

  if path = options.delete(:path)
    mod name, :path => path
  else
    version = args.first
    options[:repo] ||= "boxen/puppet-#{name}"
    mod name, version, :github_tarball => options[:repo]
  end
end

# Shortcut for a module under development
def dev(name, *args)
  mod name, :path => "#{ENV['HOME']}/src/boxen/puppet-#{name}"
end

# Includes many of our custom types and providers, as well as global
# config. Required.

github "boxen", "3.7.0"
github "python"
# Support for default hiera data in modules

github "module_data", "0.0.3", :repo => "ripienaar/puppet-module-data"

# Core modules for a basic development environment. You can replace
# some/most of these if you want, but it's not recommended.

github "dnsmasq",     "2.0.0"
github "foreman",     "1.2.0"
github "gcc",         "2.2.0"
github "git",         "2.5.0"
github "go",          "1.1.0"
github "homebrew",    "1.9.5"
github "hub",         "1.3.0"
github "inifile",     "1.1.1", :repo => "puppetlabs/puppetlabs-inifile"
github "nginx",       "1.4.3"
github "nodejs",      "3.8.1"
github "openssl",     "1.0.0"
github "phantomjs",   "2.3.0"
github "pkgconfig",   "1.0.0"
github "repository",  "2.3.0"
github "ruby",        "8.1.4"
github "stdlib",      "4.2.1", :repo => "puppetlabs/puppetlabs-stdlib"
github "sudo",        "1.0.0"
github "xquartz",     "1.2.1"




# Optional/custom modules. There are tons available at
# https://github.com/boxen.

github "vagrant",     "3.2.0"
github "alfred",     "1.3.1"
github "vlc",        "1.1.0"
github "virtualbox",     "1.0.13"
github "packer",     "1.3.0"
github "dropbox",     "1.4.1"
github "vim",     "1.0.5"
#github "induction", "1.0.0"
github "intellij", "1.5.1"
github "tmux", "1.0.2"
github "zsh", "1.0.0"
github "chrome", "1.5.1"
github "eclipse", "2.4.1"
github 'evernote', "2.0.7"
github 'chicken_of_the_vnc', '1.0.0'
github "libreoffice",     "4.2.5"
github "mongodb", "2.6.1"
github "skype", '1.0.9'
github "cyberduck", '1.0.1'
github "firefox", '1.2.3'
github "sublime_text", '1.0.2'
github "toggl", '1.0.6'
github "tor", '1.0.6'
github "spotify", "1.0.2"

