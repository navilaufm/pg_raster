echo $0
cd "$(dirname "$0")"
echo $(date)qq

##wrf 
##sugerencia quitar para pg rasters data sin _
bash down_by_ext.sh https://m.meteo.tech/w/ tif AFWA_CLOUD* /root/projects/pg_raster/down CLOUD
bash down_by_ext.sh https://m.meteo.tech/w/ tif AFWA_PWAT* /root/projects/pg_raster/down PWAT
bash down_by_ext.sh https://m.meteo.tech/w/ tif AFWA_TOTPRECIP* /root/projects/pg_raster/down TOTPRECIP
bash down_by_ext.sh https://m.meteo.tech/w/ tif CLDFRA* /root/projects/pg_raster/down CLDFRA
bash down_by_ext.sh https://m.meteo.tech/w/ tif REFD_MAX* /root/projects/pg_raster/down REFDMAX
bash down_by_ext.sh https://m.meteo.tech/w/ tif T2* /root/projects/pg_raster/down T2
bash down_by_ext.sh https://m.meteo.tech/w/ tif TSK* /root/projects/pg_raster/down TSK
bash down_by_ext.sh https://m.meteo.tech/w/ tif WDIR10* /root/projects/pg_raster/down WDIR10
bash down_by_ext.sh https://m.meteo.tech/w/ tif WSPD10* /root/projects/pg_raster/down WSPD10
bash down_by_ext.sh https://m.meteo.tech/w/ tif WSPD10MAX* /root/projects/pg_raster/down WSPD10MAX
##agregados para visibilidad y fog
bash down_by_ext.sh https://m.meteo.tech/w/ tif VIS* /root/projects/pg_raster/down VIS
bash down_by_ext.sh https://m.meteo.tech/w/ tif HR2* /root/projects/pg_raster/down HR2
## lluvias 241227
bash down_by_ext.sh https://m.meteo.tech/w/ tif RAINC* /root/projects/pg_raster/down RAINC
bash down_by_ext.sh https://m.meteo.tech/w/ tif RAINNC* /root/projects/pg_raster/down RAINNC
bash down_by_ext.sh https://m.meteo.tech/w/ tif RAINP* /root/projects/pg_raster/down RAINP
bash down_by_ext.sh https://m.meteo.tech/w/ tif RAINTOT* /root/projects/pg_raster/down RAINTOT
