#install.packages("Tidyverse")
library(tidyverse)
library(survey)
library(lubridate)
library(ggplot2)
file.choose()
###########################################################################################
#Cargando los datos de Caracter?sticas Generales de diciembre a la plataforma de rstudio#
############################################################################################

ACaraGenDic <- read.csv("C:\\Users\\USER\\OneDrive\\Desktop\\Diciembre.csv\\Área - Características generales (Personas).csv")
##Noviembre##
ACaracGenNov <- read.csv("C:\\Users\\USER\\OneDrive\\Desktop\\Noviembre.csv\\Área - Características generales (Personas).csv")
##Octubre##
ACaracGenOct <- read.csv("C:\\Users\\USER\\OneDrive\\Desktop\\Octubre.csv\\Área - Características generales (Personas).csv")

############################################################################################
                #Fusi?n vertical caracter?sticas generales dic, nov, oct##
###########################################################################################

ACaracGenFus = bind_rows(ACaraGenDic, ACaracGenNov, ACaracGenOct)
ACaracGenFus2 <-unite(ACaracGenFus, LLAVE, c(1:3),  sep = ".", remove = TRUE)


###########################################################################################
                            #Cargando los datos de ocupados diciembre#
###########################################################################################

AOcuDic <- read.csv("C:\\Users\\USER\\OneDrive\\Desktop\\Diciembre.csv\\Área - Ocupados.csv")
#############################################################################################
                #Tranformando una variable numerica en un caracter
###########################################################################################
AOcuDic<-AOcuDic %>% mutate(RAMA4DP8=as.character(RAMA4DP8))

##Noviembre
AOcuNov <- read.csv("C:\\Users\\USER\\OneDrive\\Desktop\\Noviembre.csv\\Área - Ocupados.csv")
AOcuNov<-AOcuNov %>% mutate(RAMA4DP8=as.character(RAMA4DP8))
##Octubre
AOcuOct <- read.csv("C:\\Users\\USER\\OneDrive\\Desktop\\Octubre.csv\\Área - Ocupados.csv")
AOcuOct<-AOcuOct %>% mutate(RAMA4DP8=as.character(RAMA4DP8))

#############################################################################################
                        #Fusi?n vertical ocupados dic, nov, oct
############################################################################################
AOcupFus = bind_rows(AOcuDic, AOcuNov, AOcuOct)
AOcupFus2 <-unite(AOcupFus, LLAVE, c(1:3),  sep = ".", remove = TRUE)

###########################################################################################
                      #Cargando los datos de desocupados diciembre#
###########################################################################################

ADesocupDic <- read.csv("C:\\Users\\USER\\OneDrive\\Desktop\\Diciembre.csv\\Área - Desocupados.csv")
#Noviembre
ADesocupNov <- read.csv("C:\\Users\\USER\\OneDrive\\Desktop\\Noviembre.csv\\Área - Desocupados.csv")
#Octubre
ADesocupOct <- read.csv("C:\\Users\\USER\\OneDrive\\Desktop\\Octubre.csv\\Área - Desocupados.csv")

##########################################################################################
                           #Fusi?n vertical desocupados dic, nov, oct
##########################################################################################
ADesoFus = bind_rows(ADesocupDic, ADesocupNov, ADesocupOct)
ADesoFus2 <-unite(ADesoFus, LLAVE, c(1:3),  sep = ".", remove = TRUE)

##########################################################################################
                        #Cargando los datos de inactivos diciembre
############################################################################################
AInaDic <- read.csv("C:\\Users\\USER\\OneDrive\\Desktop\\Diciembre.csv\\Área - Inactivos.csv")
#Noviembre
AInaNov <- read.csv("C:\\Users\\USER\\OneDrive\\Desktop\\Noviembre.csv\\Área - Inactivos.csv")
#Octubre
AInaOct <- read.csv("C:\\Users\\USER\\OneDrive\\Desktop\\Octubre.csv\\Área - Inactivos.csv")

########################################################################################
                          #Fusi?n vertical inactivos dic, nov, oct##
#########################################################################################

AinaFus = bind_rows(AInaDic, AInaNov, AInaOct)
AinaFus2 <-unite(AinaFus, LLAVE, c(1:3),  sep = ".", remove = TRUE)

###########################################################################################
  #Fusi?n vertical dataframe referentes al mercado laboral AocuFus, ADesoFus, AinaFus)
##########################################################################################

Empleo = bind_rows(AOcupFus2, ADesoFus2, AinaFus2)


###########################################################################################
                #Fusi?n Horizontal dataframe Empleo y Caracter?sticas Generales
##########################################################################################
#EmpCaraGen = merge (Empleo, by.x = "LLAVE", 
#                    ACaracGenFus2, by.y = "LLAVE", all = TRUE)

ECG<- full_join(ACaracGenFus2, Empleo, by="LLAVE", 
                all = TRUE)%>%select(LLAVE, HOGAR.x, REGIS.x, AREA.x, REGIS.y, 
                fex_c_2011.x, P6020, P6050, P6040)%>%print()

