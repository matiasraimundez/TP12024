library(readxl)
library(tidyverse)
library(ggplot2)

tabla_datos <- read_excel("Barrio_Constitución.xlsx")

colnames(tabla_datos) <- c("frecuencia","PROVINCIA","BARRIO","tiempo","habitantes","habitaciones","habmax","desalojo","propiedad","conexion","presion","almac1","almac2","dormitorios","cocina","baño","living","ninguno","NADA")

attach(tabla_datos)

ggplot(tabla_datos, aes(habitantes))+
  geom_bar(width=0.05)+
  scale_x_continuous(n.breaks=10)+
  scale_y_continuous(n.breaks=10)+
  labs(title="Número de habitantes por vivienda",x="Número de habitantes",y="Cantidad de viviendas")+
  theme_light()

ggplot(tabla_datos, aes(habitaciones))+
  geom_bar(width=0.03)+
  scale_x_continuous(n.breaks=4)+
  scale_y_continuous(n.breaks=10)+
  labs(title="Número de habitaciones por vivienda",x="Número de habitaciones",y="Cantidad de viviendas")+
  theme_light()

ggplot(tabla_datos, aes(habmax))+
  geom_bar(width=0.03)+
  scale_x_continuous(n.breaks=7)+
  scale_y_continuous(n.breaks=8)+
  labs(title="Número de personas como máximo\nque duermen en la misma habitación",x="Número de personas",y="Cantidad de viviendas")+
  theme_light()

ggplot(tabla_datos, aes(tiempo))+
  geom_histogram(fill="lightgray",col="black",breaks=seq(0,50,5))+
  labs(title="Tiempo de residencia en la vivienda (en años)",x="Años de residencia",y="Cantidad de viviendas")+
  theme_minimal()

ggplot(tabla_datos, aes(habitantes,habmax))+
  geom_point(size=1.5*sqrt(frecuencia))+
  scale_x_continuous(n.breaks=10)+
  scale_y_continuous(n.breaks=7)+
  geom_smooth(method="lm",se=FALSE)+
  labs(title="Relación entre el número de habitantes y\nde personas que duermen en la misma habitación",x="Número de habitantes",y="Personas misma habitación")+
  theme_light()

ggplot(tabla_datos, aes(forcats::fct_rev(forcats::fct_infreq(propiedad))))+
  geom_bar(width=0.5,fill="brown")+
  coord_flip()+
  scale_y_continuous(n.breaks=6)+
  labs(title="Estado de propiedad de la vivienda",y="Cantidad de viviendas",x="Estado de propiedad")+
  theme_light()

pie(table(desalojo),clockwise=TRUE,col=c("lightgreen","pink"),labels=paste0(desalojo," ",round(table(desalojo)/length(desalojo)*100,2),"%"))
mtext("¿Atravesó algún intento de desalojo?")

propietario <- ifelse((propiedad=="Propio c/ comprobante" | propiedad=="Propio s/ comprobante"),"Propietario","No propietario")

barplot(table(desalojo,propietario),beside=TRUE,col=c("lightgreen","pink"),ylab="Cantidad de viviendas",xlab="Estado de propiedad",legend.text=c("No","Sí"),main="Relación entre el estado de propiedad\ny si atravesó intento de desalojo",args.legend=list(x="topright",inset=c(-0.05,0.1)))

ggplot(tabla_datos, aes(presion))+
  geom_bar(width=0.4,fill="darkblue")+
  coord_flip()+
  labs(title="Nivel de presión del agua por vivienda",y="Cantidad de viviendas",x="Nivel de presión del agua")+
  theme_light()

tabla_datos %>%
  mutate(dormitorios=ifelse(is.na(dormitorios),0,1),cocina=ifelse(is.na(cocina),0,1),baño=ifelse(is.na(baño),0,1),living=ifelse(is.na(living),0,1),ninguno=ifelse(is.na(ninguno),0,1)) %>%
  summarize(Dormitorios=sum(dormitorios),Cocina=sum(cocina),Baño=sum(baño),.Living=sum(living),Ninguno=sum(ninguno)) %>%
  pivot_longer(cols=c(Dormitorios,Cocina,Baño,.Living,Ninguno),names_to="Ambiente",values_to="cant") %>%
  ggplot()+
  aes(x=Ambiente,y=cant/nrow(tabla_datos))+
  geom_bar(width=0.5,fill="darkgreen",stat="identity")+
  scale_y_continuous(limits=c(0,1),n.breaks=6,labels=scales::percent)+
  labs(title="Riesgo de derrumbe en la vivienda según ambientes",y="Porcentaje de viviendas")+
  coord_flip()+
  theme_light()

library(gridExtra)
  
g1 <- tabla_datos %>% filter(ninguno=="Sin riesgo de derrumbe") %>%
  ggplot()+
  aes(tiempo)+
  geom_boxplot(width=0.5,fill="lightblue")+
  scale_x_continuous(limits=c(0,45))+
  scale_y_continuous(limits=c(-1,1),n.breaks=2)+
  labs(title="Sin riesgo de derrumbe",x="Años de residencia")

g2 <- tabla_datos %>% filter(is.na(ninguno)) %>%
  ggplot()+
  aes(tiempo)+
  geom_boxplot(width=0.5,fill="lightblue")+
  scale_x_continuous(limits=c(0,45))+
  scale_y_continuous(limits=c(-1,1),n.breaks=2)+
  labs(title="Hay riesgo de derrumbe",x="Años de residencia")

grid.arrange(g1,g2,ncol=1,nrow=2)

pie(table(conexion),clockwise=TRUE,col=c("darkblue","blue","lightblue"),main="¿De qué forma obtiene el agua\ndentro de su vivienda?",labels=paste0(c("Conexión con medidor","Conexión sin medidor","Sin conexión"),"\n",round(table(conexion)/length(conexion)*100,2),"%"))

tabla_datos %>% summarize(Mínimo=min(habitantes),Q1=quantile(habitantes,0.25),Mediana=median(habitantes),Q3=quantile(habitantes,0.75),Máximo=max(habitantes),RI=IQR(habitantes))
tabla_datos %>% summarize(Mínimo=min(habmax),Q1=quantile(habmax,0.25),Mediana=median(habmax),Q3=quantile(habmax,0.75),Máximo=max(habmax),RI=IQR(habmax))
tabla_datos %>% summarize(Mínimo=min(tiempo),Q1=quantile(tiempo,0.25),Mediana=median(tiempo),Q3=quantile(tiempo,0.75),Máximo=max(tiempo),RI=IQR(tiempo))
