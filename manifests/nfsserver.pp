# Class defining the DPM nameserver.
#
# This corresponding to the daemon responsible for handling all the namespace
# related requests.
# 
# == Examples
#
# TODO:
#
# == Authors
#
# CERN IT/GT/DMS <it-dep-gt-dms@cern.ch>
#
class dpm::nfsserver {

  package { 
    "dpm-nfs-server": 
      ensure => latest;
  }

  file {
    "conf-dpm-nfs":
      name    => "/etc/dpm-nfs.conf",
      owner   => root,
      group   => root,
      mode    => 0600,
      content => template("dpm/dpm-nfs.conf.erb"),
      require => Package["dpm-nfs-server"];
  }

  service { "dpm-nfs":
    ensure     => running,
    enable     => true,
    hasrestart => true,
    subscribe  => File["conf-dpm-nfs"],
    require    => [ Package["dpm-nfs-server"], File["conf-dpm-nfs"], ],
    status     => "ps aux | grep ganesha", # TODO: remove this once the init script 'status' works
  }

}
