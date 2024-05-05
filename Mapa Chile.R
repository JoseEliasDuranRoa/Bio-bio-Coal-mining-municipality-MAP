## Mapa de la Región de Biobío##

# Si no tienen los paquetes hay que instalarlos
# install.packages("sf")
# install.packages("ggthemes")

library(tidyverse)
library(sf)
library(ggthemes)
library(readxl)
library(dplyr)

#Aquí tienen que poner el directorio específido a su pavada
# Se descarga de esta página: https://www.ine.gob.cl/herramientas/portal-de-mapas/geodatos-abiertos
# Una vez ahí ir a Cartografía > Censo 2017 > División Político Administrativa Y Censal > SHP
# Descargar el archivo zip que se llama: Censo 2017... Comuna
ruta_shapefile <- "C:/Users/Administrador/Downloads/comunas_2017/Comuna_Densid_Superficie.shp"

# Lee el archivo shapefile
datos_sf <- st_read(dsn = ruta_shapefile)
str(datos_sf)

#Mapa de Chilito
ggplot(datos_sf)+geom_sf()

#Región de Bío- Bío
capa_biobio<-filter(datos_sf, REGION== "8"  )
ggplot(capa_biobio)+geom_sf()

#Realmente pueden filtrar la región que quieran (mirar el diccionario para ver el número de a región)

ggplot(capa_biobio)+geom_sf(aes(fill=Densidad_) )+  
  geom_sf_text(data = capa_biobio, aes(label = NOM_COMUNA ), size=1.2)

#Pego mi variable 
ruta_excel <- "C:/Users/Administrador/Downloads/comunas_2017/COMUNAS.xlsx"
datos_excel <- read_excel(ruta_excel)
datos_excel$COMUNA <- as.character(datos_excel$COMUNA)
capa_biobio$COMUNA <- as.character(capa_biobio$COMUNA)
capa_biobio_completa <- left_join(capa_biobio, datos_excel, by = "COMUNA")
capa_biobio_completa$COMUNA <- as.numeric(capa_biobio_completa$COMUNA)

#Grafico minería de Carbón en 1940-1950

ggplot(capa_biobio_completa)+geom_sf(aes(fill=Carbón) )+  
  geom_sf_text(data = capa_biobio_completa, aes(label = NOM_COMUNA ), size=1.2)

ggplot(capa_biobio_completa)+geom_sf(aes(fill=Grisu) )+  
  geom_sf_text(data = capa_biobio_completa, aes(label = NOM_COMUNA ), size=1.2)
