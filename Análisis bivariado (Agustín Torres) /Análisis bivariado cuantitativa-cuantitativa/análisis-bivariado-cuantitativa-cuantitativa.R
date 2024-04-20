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
tabla_bivariada_cuantitativa_cuantitativa <- read_excel("tabla-bivariada-cuantitativa-cuantitativa.xls")

# Definimos las variables a analizar
ambientes_dormitorios = tabla_bivariada_cuantitativa_cuantitativa$`¿Cuántos ambientes en su vivienda se utilizan como dormitorio?`
personas = tabla_bivariada_cuantitativa_cuantitativa$`¿Cuántos personas duermen como mucho en cada dormitorio?`

# Crear el diagrama de dispersión
ggplot(
  tabla_bivariada_cuantitativa_cuantitativa, 
  aes(x = ambientes_dormitorios, y = personas)) +  # Definir las variables en los ejes x e y
  geom_point() +  # Agregar puntos para el diagrama de dispersión
  theme_linedraw() + # Tema de visalización
  labs(title = "Relación entre la cantidad de personas que duermen como máximo en cada dormitorio y 
  la cantidad de ambientes que se utilizan como dormitorio
       Corrientes - Mendoza",  # Título del gráfico
       x = "Cantidad de ambientes que se utilizan como dormitorio",  # Etiqueta del eje x
       y = "Cantidad de personas que duermen como máximo en cada dormitorio") + # Etiqueta del eje y
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_y_continuous(breaks = seq(0, 8, by = 1)) # Establecer el límite del eje y para una mejor visualización
