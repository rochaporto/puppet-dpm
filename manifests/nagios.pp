import 'nagios'

# Class defining the LCGDM Nagios plugins.
#
# == Examples
#
# Simply include this class, as in:
#  include nagios::master
#
# == Authors
#
# CERN IT/GT/DMS <it-dep-gt-dms@cern.ch>
#
class dpm::nagios inherits nagios::target {
  include nagios::target

  package { ["lcgdm-nagios-plugins", "python-dpm", "uberftp"]: ensure => latest, }

  file { "/etc/nrpe.d/dpm.cfg":
    mode    => "0644",
    owner   => root,
    group   => root,
    content => template("dpm/nrpe-dpm.cfg"),
    notify  => Service["xinetd"],
    require => [ 
      File["/etc/nrpe.d"], 
      Package["lcgdm-nagios-plugins", "python-dpm"],
    ];
  }

#  @@nagios_hostgroup { 
#    "dpm-headnodes":
#      alias => "DPM Head Nodes";
#    "dpm-disknodes":
#      alias => "DPM Disk Nodes";
#  }

#  @@nagios_servicegroup {
#    "all-check_cpu":
#      alias => "All check_cpu service instances";
#    "all-check_hostcert":
#      alias => "All check_hostcert service instances";
#    "all-check_network":
#      alias => "All check_network service instances";
#  }

  @@nagios_service { 
    "check_cpu_${fqdn}":
      ensure                => "present",
      host_name             => "$fqdn",
      service_description   => "CPU check at: ${fqdn}",
      check_command         => "check_nrpe!check_cpu!60,60,60,100,80,60,60 70,70,70,100,90,70,70 5",
#      servicegroups         => "all-check_cpu",
      max_check_attempts    => 5,
      normal_check_interval => 10,
      retry_check_interval  => 1,
      check_period          => 24x7,
      notification_interval => 120,
      notification_period   => 24x7,
      notification_options  => "w,u,c,r,f",
      contact_groups        => "localadmins";
    "check_hostcert_${fqdn}":
      ensure                => "present",
      host_name             => "$fqdn",
      service_description   => "Host certificate check at: ${fqdn}",
      check_command         => "check_nrpe!check_hostcert!/etc/grid-security/hostcert.pem 30 5",
#      servicegroups         => "all-check_hostcert",
      max_check_attempts    => 5,
      normal_check_interval => 10,
      retry_check_interval  => 1,
      check_period          => 24x7,
      notification_interval => 120,
      notification_period   => 24x7,
      notification_options  => "w,u,c,r,f",
      contact_groups        => "localadmins";
    "check_network_${fqdn}":
      ensure                => "present",
      host_name             => "$fqdn",
      service_description   => "Network check at: ${fqdn}",
      check_command         => "check_nrpe!check_network!eth0",
#      servicegroups         => "all-check_network",
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
