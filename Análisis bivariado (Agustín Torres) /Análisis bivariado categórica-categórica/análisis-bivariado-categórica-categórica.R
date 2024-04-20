# Instalamos el paquete ggplot2 si aún no lo tienes instalado
if (!requireNamespace("ggplot2", quietly = TRUE)) {
  install.packages("ggplot2")
}

# Instalamos el paquete readxl si aún no lo tienes instalado
if (!requireNamespace("readxl", quietly = TRUE)) {
  install.packages("readxl")
}

# Cargamos el paquete ggplot2 y readxl
library(ggplot2)
library(readxl)

# Leemos la tabla desde el archivo XLS
tabla_bivariada_categórica_categórica <- read_excel("tabla-bivariada-categórica-categórica.xls")

# Definimos las variables a analizar
desalojo = tabla_bivariada_categórica_categórica$`¿Atravesó algún intento de desalojo desde que vive en esta vivienda?`
lugar_habitación = tabla_bivariada_categórica_categórica$`El lugar que habitan actualmente es`


# Creamos el gráfico de barras agrupadas
ggplot(
  tabla_bivariada_categórica_categórica, 
  aes(x = desalojo, fill = lugar_habitación)) +  # Definimos las variables para el gráfico
  geom_bar(position = "dodge", stat = "count") +  # Creamos barras agrupadas
  geom_text(stat = "count", aes(label = ..count..),  # Agregamos etiquetas con el recuento de cada grupo
            position = position_dodge(width = 0.9), 
            vjust = -0.5, hjust = 0.5, size = 5) +  # Ajustamos la posición y tamaño de las etiquetas
  labs(title = "Relación entre Intento de Desalojo y Lugar de Habitación
       Constitución - Mendoza",  # Título del gráfico
       x = "Atravesó intento de desalojo",  # Etiqueta del eje x
       y = "Cantidad de personas",  # Etiqueta del eje y
       fill = "Lugar de habitación") +  # Etiqueta de la leyenda
  scale_fill_manual(values = c("#66c2a5", "#fc8d62", "#8da0cb", "#e78ac3", "#a6d854")) +  # Especificar colores para cada nivel de la variable categórica
  ylim(0, 20) + # Establecer el límite del eje y para una mejor visualización
  theme_linedraw() +  # Tema de visualización
  theme(plot.title = element_text(hjust = 0.5)) # Ajuste de la justificación horizontal del título

