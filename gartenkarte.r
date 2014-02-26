# Pakete
    library("sp")
    library(rgdal)
    library(maptools)
    library(RColorBrewer)
    library(classInt)
    library(ggplot2)
    library(plyr)
    
# DATENAUFBEREITUNG    
# Laden der Gartenadressen als .csv
    adressen <- read.csv(file="Gartenadressen.csv",head=TRUE,sep=",")

# Datensatzbereinigung
    adressen_sort <- adressen[order(adressen$Titel),] # sortieren für Karte
    adressen_aufb <- subset(adressen_sort, select = c(Titel, ProjektCode, lat, lon)) # Var auswählen
     
     
# Auswahl aller Berliner Adressen nach KOS   
    adressen_lat <- subset(adressen_aufb, lat >= 52.373922)
    adressen_lat2 <- subset(adressen_lat, lat <= 52.675549)
    adressen_lon_berlin <- subset(adressen_lat2, lon <= 13.757400)
    adressen_lon2_berlin <- subset(adressen_lon_berlin, lon >= 13.092728)
         
    write.csv (adressen_lon2_berlin, file = "Gartenadressen_berlin.csv")            # speichern
    adressen_berlin <- read.csv(file="Gartenadressen_berlin.csv",head=TRUE,sep=",")  # berliner adressen laden

# Nummerierung
    adressen_berlin$Nr <- row.names(adressen_berlin)
    write.csv (adressen_berlin, file = "Gartenadressen_berlin.csv")             # speichern


# GEODATEN UND EXPORT
# Umwandeln in Spatial Class     
    sp_point <- cbind(adressen_berlin$lon, adressen_berlin$lat)
    colnames(sp_point) <- c("LONG", "LAT")
     
    proj <- CRS("+proj=longlat +datum=WGS84")
    gaerten_berlin <- SpatialPointsDataFrame(coords=sp_point, data=adressen_berlin, proj4string=proj)
         
# als geoJSON exportieren
    drvJson <- "GeoJSON"
    writeOGR(gaerten_berlin, dsn = "gaerten_berlin_json.geojson", layer = "gaerten_berlin_json", driver = drvJson)
