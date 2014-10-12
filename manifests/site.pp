require boxen::environment
require homebrew
require gcc

Exec {
  group       => 'staff',
  logoutput   => on_failure,
  user        => $boxen_user,

  path => [
    "${boxen::config::home}/rbenv/shims",
    "${boxen::config::home}/rbenv/bin",
    "${boxen::config::home}/rbenv/plugins/ruby-build/bin",
    "${boxen::config::home}/homebrew/bin",
    '/usr/bin',
    '/bin',
    '/usr/sbin',
    '/sbin'
  ],

  environment => [
    "HOMEBREW_CACHE=${homebrew::config::cachedir}",
    "HOME=/Users/${::boxen_user}"
  ]
}

File {
  group => 'staff',
  owner => $boxen_user
}

Package {
  provider => homebrew,
  require  => Class['homebrew']
}

Repository {
  provider => git,
  extra    => [
    '--recurse-submodules'
  ],
  require  => File["${boxen::config::bindir}/boxen-git-credential"],
  config   => {
    'credential.helper' => "${boxen::config::bindir}/boxen-git-credential"
  }
}

Service {
  provider => ghlaunchd
}

Homebrew::Formula <| |> -> Package <| |>

node default {
  # core modules, needed for most things
  include python
  include python::virtualenvwrapper
  include dnsmasq
  include git
  include hub
  include nginx
  include vagrant
  include alfred
  include vlc
  include osx::dock::autohide
  include osx::finder::show_all_on_desktop
  include osx::universal_access::ctrl_mod_zoom
  include osx::dock::clear_dock
  #include osx
  include vim
  vim::bundle { [
    'scrooloose/syntastic',
    'sjl/gundo.vim',
    'scrooloose/nerdtree'
  ]: }

  vim::bundle { 'wincent/Command-T.git': }
  vim::bundle { 'Bogdanp/rbrepl.vim.git': }
  vim::bundle { 'Lokaltog/vim-powerline.git': }
  vim::bundle { 'Raimondi/delimitMate.git': }
  vim::bundle { 'Valloric/YouCompleteMe.git': }
  vim::bundle { 'digitaltoad/vim-jade.git': }
  vim::bundle { 'epeli/slimux.git': }
  vim::bundle { 'godlygeek/tabular': }
  vim::bundle { 'guns/vim-clojure-static.git': }
  vim::bundle { 'hallison/vim-markdown': }
  vim::bundle { 'heavenshell/vim-jsdoc.git': }
  vim::bundle { 'kchmck/vim-coffee-script.git': }
  vim::bundle { 'kien/ctrlp.vim': }
  vim::bundle { 'kien/rainbow_parentheses.vim.git': }
  vim::bundle { 'mattn/zencoding-vim.git': }
  vim::bundle { 'mileszs/ack.vim.git': }
  vim::bundle { 'ndhoule/vim-ragtag.git': }
  vim::bundle { 'rodjek/vim-puppet.git': }
  vim::bundle { 'slim-template/vim-slim.git': }
  vim::bundle { 'terryma/vim-multiple-cursors.git': }
  vim::bundle { 'tomtom/tcomment_vim.git': }
  vim::bundle { 'tpope/vim-fugitive': }
  vim::bundle { 'tpope/vim-haml.git': }
  vim::bundle { 'tpope/vim-repeat.git': }
  vim::bundle { 'tpope/vim-surround': }
  vim::bundle { 'vim-ruby/vim-ruby': }
  vim::bundle { 'vim-scripts/Rename.git': }
  vim::bundle { 'vim-scripts/YankRing.vim.git': }
  vim::bundle { 'vim-scripts/bufexplorer.zip.git': }
  vim::bundle { 'vim-scripts/bufkill.vim.git': }
  vim::bundle { 'vim-scripts/fakeclip.git': }
  vim::bundle { 'vim-scripts/guicolorscheme.vim': }
  vim::bundle { 'vim-scripts/jQuery.git': }
  vim::bundle { 'vim-scripts/scratch.vim.git': }

  ## Snipmate Plugins
  vim::bundle { 'garbas/vim-snipmate.git': }
  vim::bundle { 'MarcWeber/vim-addon-mw-utils.git': }
  vim::bundle { 'tomtom/tlib_vim.git': }
  vim::bundle { 'honza/vim-snippets.git': }

  ## Themes
  vim::bundle { 'altercation/vim-colors-solarized.git': }
  vim::bundle { 'tomasr/molokai.git': }
  vim::bundle { 'trapd00r/neverland-vim-theme.git': }


  repository { "/Users/${::boxen_user}/.dotfiles":
    source  => "${::github_login}/dotfiles-1"
  }
	file { "/Users/${::boxen_user}/.vim/swap":
    ensure => directory
	}
	file { "/Users/${::boxen_user}/.vim/backup":
    ensure => directory
	}


  file { "${vim::vimrc}":
    target  => "/Users/${::boxen_user}/.dotfiles/.vimrc",
    require => Repository["/Users/${::boxen_user}/.dotfiles"]
  }
  osx::recovery_message { 'If this Mac is found, please contact  itsaloon@gmx.com': }
  #include libreoffice
  include virtualbox
  include packer
  include dropbox
  include macvim
  include induction
  include tmux
  include chrome
  class { 'intellij':
    edition => 'ultimate',
      version => '13.1.1'
  }
  include eclipse::jee 
  include evernote
#  include chicken_of_the_vnc

  # fail if FDE is not enabled
  if $::root_encrypted == 'no' {
    fail('Please enable full disk encryption and try again')
  }

  # node versions
  include nodejs::v0_6
  include nodejs::v0_8
  include nodejs::v0_10

  # default ruby versions
  ruby::version { '1.9.3': }
  ruby::version { '1.9.3-p484': }
  ruby::version { '2.0.0': }
  ruby::version { '2.1.0': }
  ruby::version { '2.1.1': }
  ruby::version { '2.1.2': }

  # common, useful packages
  package {
    [
      'ack',
      'findutils',
      'gnu-tar',
      'csshx'
    ]:
  }

  file { "${boxen::config::srcdir}/our-boxen":
    ensure => link,
    target => $boxen::config::repodir
  }
}
