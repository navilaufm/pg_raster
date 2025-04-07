echo $0
cd "$(dirname "$0")"
echo $(date)qq

##wrf cybergeek

bash down_by_ext.sh https://storage.googleapis.com/meteotech/data/wrf/ tif RAINC* /root/projects/pg_raster/down RAINC
bash down_by_ext.sh https://storage.googleapis.com/meteotech/data/wrf/ tif RAINNC* /root/projects/pg_raster/down RAINNC
bash down_by_ext.sh https://storage.googleapis.com/meteotech/data/wrf/ tif RAINP* /root/projects/pg_raster/down RAINP
bash down_by_ext.sh https://storage.googleapis.com/meteotech/data/wrf/ tif RAINTOT* /root/projects/pg_raster/down RAINTOT

bash down_by_ext.sh https://storage.googleapis.com/meteotech/data/wrf/ tif T2_* /root/projects/pg_raster/down T2
bash down_by_ext.sh https://storage.googleapis.com/meteotech/data/wrf/ tif T2MIN* /root/projects/pg_raster/down T2MIN
bash down_by_ext.sh https://storage.googleapis.com/meteotech/data/wrf/ tif T2MAX* /root/projects/pg_raster/down T2MAX
bash down_by_ext.sh https://storage.googleapis.com/meteotech/data/wrf/ tif RH2* /root/projects/pg_raster/down RH2
bash down_by_ext.sh https://storage.googleapis.com/meteotech/data/wrf/ tif FG* /root/projects/pg_raster/down FG

bash down_by_ext.sh https://storage.googleapis.com/meteotech/data/wrf/ tif AFWA_CLOUD* /root/projects/pg_raster/down CLOUD
bash down_by_ext.sh https://storage.googleapis.com/meteotech/data/wrf/ tif AFWA_PWAT* /root/projects/pg_raster/down PWAT
bash down_by_ext.sh https://storage.googleapis.com/meteotech/data/wrf/ tif AFWA_CAPE* /root/projects/pg_raster/down CAPE
bash down_by_ext.sh https://storage.googleapis.com/meteotech/data/wrf/ tif AFWA_CIN* /root/projects/pg_raster/down CIN
bash down_by_ext.sh https://storage.googleapis.com/meteotech/data/wrf/ tif AFWA_MSLP* /root/projects/pg_raster/down MSLP


bash down_by_ext.sh https://storage.googleapis.com/meteotech/data/wrf/ tif REFD* /root/projects/pg_raster/down REFD
bash down_by_ext.sh https://storage.googleapis.com/meteotech/data/wrf/ tif REFD_COM* /root/projects/pg_raster/down REFDCOM

bash down_by_ext.sh https://storage.googleapis.com/meteotech/data/wrf/ tif WDIR10* /root/projects/pg_raster/down WDIR10
bash down_by_ext.sh https://storage.googleapis.com/meteotech/data/wrf/ tif WSPD10* /root/projects/pg_raster/down WSPD10
bash down_by_ext.sh https://storage.googleapis.com/meteotech/data/wrf/ tif WSPD10MAX* /root/projects/pg_raster/down WSPD10MAX


