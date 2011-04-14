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
  include dpm::nagios

  @@nagios_service { 
    "check_gridftp_${fqdn}":
      ensure                => "present",
      host_name             => "$fqdn",
      service_description   => "Gridftp service check listening at: ${fqdn}",
      check_command         => "check_nrpe!check_gridftp!${fqdn} 2811 100 1000",
      max_check_attempts    => 5,
      normal_check_interval => 10,
      retry_check_interval  => 1,
      check_period          => 24x7,
      notification_interval => 120,
      notification_period   => 24x7,
      notification_options  => "w,u,c,r,f",
      contact_groups        => "localadmins";
    "check_rfio_${fqdn}":
      ensure                => "present",
      host_name             => "$fqdn",
      service_description   => "RFIO check at: ${fqdn}",
      check_command         => "check_nrpe!check_rfio!${fqdn} 100 1000",
      max_check_attempts    => 5,
      normal_check_interval => 10,
      retry_check_interval  => 1,
      check_period          => 24x7,
      notification_interval => 120,
      notification_period   => 24x7,
      notification_options  => "w,u,c,r,f",
      contact_groups        => "localadmins";
  }

}
