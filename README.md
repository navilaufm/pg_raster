# pg_raster
Process to upload rasters to postgres for a postgis based point api

Debe existir una base de datos:
create database rasters;
create user rasters with password 'rastersUniversal$%1'; 
grant all privileges on database rasters to rasters;
\c rasters;
create extension postgis;
create extension postgis_raster;

