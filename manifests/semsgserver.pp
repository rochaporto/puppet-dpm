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
  }

  service {
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    subscribe  => File["semsg-serviceconfig"],
    require    => [ Package["SEMsgCore"], Package["SEMsgPlugins"], ],
  }

}
