library(tidyverse)
require("httr")
require("jsonlite")
require("anytime")
require("plotly")
library(plotly)
library(htmlwidgets)

civ_list <- data.frame (civ = c("1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42"),
                        civ_name = c("British","Franks","Goths","Teutons","Japanese","Chinese","Byzantine","Persians","Saracens","Turks","Vikings","Mongols","Celts","Spanish","Aztecs","Mayans","Huns","Koreans","Italians","Hindustanis","Incas","Magyars","Slavs","Portuguese","Ethiopians","Malians","Berbers","Khmer","Malay","Burmese","Vietnamese","Bulgarians","Tatars","Cumans","Lithuanians","Burgundians","Sicilians","Poles","Bohemians","Dravidians","Bengalis","Gurjaras")
)


alan <- paste("https://aoe2.net/api/player/matches?game=aoe2de&steam_id=76561199207580572&count=10")
alanhr <- GET(alan)
alanhr_text <- content(alanhr, "text")
alanhr_json <- fromJSON(alanhr_text, flatten = TRUE)
alandf <- as.data.frame(alanhr_json)
alandf <-cbind(alandf, player='alanthekat')
coso <- alandf$players
cosonuevo <- bind_rows(coso, .id = "column_label")
cosonuevoalan <- cosonuevo %>% filter(name == "Carpincho")
civsalan <- merge(cosonuevoalan,civ_list,by="civ" ,all = FALSE)
cosonuevodico <- cosonuevo %>% filter(name == "dicopatito")
civsdico <- merge(cosonuevodico,civ_list,by="civ" ,all = FALSE)
cosonuevonano <- cosonuevo %>% filter(name == "Nanox")
civsnano <- merge(cosonuevonano,civ_list,by="civ" ,all = FALSE)

fig <- plot_ly(civsalan, labels = ~civ_name, type = 'pie',
        textposition = 'inside',
        textinfo = 'label+percent',
        insidetextfont = list(color = '#FFFFFF'),
                              showlegend = FALSE)
fig <- fig %>% layout(xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
         yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
saveWidget(fig, "civs_alan.html", selfcontained = F, libdir = "lib")



fig <- plot_ly(civsnano, labels = ~civ_name, type = 'pie',
        textposition = 'inside',
        textinfo = 'label+percent',
        insidetextfont = list(color = '#FFFFFF'),
   showlegend = FALSE)
fig <- fig %>% layout(xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
                      yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))

saveWidget(fig, "civs_nano.html", selfcontained = F, libdir = "lib")


fig <- plot_ly(civsdico, labels = ~civ_name, type = 'pie',
        textposition = 'inside',
        textinfo = 'label+percent',
        insidetextfont = list(color = '#FFFFFF'),
        showlegend = FALSE)
fig <- fig %>% layout(xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
                      yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))

saveWidget(fig, "civs_dico.html", selfcontained = F, libdir = "lib")
