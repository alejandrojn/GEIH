library(readxl)
library(tidyverse)
library(ggplot2)
file.choose()
###Importar datos de la hoja ocupado del archivo Ejemplo4###
OC <- read_xls("C:\\Users\\USER\\OneDrive\\Desktop\\DiplomadoStata\\Ejemplo4\\DatosEjemplo4.xls")

###Colocar etiqueta a la variable TipoContrato###
OC$TipoContrato<-factor(OC$TipoContrato, levels = c("1", "2"), 
                             labels=c("verbal", "escrito"))

###Revisando la estrcutura de la dataframe Ejemplo##
class(OC$Ident)
str(OC)
##Guardar datos como archivo de R###
save(OC, file = "Ocupados.rda")


###############################################################################
##############################################################################

###Importar datos de la hoja desocupados del archivo Ejemplo$$$
DO <-  read_excel("C:/Users/USER/OneDrive/Desktop/DiplomadoStata/Ejemplo4/DatosEjemplo4.xls", 
                           sheet = "Desocupados")


###Colocar etiqueta a la variable Subsidio###
DO$SubsdioDesem <-factor(DO$SubsdioDesem, levels = c("1", "2"), 
                             labels=c("Sí", "No"))


save(DO, file = "Desocupados.rda")
################################################################################
#################################################################################
######Importar datos de la hoja inactivos del archivo Ejemplo#################

IN <- read_excel("C:/Users/USER/OneDrive/Desktop/DiplomadoStata/Ejemplo4/DatosEjemplo4.xls", 
                           sheet = "Inactivos")

#######Colocando etiqueta a la variable CotizaPen#############

IN$CotizaPen<-factor(IN$CotizaPen, levels = c("1", "2"),
                            labels = c("Si", "No"))

save(IN, file = "Inactivos.rda")

###############################################################################
##############################################################################

####Importar datos de la hoja de Caraceristicas Generales del archivo Ejemplo##
CG <- read_excel("C:/Users/USER/OneDrive/Desktop/DiplomadoStata/Ejemplo4/DatosEjemplo4.xls", 
                       sheet = "CGen")


save(CG, file = "CaracGene.rda")

##############################################################################
            ##############Fusión Vertical############
###############################################################################
###Creación de archivo que contiene los casos de ocupados, desocupados e inactivos###
names(OC)
names(DO)
names(IN)
Empleo = bind_rows(OC, DO, IN)
#############################################################################
              #############Fusión Horizontal###########       
#################################################################################
EmpCG = merge(Empleo, CG)
view(EmpCG)
str(EmpCG)
EmpCG<-EmpCG %>% mutate(Sexo=as.character(Sexo))
str(EmpCG$Sexo)
EmpCG$Sexo<-factor(EmpCG$Sexo, levels = c("1", "2"),
                    labels=c("Hombre", "Mujer"))

################################################################################
          ######################Tablas################
##############################################################################
summary(EmpCG)
table(Sexo=EmpCG$Sexo)
Tabla<-table(EmpCG$Sexo)
view(Tabla)
Tabla<-as.data.frame(Tabla)
Tabla$Rel<-(round(prop.table(Tabla$Freq),2)*100)
################################################################################
#Muestra la tabla de frecuencias relativas y acumuladas redondeadas a 3 decimales
################################################################################
Tab3<-transform(Tabla, FreqAc=cumsum(Freq), Rel=round(prop.table(Freq),2)*100,
                  RelAc=round(cumsum(prop.table(Freq)),2))
view(Tab3)
################################################################################
                            #Tabla edad y sexo
###############################################################################
Tab2<-as.data.frame(table(Sexo=EmpCG$Sexo, Salario=EmpCG$Ingresos))
transform(Tab2, FreqAc=cumsum(Freq), Rel=round(prop.table(Freq),2),
          RelAc=round(cumsum(prop.table(Freq)),2))
##################################################################################
                  ############Gráfico############################
##############################################################################
Grafico<-ggplot(Tab3, aes(x="", y=Rel, fill=Sexo)) +
  geom_bar(stat="identity", width=1) +
  coord_polar("y", start=0)
plot(Grafico)
###############################################################################
                       #Mejorando la presentación#
#############################################################################
Grafico<-ggplot(Tab3, aes(x="", y=Rel, fill=Sexo)) +
  geom_bar(stat="identity", width=1, color="white") +
  coord_polar("y", start=0) +
  theme_void()#remueve el fondo, la grilla, las etiquetas de numero

plot(Grafico)
################################################################################
                       #Añadiendo etiquetas
##############################################################################
Grafico<-ggplot(Tab3, aes(x="", y=Rel, fill=Sexo)) +
  geom_bar(stat="identity", width=1, color="white") +
  coord_polar("y", start=0) +  
  theme_void() + # remove background, grid, numeric labels
  geom_text(aes(label=Rel),
  position=position_stack(vjust=0.5), 
  color ="black", size=8)
plot(Grafico)
#################################################################################
                         #Agregando el título
############################################################################
Grafico<-ggplot(Tab3, aes(x="", y=Rel, fill=Sexo)) +
  geom_bar(stat="identity", width=1, color="white") +
  coord_polar("y", start=0) +  
  theme_void() + # remove background, grid, numeric labels
  geom_text(aes(label=Rel),
            position=position_stack(vjust=0.5), 
            color ="black", size=8)+
  ggtitle("Frecuencia Total de la Población por Genero")+
  theme (plot.title = element_text(family="Comic Sans MS",
  size=rel(1.5), #Tamaño relativo de la letra del título
  vjust=2, #Justificación vertical, para separarlo del gráfico
  face="bold", #Letra negrilla. Otras posibilidades "plain", "italic", "bold" y "bold.italic"
  color="black", #Color del texto
  lineheight=1.5))
  
   
plot(Grafico)








