class dpm::atlas {
  include voms::atlas
  include dpm::lcgdmmap

  # grid-mapfile mapping to local account (we use nobody, no pool accounts needed)
  grid-common::gridmap::group { "voms_atlas_cern":
    file     => $grid_flavour ? {
      "glite" => "/opt/edg/etc/edg-mkgridmap.conf",
      default => "/etc/edg-mkgridmap.conf",
    },
    voms_uri => "vomss://voms.cern.ch:8443/voms/atlas?/atlas",
    map      => "nobody",
  }

  # Mapping user to VO for case of proxies with no VOMS info
  grid-common::gridmap::group { "dpm_atlas_cern":
    file     => $grid_flavour ? {
      "glite" => "/opt/lcg/etc/lcgdm-mkgridmap.conf",
      default => "/etc/sysconfig/lcgdm-mkgridmap.conf",
    },
    voms_uri => "vomss://voms.cern.ch:8443/voms/atlas?/atlas",
    map      => "atlas",
  }
}
