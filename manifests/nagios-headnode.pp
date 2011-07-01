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

  # TODO: This should only be overwriting hostgroups, the rest should be simply defined in nagios::target
  @@nagios_host { $fqdn:
    hostgroups => "dpm-headnodes",
  }

  @@nagios_service { 
    "check_dpns_${fqdn}":
      ensure                => "present",
      host_name             => "$fqdn",
      service_description   => "DPNS service check listening at: ${fqdn}",
      check_command         => "check_nrpe!check_dpns!$dpm_ns_host 300 1000";
    "check_dpns_perf_${fqdn}":
      ensure                => "present",
      host_name             => "$fqdn",
      service_description   => "DPNS service performance check: ${fqdn}",
      check_command         => "check_nrpe!check_dpns_perf!5 10 10";
    "check_dpm_perf_${fqdn}":
      ensure                => "present",
      host_name             => "$fqdn",
      service_description   => "DPM service performance check: ${fqdn}",
      check_command         => "check_nrpe!check_dpm_perf!5 10 10";
    "check_dpm_pool_${fqdn}":
      ensure                => "present",
      host_name             => "$fqdn",
      service_description   => "DPM pools check at: ${fqdn}",
      check_command         => "check_nrpe!check_dpm_pool!5G,1G 1G,500M";
    "check_process_${fqdn}":
      ensure                => "present",
      host_name             => "$fqdn",
      service_description   => "DPM processes check at: ${fqdn}",
      check_command         => "check_nrpe!check_process!dpnsdaemon,dpm,srmv2.2";
    "check_mysql_cns_${fqdn}":
      ensure                => "present",
      host_name             => "$fqdn",
      service_description   => "CNS MySQL DB check at: ${fqdn}",
      check_command         => "check_nrpe!check_mysql!localhost root cns_db";
    "check_mysql_dpm_${fqdn}":
      ensure                => "present",
      host_name             => "$fqdn",
      service_description   => "DPM MySQL DB check at: ${fqdn}",
      check_command         => "check_nrpe!check_mysql!localhost root dpm_db";
  }

}
