# Import Library Dashboard
library(shiny)
library(shinydashboard)

# Import Library Visualization
library(dplyr) # untuk transformasi data
library(plotly) # untuk membuat plot menjadi interaktif
library(glue) # untuk custom informasi saat plot interaktif
library(scales) # untuk custom keterangan axis atau lainnya
library(tidyr) # untuk custom keterangan axis atau lainnya
library(stringr)# untuk melakuan kustom teks pada tooltip
library(ggpubr) # untuk export plot
library(lubridate)

# Import Library Read Table
library(DT) # untuk menampilkan dataset

# Setting Agar tidak muncul numeric value
options(scipen = 9999)

# Import dataset yang sudah clean
youtube <- read.csv("data_input/youtubetrends.csv")
# Data cleansing
youtube$publish_year <- year(youtube$trending_date)
youtube_clean <- youtube %>%  
  mutate(trending_date = as.Date(trending_date),
         category_id = as.factor(category_id),
         title = as.factor(title),
         publish_year = as.factor(publish_year))


# Import Tema Algoritma (Kustomisasi plot)
theme_algoritma <- theme(legend.key = element_rect(fill="black"),
                         legend.background = element_rect(color="white", fill="#263238"),
                         plot.subtitle = element_text(size=6, color="white"),
                         panel.background = element_rect(fill="#dddddd"),
                         panel.border = element_rect(fill=NA),
                         panel.grid.minor.x = element_blank(),
                         panel.grid.major.x = element_blank(),
                         panel.grid.major.y = element_line(color="darkgrey", linetype=2), 
                         panel.grid.minor.y = element_blank(),
                         plot.background = element_rect(fill="#263238"),
                         text = element_text(color="white"),
                         axis.text = element_text(color="white")
)