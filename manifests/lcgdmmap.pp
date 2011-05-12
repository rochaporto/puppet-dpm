class dpm::lcgdmmap {
  grid-common::gridmap::mkgridmap { "lcgdm-mkgridmap":
    conffile => $grid_flavour ? {
      "glite" => "/opt/lcg/etc/lcgdm-mkgridmap.conf",
      default => "/etc/lcgdm-mkgridmap.conf",
    },
    mapfile  => $grid_flavour ? {
      "glite" => "/opt/lcg/etc/lcgdm-mapfile",
      default => "/etc/lcgdm-mapfile",
    },
    logfile  => "/var/log/lcgdm-mkgridmap.log",
  }
}
