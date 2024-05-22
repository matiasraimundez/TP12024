# ANALISIS VARIABLE CATEGÓRICA NOMINAL
# De qué forma obtiene el agua dentro de su vivienda?

install.packages("lessR")
install.packages("readxl")
library(lessR)
library(readxl)

path <- "obtencionAgua.xlsx" #pasamos el path de la tabla con datos

data <- read_excel(path, col_names = TRUE) #leemos el path

# filtramos la única columna 
obtencion_agua <- data$`¿De qué forma obtiene el agua dentro de su vivienda?`

#graficamos el gráfico de torta solicitado
PieChart(obtencion_agua,main = "Forma de Obtener Agua en las Viviendas",
         hole = 0, radius = 0.6)


