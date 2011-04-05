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
class dpm::semsg {

  package { 
    "semsgcore":
      ensure => latest;
    "semsgplugins": 
      ensure  => latest,
  }

}
