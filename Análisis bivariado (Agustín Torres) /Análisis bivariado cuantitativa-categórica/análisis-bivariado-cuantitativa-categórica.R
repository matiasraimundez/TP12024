# Cargar el paquete ggplot2 si aún no lo tienes instalado
if (!requireNamespace("ggplot2", quietly = TRUE)) {
  install.packages("ggplot2")
}

# Cargar el paquete readxl si aún no lo tienes instalado
if (!requireNamespace("readxl", quietly = TRUE)) {
  install.packages("readxl")
}

# Cargar el paquete ggplot2
library(ggplot2)
library(readxl)

# Leer los datos desde el archivo XLS
tabla_bivariada_cuantitativa_categorica <- read_excel("tabla-bivariada-cuantitativa-categorica.xls")

# Definimos las variables a analizar
Tipos_de_conexion_a_Internet = tabla_bivariada_cuantitativa_categorica$`Tipo de conexión a Internet`
Numero_de_dispositivos_moviles_tabletas = tabla_bivariada_cuantitativa_categorica$`Número de dispositivos móviles/tabletas`

# Graficar un boxplot comparativo
ggplot(
  tabla_bivariada_cuantitativa_categorica, # Tabla de contingencia a analizar
  aes(x = Tipos_de_conexion_a_Internet, y = Numero_de_dispositivos_moviles_tabletas)) + # Variables a relacionar
  geom_boxplot() + # Establecemos graficar el boxplot
  labs(title = "Boxplot comparativo entre los tipos de conexión a internet y el número de dispositivos móviles/tabletas 
       Constitución - Mendoza", 
       x = "Tipos de conexión a Internet", y = "Número de dispositivos móviles/tabletas") + # Nombres de los ejes
  ylim(0,5) + # Establece los límites del eje y
  theme_bw() + # Tema de visualización
  theme(plot.title = element_text(hjust = 0.5)) # Ajuste de la justificación horizontal del título

