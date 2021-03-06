class dpm::dteam {
  include voms::dteam
  include dpm::lcgdmmap

  # grid-mapfile mapping to local account (we use nobody, no pool accounts needed)
  grid-common::gridmap::group { 
    "voms_dteam_cern":
      file     => $grid_flavour ? {
        "glite" => "/opt/edg/etc/edg-mkgridmap.conf",
        default => "/etc/edg-mkgridmap.conf",
      },
      voms_uri => "vomss://voms.hellasgrid.gr:8443/voms/dteam?/dteam",
      map      => "nobody";
    "voms_dteam_tbed":
      file     => $grid_flavour ? {
        "glite" => "/opt/edg/etc/edg-mkgridmap.conf",
        default => "/etc/edg-mkgridmap.conf",
      },
      voms_uri => "vomss://lxbra2309.cern.ch:8443/voms/dteam?/dteam",
      map      => "nobody";
  }

  # Mapping user to VO for case of proxies with no VOMS info
  grid-common::gridmap::group { 
    "dpm_dteam_cern":
      file     => $grid_flavour ? {
        "glite" => "/opt/lcg/etc/lcgdm-mkgridmap.conf",
        default => "/etc/sysconfig/lcgdm-mkgridmap.conf",
      },
      voms_uri => "vomss://voms.hellasgrid.gr:8443/voms/dteam?/dteam",
      map      => "dteam";
    "dpm_dteam_tbed":
      file     => $grid_flavour ? {
        "glite" => "/opt/lcg/etc/lcgdm-mkgridmap.conf",
        default => "/etc/sysconfig/lcgdm-mkgridmap.conf",
      },
      voms_uri => "vomss://lxbra2309.cern.ch:8443/voms/dteam?/dteam",
      map      => "dteam";
  }
}
