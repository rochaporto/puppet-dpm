# Class defining a DPM client.
#
# It installs and manages all the required environment and configuration files.
# 
# == Examples
#
# TODO:
#
# == Authors
#
# CERN IT/GT/DMS <it-dep-gt-dms@cern.ch>
#
class dpm::client  {
  include grid-common

  package { 
    "dpm": 
      ensure => latest, 
      notify => $grid_flavour ? {
        "glite" => Exec["glite_ldconfig"],
        default => undef,
      }
  }

  file {
    "/etc/profile.d/dpm.sh":
      ensure  => present,
      owner   => root,
      group   => root,
      mode    => 644,
      content => template("dpm/dpm-profile.erb");
  }
}
