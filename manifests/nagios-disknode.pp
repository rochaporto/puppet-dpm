# Class defining the LCGDM Nagios plugins.
#
# == Examples
#
# Simply include this class, as in:
#  include dpm::nagios::headnode
#
# == Authors
#
# CERN IT/GT/DMS <it-dep-gt-dms@cern.ch>
#
class dpm::nagios::disknode inherits dpm::nagios {

  @@nagios_host { $fqdn:
    hostgroups => "dpm-disknodes",
  }

#  @@nagios_service { 
#    "check_gridftp_${fqdn}":
#      ensure                => "present",
#      host_name             => "$fqdn",
#      service_description   => "Gridftp service check listening at: ${fqdn}",
#      check_command         => "check_nrpe!check_gridftp!${fqdn} 2811 100 1000";
#    "check_rfio_${fqdn}":
#      ensure                => "present",
#      host_name             => "$fqdn",
#      service_description   => "RFIO check at: ${fqdn}",
#      check_command         => "check_rfio!100!1000";
#  }

}
