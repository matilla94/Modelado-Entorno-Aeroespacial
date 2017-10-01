function [g_r,g_phi] = modelo_grav(lat,z)
%Parametros
GM = 3.986005e14;
J2 = 1.08263e-3;
J3 = 2.532153e-3;
J4 = 1.61098e-6;
RE = 6.378135e6;
%Variables
lat = lat*pi/180;
phi = pi/2-lat; % La referencia es el vector Z, no el plano ecuatorial
r = RE + z;
coef_legendre = cos(phi);
%Polinomios de Legendre
P2 = legendreP(2,coef_legendre);
P3 = legendreP(3,coef_legendre);
P4 = legendreP(4,coef_legendre);

%Aceleración de la gravedad en ejes horizonte local
g_r = -GM/r^2*(1-3*J2*(RE/r)^2*P2-4*J3*(RE/r)^3*P3-5*J4*(RE/r)^4*P4);
g_phi = 3*GM/r^2*(RE/r)^2*sin(phi)*cos(phi)*(J2+J3/2*(RE/r)*sec(phi)*(5*cos(phi)^2-1)+5/6*J4*(RE/r)^2*(7*cos(phi)^2-1));
end