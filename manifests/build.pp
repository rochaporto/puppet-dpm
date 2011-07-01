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
     "mysql-devel", "python-devel", "gsoap", "gsoap2.7-devel", "lcg-CA", "CGSI_gSOAP_2.7-devel", 
     "swig", "argus-pep-api-c-devel"]:
      ensure => present,
  }
}
