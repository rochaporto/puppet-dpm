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



#  @@nagios_servicegroup {
#    "all-check_cpu":
#      alias => "All check_cpu service instances";
#    "all-check_hostcert":
#      alias => "All check_hostcert service instances";
#    "all-check_network":
#      alias => "All check_network service instances";
#  }

class dpm::nagios inherits nagios::target {
  include nagios::target

  package { ["nagios-plugins-lcgdm", "python-dpm", "uberftp"]: ensure => latest, }

  file { "/etc/nrpe.d/dpm.cfg":
    mode    => "0644",
    owner   => root,
    group   => root,
    content => template("dpm/nrpe-dpm.cfg"),
    notify  => Service["xinetd"],
    require => [ 
      File["/etc/nrpe.d"], 
      Package["nagios-plugins-lcgdm", "python-dpm"],
    ];
  }

  @@nagios_service { 
    "check_cpu_${fqdn}":
      ensure                => "present",
      host_name             => "$fqdn",
      service_description   => "CPU check at: ${fqdn}",
      check_command         => "check_nrpe!check_cpu!60,60,60,100,80,60,60 70,70,70,100,90,70,70 5";
    "check_hostcert_${fqdn}":
      ensure                => "present",
      host_name             => "$fqdn",
      service_description   => "Host certificate check at: ${fqdn}",
      check_command         => "check_nrpe!check_hostcert!/etc/grid-security/hostcert.pem 30 5";
    "check_network_${fqdn}":
      ensure                => "present",
      host_name             => "$fqdn",
      service_description   => "Network check at: ${fqdn}",
      check_command         => "check_nrpe!check_network!eth0";
  }
}
