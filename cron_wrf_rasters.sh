echo $0
cd "$(dirname "$0")"
echo $(date)qq

##wrf
bash down_by_ext.sh https://m.meteo.tech/w/ tif AFWA_CLOUD* /root/projects/pg_raster/down CLOUD
bash down_by_ext.sh https://m.meteo.tech/w/ tif AFWA_PWAT* /root/projects/pg_raster/down PWAT
bash down_by_ext.sh https://m.meteo.tech/w/ tif AFWA_TOTPRECIP* /root/projects/pg_raster/down TOTPRECIP
bash down_by_ext.sh https://m.meteo.tech/w/ tif CLDFRA* /root/projects/pg_raster/down CLDFRA
bash down_by_ext.sh https://m.meteo.tech/w/ tif REFD_MAX* /root/projects/pg_raster/down REFD_MAX
bash down_by_ext.sh https://m.meteo.tech/w/ tif T2* /root/projects/pg_raster/down T2
bash down_by_ext.sh https://m.meteo.tech/w/ tif TSK* /root/projects/pg_raster/down TSK
bash down_by_ext.sh https://m.meteo.tech/w/ tif WDIR10* /root/projects/pg_raster/down WDIR10
bash down_by_ext.sh https://m.meteo.tech/w/ tif WSPD10* /root/projects/pg_raster/down WSPD10
bash down_by_ext.sh https://m.meteo.tech/w/ tif WSPD10MAX* /root/projects/pg_raster/down WSPD10MAX