library(readxl)

tabla_datos <- read_excel("Barrio_Constitución.xlsx")

habitantes <- tabla_datos$`¿Cuántos integrantes hay en su vivienda?`

plot(table(habitantes), main="Número de habitantes por vivienda", xlab="Número de habitantes", ylab="Cantidad de viviendas", ylim=c(0,20))

habitaciones <- tabla_datos$`¿Cuántos ambientes en su vivienda se utilizan como dormitorio?`

plot(table(habitaciones), main="Número de habitaciones por vivienda", xlab="Número de habitaciones", ylab="Cantidad de viviendas", ylim=c(0,35))

habmax <- tabla_datos$`¿Cuál es el número MÁXIMO de personas que duermen en estos dormitorios usualmente?`

plot(table(habmax), main="Número de personas como máximo\nque duermen en la misma habitación", xlab="Número de personas", ylab="Cantidad de viviendas", ylim=c(0,25))
