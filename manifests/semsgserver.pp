# Class defining the DPM HeadNode setup of SEMSG.
#
# == Examples
#
# Simply include this class:
#   include dpm::semsg
#
# == Authors
#
# CERN IT/GT/DMS <it-dep-gt-dms@cern.ch>
#
class dpm::semsgserver {
  include dpm::semsg

  file {
    "semsg-serviceconfig":
      name    => "/etc/sysconfig/SEMsgdaemon",
      owner   => root,
      group   => root,
      mode    => 0644,
      content => template("dpm/SEMsgdaemon.erb");
    "semsg-config":
      name    => "/opt/lcg/etc/SEMsgConfig_dpmhead.cf",
      owner   => root,
      group   => root,
      mode    => 0644,
      content => template("dpm/SEMsgConfig_dpmhead.cf.erb");
  }

  service { "SEMsgdaemon":
    ensure     => running,
    enable     => true,
    hasrestart => true,
    subscribe  => File["semsg-serviceconfig", "semsg-config"],
    status     => "ps -ef | grep SEMsgdaemon",
    require    => [ 
      File["semsg-serviceconfig", "semsg-config"], Package["semsgcore"], Package["semsgplugins"], 
    ],
  }

}
