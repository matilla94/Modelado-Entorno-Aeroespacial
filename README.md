# Modelado-Entorno-Aeroespacial
Modelado de la atmósfera terrestre y el campo gravitatorio, aplicable al entorno de vehículos aeroespaciales. 

El modelo atmosférico combina dos modelos atmosféricos americanos, el "U.S. Standard Atmosphere 1976" para altitudes inferiores a 86 kilómetros y "1962 Standard Atmosphere" para alturas superiores. De esta manera se obtiene un nivel de detalle muy superior a las propiedades atmosféricas aportadas por la Atmósfera Estandar Internacional.
En el script "modelo_atm.m" la atmósfera se divide en multiples capas, donde se definen una condiciones iniciales al inicio de cada nivel, almacenados en el archivo "datos_atm.mat".

Por su parte, el campo gravitatorio está desarrollado en función de armónicos esféricos que permiten incluir las perturbaciones del campo debidos al achatamiento terrestre y a la distribucció no uniforme de la masa del planeta.


Referencia: "Atmospheric and Space Flight Dynamics" de Tewari A. y "Dynamics of Atmospheric Re-Entry" de Regan F.J.
