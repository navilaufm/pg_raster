echo $0
cd "$(dirname "$0")"
echo $(date)

bash down_by_ext.sh https://cc1.meteo.tech/data/icon/ tif pcpn* /root/projects/pg_raster/down PCP
bash down_by_ext.sh https://cc1.meteo.tech/data/icon/ tif temp* /root/projects/pg_raster/down TMP
bash down_by_ext.sh https://cc1.meteo.tech/data/icon/ tif a_pcpn* /root/projects/pg_raster/down ACCP
bash down_by_ext.sh https://cc1.meteo.tech/data/icon/ tif wspd* /root/projects/pg_raster/down WSPD
bash down_by_ext.sh https://cc1.meteo.tech/data/icon/ tif max_temp* /root/projects/pg_raster/down TMAX
bash down_by_ext.sh https://cc1.meteo.tech/data/icon/ tif min_temp* /root/projects/pg_raster/down TMIN

