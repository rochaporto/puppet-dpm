class dpm::build {

  package { 
    ["subversion", "globus-gss-assist-devel", "globus-gssapi-gsi-devel", "voms-devel", 
     "mysql-devel", "python-devel", "gsoap-devel", "CGSI-gSOAP-devel"]:
      ensure => present,
  }
}
