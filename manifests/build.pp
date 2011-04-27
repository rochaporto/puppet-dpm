# Setup a machine with all the requirements to properly build lcgdm. 
# 
# == Examples
#
#
# == Authors
#
# CERN IT/GT/DMS <it-dep-gt-dms@cern.ch>
#
class dpm::build {

  package { 
    ["subversion", "globus-gss-assist-devel", "globus-gssapi-gsi-devel", "voms-devel", 
     "mysql-devel", "python-devel", "gsoap-devel", "CGSI-gSOAP-devel", "lcg-CA"]:
      ensure => present,
  }
}
