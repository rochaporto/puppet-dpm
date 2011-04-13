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

  package { ["lcgdm-nagios-plugins", "python-dpm"]: ensure => latest, }

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

  @@nagios_service { 
    "check_cpu_${fqdn}":
      ensure                => "present",
      host_name             => "$fqdn",
      service_description   => "CPU check at: ${fqdn}",
      check_command         => "check_nrpe!check_cpu",
      max_check_attempts    => 5,
      normal_check_interval => 10,
      retry_check_interval  => 1,
      check_period          => 24x7,
      notification_interval => 120,
      notification_period   => 24x7,
      notification_options  => "w,u,c,r,f",
      contact_groups        => "localadmins",
  }

  @@nagios_service { 
    "check_network_${fqdn}":
      ensure                => "present",
      host_name             => "$fqdn",
      service_description   => "Network check at: ${fqdn}",
      check_command         => "check_nrpe!check_network!eth0",
      max_check_attempts    => 5,
      normal_check_interval => 10,
      retry_check_interval  => 1,
      check_period          => 24x7,
      notification_interval => 120,
      notification_period   => 24x7,
      notification_options  => "w,u,c,r,f",
      contact_groups        => "localadmins",
  }

  @@nagios_service { 
    "check_hostcert_${fqdn}":
      ensure                => "present",
      host_name             => "$fqdn",
      service_description   => "Host certificate check at: ${fqdn}",
      check_command         => "check_nrpe!check_hostcert!/etc/grid-security/hostcert.pem 30 5",
      max_check_attempts    => 5,
      normal_check_interval => 10,
      retry_check_interval  => 1,
      check_period          => 24x7,
      notification_interval => 120,
      notification_period   => 24x7,
      notification_options  => "w,u,c,r,f",
      contact_groups        => "localadmins",
  }

}
