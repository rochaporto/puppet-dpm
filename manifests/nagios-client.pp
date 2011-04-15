# Class defining the LCGDM Client nagios configuration.
#
# == Examples
#
# Simply include this class, as in:
#  include dpm::nagios::client
#
# == Authors
#
# CERN IT/GT/DMS <it-dep-gt-dms@cern.ch>
#
class dpm::nagios::client inherits dpm::nagios {
  @@nagios_host { $fqdn:
    hostgroups => "dpm-clientnodes",
  }
}
