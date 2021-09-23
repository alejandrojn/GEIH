5+5
a<-10
a
b<-20
z<-a+b
z
#Ideas Basicas de R
#1. Trabajamos sobre objetos o vectores
#2. Los objetos hay que nombrarlos
#3. Sobre los objetos aplicamos funciones. 
    #Estas las podemos crear o podemos usar las que otros han creado.
#4.Se dará cuenta que la sintaxis sigue una estructura. Eso es como aprender a hablar, 
   #uno sigue unas reglas gramaticales 
   #aún si no sabe cuales son esas reglas. Puro conocimiento tácito. 
   #La experiencia es lo que nos dá la maestría.
#########################################################################
install.packages("flextable")
library(flextable)
#Los datos
Día<-c("Lunes")
Valor<-c(31)
Unidad<-c("Celsius")
df<-data.frame(Día,Unidad,Valor)
myft<-flextable(df)
View(myft)
bft<-bold(myft,i=1, part="header")
bft<-theme_zebra(bft)
bft
###############################################################################
#Señal y Ruido
library(quantmod)
start<-as.Date("2007-01-01")
end<-as.Date("2021-09-02")
getSymbols("BZ=F",src="yahoo", from=start, to=end)
#############################################################################
#Gráfico precios Brent diario
library(dygraphs)
brentd<-dygraph(`BZ=F`[,"BZ=F.Close"],main="Brent-precio de cierre (USD)-Diario")
brentd
#############################################################################
#Gráfico precios Brent mensual
brentm<-apply.monthly(`BZ=F`,mean, na.rm=TRUE)
dygraph(brentm[,"BZ=F.Close"],main="Brent-precio de cierre (USD)-Mensual")
############################################################################
#Gráficos precios brent anual
brenty<-apply.yearly(`BZ=F`,mean, na.rm=TRUE)
dygraph(brenty[,"BZ=F.Close"],main="Brent-precio de cierre (USD)-Anual")
############################################################################
#Creación de vectores atómicos
dado<-c(1,2,3,4,5,6)
diez<-c(10)
asistentes<-c("pedro","juan","diana","helena")
nota<-c(3.1,4.2,4.5,3.8)
mean(nota)
########################################################################
###Si los vectores tienen la misma longitud se pueden unir por columnas
curso<-cbind(asistentes, nota)
#o por filas
curso1<-rbind(nota, asistentes)
#############################################################################
#Data Frame: Es un arreglo de datos de dos dimensiones en forma matricial.
#Si ha trabajado con bases de datos, esto le será familiar
df<-data.frame(curso)
class(df$asistentes)
###########################################################################
#Se puede crear una variable a partir de una función matemática
curso$df<-2*df$nota
###########################################################################
## Transformar la variable nota en el data frame a numérica
df$nota<-as.numeric(df$nota) # convertimos de character a numeric
class(df$nota)
curso$df<-2*df$nota
df$lnota<-log(df$nota)
###########################################################################
#Tipos de datos
library(flextable)
Raza<-c("Doberman","Criollo","Bulldog","Collie")
Peso<-c(28.5,19.2,31.4,23.6)
Sexo<-c("Hembra","Hembra","Hembra","Macho")
Puesto<-c(2,1,4,3)
perros<-data.frame(Raza,Peso,Sexo,Puesto)
perrosft<-flextable(perros)
perrosft<-bold(perrosft,i=1, part="header")
perrosft<-theme_zebra(perrosft)
perrosft


