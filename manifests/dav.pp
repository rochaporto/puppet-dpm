# Class defining the DPM HTTP / WebDAV Service.
#
# A DPM frontend offering access to data and metadata using the HTTP and WebDAV protocols.
# 
# == Examples
#
# TODO:
#
# == Authors
#
# CERN IT/GT/DMS <it-dep-gt-dms@cern.ch>
#
class dpm::dav {
  include dpm::service

  package {
    "dpm-dav":
      ensure => latest,
      notify => Exec["glite_ldconfig"];
    "mod_ssl":
      ensure => latest,
  }

  file {
    "dpm-dav-conf":
      name    => $grid_flavour ? {
        "glite" => "/opt/lcg/etc/dpm-dav/conf.d/dav_dpm.conf",
        default => "/etc/dpm-dav/conf.d/dav_dpm.conf",
      },
      owner   => root,
      group   => root,
      mode    => 644,
      content => template("dpm/dpm_dav.erb"),
      require => Package["dpm-dav"],
  }

  service { "dpm-dav":
    ensure => running,
    enable => true,
    hasrestart => true,
    hasstatus  => true,
    subscribe  => File["dpm-dav-conf"],
    path       => ["/etc/init.d", "/opt/lcg/etc/init.d"],
    require    => [ Package["dpm-dav", "mod_ssl"], File["dpm-dav-conf"], ],
  }
}