ECG$fex2 <-round(ECG$fex_c_2011.x/3,4)
str(ECG$fex2)
ECG$P6040

########################################################################################
#Asignando las etiquetas a las areas seg?n el c?digo de la encuesta#
#######################################################################################
ECG$AREAR <-factor(ECG$AREA.x, levels = c("5", "8", "11",
                                 "13", "17", "23", "50", "52", "54", "66", "68", "73", "76"),
                                 labels = c("Medellin", "Barranquilla", "Bogota",
                              "Cartagena", "Manizales", "Monteria", "Villavicencio",
                              "Pasto", "Cucuta", "Pereira", "Bucaramanga", "Ibague", "Cali"))

ECG$P6050 <-factor(ECG$P6050, levels = c("1", "2", "3",
                                          "4", "5", "6", "7", "8", "9"),
                   labels = c("Jefe hogar", "Pareja", "Hijo",
                              "Nieto", "Otro pariente", "Empleado servicio", "Pensionado",
                              "Trabajador", "No pariente"))

ECG$SEXO <-factor(ECG$P6020, levels = c("1", "2"), labels = c("Hombre", "Mujer"))
ECG<-ECG%>% mutate(P6020=as.factor(P6020))
########################################################################################
#Categorizando por grupo de edades la variable P6040
######################################################################################
ECG$EDAD[ECG$P6040>=0 & ECG$P6040>=11]=1
ECG$EDAD[ECG$P6040>=12 & ECG$P6040<=29]=2
ECG$EDAD[ECG$P6040>=30 & ECG$P6040<=65]=3
ECG$EDAD[ECG$P6040>=66 & ECG$P6040<=110]=4
ECG$EDAD<-factor(ECG$EDAD, levels = c("1", "2", "3", "4"), 
                 labels = c("Niños", "Joven", "Adulto", "Adulto Mayor"))

str(ECG$P6020)
class(ECG$EDAD)
#############################Utilizaci?n del coeficiente de expansi?n#########################
###################Crear un objeto con la base de datos ponderada#############################
PobGen<-svydesign(ids=~1,data=ECG,weights=ECG$fex2)
###La funci?n class sobre el objeto que almacena la base de datos ponderada PobGen es para que
###el software la reconozca como un objeto del tipo survey.design#####################
class(PobGen)

###############################################################################################
         #An?lisis descriptivo a partir del factor de ponderaci?n#
#######################################################################################
              #Totales seg?n g?nero y por ?rea metropolitana
###################################################################################
Tab<-as.data.frame(svytable(~EDAD, PobGen))
sum(Tab$Freq)
prop.table(svytotal(~SEXO, PobGen))
Tab1<-as.data.frame(round(prop.table(svytable(~SEXO, PobGen)),3)*100)
str(Tab1)
sum(Tab1$Freq)

###################################################################################
          #Frecuencia porcentual por g?nero y por ?rea metropol?tana
####################################################################################
Tab2<-data.frame(round(prop.table(svytable(~SEXO+AREAR,design=PobGen)),3)*100)
str(Tab2)
sum(Tab2$Freq)
###################################################################################
      #Tabla de frecuencia por g?nero, ?rea metropolitana y seg?n registro
##################################################################################
Tab3<-data.frame(svytable(~SEXO+AREAR+REGIS.y+EDAD,design=PobGen))

########################################################################################
#Indicadores mercado laboral
#######################################################################################
Tab4<-data.frame(svytable(~EDAD+AREAR, design=PobGen))
#######################################################################################
        #Indicadores agregados del mercado laboral Colombia
########################################################################################
Ocu<-Tab3%>%filter(Tab3$REGIS.y%in%c("60"))
O<-sum(Ocu$Freq)
Deso<-Tab3%>%filter(Tab3$REGIS.y%in%c("70"))
D<-sum(Deso$Freq)
Ina<-Tab3%>%filter(Tab3$REGIS.y%in%c("80"))
I<-sum(Ina$Freq)
PT<-sum(Tab4$Freq)
PET<-sum(Tab3$Freq)
PEA<-sum(Ocu$Freq+Deso$Freq)
PartPET<-round((PET/PT),3)*100
TGP<-round((PEA/PET),3)*100
TO<-round((O/PET),3)*100
TD<-round((D/PEA),3)*100
Agregados<-c(PartPET, TGP, TO, TD)
###########################################################################################
#Matriz de indicadores
#######################################################################################
x=matrix(c(PartPET, TGP, TO, TD), ncol=4, nrow = 1)
colnames(x)=c("Part_PET", "TGP", 
        "TO", "TD")
rownames(x)=c("Agregado")
########################################################################################
          #Indicadores mercado laboral Barranquilla
