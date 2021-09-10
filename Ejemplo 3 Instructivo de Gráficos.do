clear
sysuse auto.dta /*Datos incorporados de stata*/
sum /*Resumen de los datos*/
histogram price, bin(10)/*Gráfico de frecuencia de barras*/ 
histogram price, width(1000) start(3291)/*Grafico de barra determinando el tamaño de los valores de frecuencia*/ 
twoway (scatter mpg weight)/*Gráfico de dispersión entre dos variables*/
twoway (scatter weight mpg) (lfit weight mpg)/*Grafico de dispersión ajuste de modelo con predicción lineal*/
regress mpg weight /*Regresión lineal lineal entre dos variables*/
graph matrix price mpg weight length/*Gráfico de dispersión con distintas variables*/
graph matrix price mpg weight length, half by(foreign)/*Grafico de dispersión con distintas variables y divididas por subgrupos*/
