# ANALISIS CATEGÓRICA ORDINAL
# Cómo es la presión del agua en el hogar?

install.packages("readxl")
library(readxl)

path <- "presionAgua.xlsx"
datos <- read_excel(path,col_names = TRUE)

tipo_presion <- datos$`¿Cómo es la presión del agua?`

# gráfico de barras, miden la frecuencia de cada categoría

barplot(prop.table(table(tipo_presion)),main = "Gráfico de Barras - Presión del Agua"
        , xlab = "Tipo de Presión", ylab = "Frecuencia", col = rgb(0,0,1,1))