#####################################################################################
PTB<-Tab4%>%filter(Tab4$AREAR%in%c("Barranquilla"))
PTB1<-sum(PTB$Freq)
PETB<-PTB%>%filter(PTB$EDAD!="Niños")
PETB1<-sum(PETB$Freq)
view(PETB1)
OB<-Tab3%>%filter(Tab3$AREAR=="Barranquilla" & Tab3$REGIS.=="60")
OB1<-sum(OB$Freq)
DB<-Tab3%>%filter(Tab3$AREAR=="Barranquilla" & Tab3$REGIS.y=="70")
DB1<-sum(DB$Freq)
IB<-Tab3%>%filter(Tab3$AREAR=="Barranquilla" & Tab3$REGIS.y=="80")
IB1<-sum(IB$Freq)
PEAB<-sum(OB1, DB1)
PartPETB<-round((PETB1/PTB1),3)*100
TGPB<-round((PEAB/PETB1),3)*100
TOB<-round((OB1/PETB1),3)*100
TDB<-round((DB1/PEAB),3)*100
Barranquilla<-c(PartPETB, TGPB, TOB, TDB)
view(Barranquilla)
y=matrix(c(PartPETB, TGPB, TOB, TDB), ncol=4, nrow = 1)
colnames(y)=c("Part_PET", "TGP", "TO", "TD")
rownames(y)=c("Barranquilla")
Indicadores<-rbind(x,y)
######################################################################################
            #Graficando total poblaci?n por g?nero en las 13 ?reas metropolitanas
######################################################################################
Genero<-ggplot(Tab1, aes(x="", y=Freq, fill=SEXO)) + 
  geom_bar(stat = "identity", 
           color="black")+
  geom_text(aes(label=Freq),
            position=position_stack(vjust=0.5), 
            color ="black", size=8)+
  ggtitle("Total Poblaci?n por Genero ")+
  theme (plot.title = element_text(family="Comic Sans MS",
              size=rel(1.5), #Tama?o relativo de la letra del t?tulo
              vjust=2, #Justificaci?n vertical, para separarlo del gr?fico
              face="bold", #Letra negrilla. Otras posibilidades "plain", "italic", "bold" y "bold.italic"
              color="black", #Color del texto
              lineheight=1.5))+ labs(x="Porcentaje %", 
              y= "Frecuencias")+
              coord_polar(theta = "y")+
  theme_void() # remove background, grid, numeric labels

plot(Genero)
#######################################################################################
         #Gr?fico de frecuencia seg?n g?nero y total de ocupados
###############################################################################
Tab6<-Tab4%>% 
  group_by(SEXO)%>% summarise(total=sum(Freq, na.rm = TRUE))%>%
  ungroup
Tab6$Freq<-round(prop.table(Tab6$total),3)*100 

GeOc<-ggplot(Tab6, aes(x="", y=Freq, fill=SEXO)) + 
  geom_bar(stat = "identity", 
           color="white")+
  geom_text(aes(label=Freq),
            position=position_stack(vjust=0.5), 
            color ="white", size=6)+
  coord_polar(theta = "y")+
  theme_void() # remove background, grid, numeric labels
plot(GeOc)
###############################################################################            
               #Filtrando a partir de los desocupados
#################################################################################
Tab7<-Tab3%>%filter(Tab3$REGIS.y%in%c("70"))
Tab8<-Tab7%>% 
  group_by(SEXO)%>% summarise(total=sum(Freq, na.rm = TRUE))%>%
  ungroup
Tab8$Freq<-round(prop.table(Tab8$total),3)*100
GeDe<-ggplot(Tab8, aes(x="", y=Freq, fill=SEXO)) + 
  geom_bar(stat = "identity", 
           color="white")+
  geom_text(aes(label=Freq),
            position=position_stack(vjust=0.5), 
            color ="white", size=6)+
  coord_polar(theta = "y")+
  theme_void() # remove background, grid, numeric labels
plot(GeDe)
###############################################################################            
                #Filtrando a partir de los inactivos
#################################################################################
Tab9<-Tab3%>%filter(Tab3$REGIS.y%in%c("80"))
Tab10<-Tab9%>% 
  group_by(SEXO)%>% summarise(total=sum(Freq, na.rm = TRUE))%>%
  ungroup
Tab10$Freq<-round(prop.table(Tab10$total),3)*100
GeIn<-ggplot(Tab10, aes(x="", y=Freq, fill=SEXO)) + 
  geom_bar(stat = "identity", 
           color="white")+
  geom_text(aes(label=Freq),
            position=position_stack(vjust=0.5), 
            color ="white", size=6)+
  coord_polar(theta = "y")+
  theme_void() # remove background, grid, numeric labels
plot(GeIn)
###############################################################################
       #Seg?n el parentesco de quien respondi? la encuesta
##############################################################################
Tab_11<-data.frame(round(svytable(~P6050+REGIS.y, PobGen),3))
sum(Tab_11$Freq)
Tab_12<-Tab_11%>%filter(Tab_11$REGIS.y%in% c("60"))
sum(Tab_12$Freq)
###########################################################################









###################################################################################
                                       #Borrador
################################################################################
PETB<-ECG%>%filter(ECG$AREAR%in%c("Barranquilla"))
POA<-Tab3 %>% 
  group_by(AREAR)%>%
  summarise(total=sum(Freq, na.rm = TRUE))%>%
  ungroup
POA$PET<-sum(POA$total)
Total=sum(POA$total)
Total=mean(POA$PET)
view(Total)