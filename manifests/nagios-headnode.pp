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
class dpm::nagios::headnode inherits dpm::nagios {
  include dpm::nagios

#  @@nagios_host { $fqdn:
#    hostgroups => "dpm-headnodes"
#  }

#  @@nagios_servicegroup {
#    "all-check_dpns":
#      alias => "All check_dpns service instances";
#    "all-check_dpm_pool":
#      alias => "All check_dpm_pool service instances";
#    "all-check_process":
#      alias => "All check_process service instances";
#  }

  @@nagios_service { 
    "check_dpns_${fqdn}":
      ensure                => "present",
      host_name             => "$fqdn",
      service_description   => "DPNS service check listening at: ${fqdn}",
      check_command         => "check_nrpe!check_dpns!$dpm_ns_host 300 1000",
      max_check_attempts    => 5,
      normal_check_interval => 10,
      retry_check_interval  => 1,
      check_period          => 24x7,
      notification_interval => 120,
      notification_period   => 24x7,
      notification_options  => "w,u,c,r,f",
      contact_groups        => "localadmins";
    "check_dpm_pool_${fqdn}":
      ensure                => "present",
      host_name             => "$fqdn",
      service_description   => "DPM pools check at: ${fqdn}",
      check_command         => "check_nrpe!check_dpm_pool!5G,1G 1G,500M",
      max_check_attempts    => 5,
      normal_check_interval => 10,
      retry_check_interval  => 1,
      check_period          => 24x7,
      notification_interval => 120,
      notification_period   => 24x7,
      notification_options  => "w,u,c,r,f",
      contact_groups        => "localadmins";
    "check_process_${fqdn}":
      ensure                => "present",
      host_name             => "$fqdn",
      service_description   => "DPM processes check at: ${fqdn}",
      check_command         => "check_nrpe!check_process!dpnsdaemon,dpns,srmv2.2",
      max_check_attempts    => 5,
      normal_check_interval => 10,
      retry_check_interval  => 1,
      check_period          => 24x7,
      notification_interval => 120,
      notification_period   => 24x7,
      notification_options  => "w,u,c,r,f",
      contact_groups        => "localadmins";
    "check_mysql_cns_${fqdn}":
      ensure                => "present",
      host_name             => "$fqdn",
      service_description   => "CNS MySQL DB check at: ${fqdn}",
      check_command         => "check_nrpe!check_mysql!localhost root cns_db",
      max_check_attempts    => 5,
      normal_check_interval => 10,
      retry_check_interval  => 1,
      check_period          => 24x7,
      notification_interval => 120,
      notification_period   => 24x7,
      notification_options  => "w,u,c,r,f",
      contact_groups        => "localadmins";
    "check_mysql_dpm_${fqdn}":
      ensure                => "present",
      host_name             => "$fqdn",
      service_description   => "DPM MySQL DB check at: ${fqdn}",
      check_command         => "check_nrpe!check_mysql!localhost root dpm_db",
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
