echo $0
cd "$(dirname "$0")"
echo $(date)

##wrf 
##sugerencia quitar para pg rasters data sin _
bash down_by_ext_op.sh /home/wrf/geotiff/ tif AFWA_CAPE* /home/wrf/pg_raster/down CAPE
bash down_by_ext_op.sh /home/wrf/geotiff/ tif AFWA_CIN* /home/wrf/pg_raster/down CIN
bash down_by_ext_op.sh /home/wrf/geotiff/ tif AFWA_PWAT* /home/wrf/pg_raster/down PWAT
bash down_by_ext_op.sh /home/wrf/geotiff/ tif AFWA_CLOUD* /home/wrf/pg_raster/down CLOUD
bash down_by_ext_op.sh /home/wrf/geotiff/ tif AFWA_LLWS* /home/wrf/pg_raster/down LLWS
bash down_by_ext_op.sh /home/wrf/geotiff/ tif AFWA_MSLP* /home/wrf/pg_raster/down MSLP
bash down_by_ext_op.sh /home/wrf/geotiff/ tif AFWA_TOTPRECIP* /home/wrf/pg_raster/down TOTPRECIP

bash down_by_ext_op.sh /home/wrf/geotiff/ tif CLDFRA* /home/wrf/pg_raster/down CLDFRA
bash down_by_ext_op.sh /home/wrf/geotiff/ tif FG* /home/wrf/pg_raster/down FG
bash down_by_ext_op.sh /home/wrf/geotiff/ tif PSFC* /home/wrf/pg_raster/down PSFC

bash down_by_ext_op.sh /home/wrf/geotiff/ tif REFD* /home/wrf/pg_raster/down REFD
bash down_by_ext_op.sh /home/wrf/geotiff/ tif REFD_COM* /home/wrf/pg_raster/down REFD_COM

##incluye T2MAX T2MIN
bash down_by_ext_op.sh /home/wrf/geotiff/ tif T2* /home/wrf/pg_raster/down T2
bash down_by_ext_op.sh /home/wrf/geotiff/ tif TSK* /home/wrf/pg_raster/down TSK


bash down_by_ext_op.sh /home/wrf/geotiff/ tif U10* /home/wrf/pg_raster/down U10
bash down_by_ext_op.sh /home/wrf/geotiff/ tif V10* /home/wrf/pg_raster/down V10

bash down_by_ext_op.sh /home/wrf/geotiff/ tif WDIR10* /home/wrf/pg_raster/down WDIR10
bash down_by_ext_op.sh /home/wrf/geotiff/ tif WSPD10* /home/wrf/pg_raster/down WSPD10
bash down_by_ext_op.sh /home/wrf/geotiff/ tif WSPD10MAX* /home/wrf/pg_raster/down WSPD10MAX

bash down_by_ext_op.sh /home/wrf/geotiff/ tif Q2* /home/wrf/pg_raster/down VIS
bash down_by_ext_op.sh /home/wrf/geotiff/ tif RH2* /home/wrf/pg_raster/down RH2

bash down_by_ext_op.sh /home/wrf/geotiff/ tif RAINC* /home/wrf/pg_raster/down RAINC
bash down_by_ext_op.sh /home/wrf/geotiff/ tif RAINNC* /home/wrf/pg_raster/down RAINNC
bash down_by_ext_op.sh /home/wrf/geotiff/ tif RAINP* /home/wrf/pg_raster/down RAINP
bash down_by_ext_op.sh /home/wrf/geotiff/ tif RAINTOT* /home/wrf/pg_raster/down RAINTOT
