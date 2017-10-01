function [var,Pi,LZ]=modelo_atm(z,P0,T0,Mm0)
%Defino Variables
var = zeros(4,1);
LZ = zeros(21,1);
Pi = zeros(21,1);
Di = zeros(21,1);
%Parametr0s
Ru = 8314.32;
RT = 63781e6;
g0 = 9.7803;
gamma = 1.4;
b = 2.0/RT;
R = Ru/Mm0;
%Cargo datos de las capas atmosfericas
load datos_atm.mat
Tmi = datos_atm(:,3);
Zi = datos_atm(:,2);
Mmi = datos_atm(:,4);
Pi(1)=P0;
Tmi(1)=T0;
Mmi(1)=Mm0;
Di(1) = P0/(T0*R);
%Gravedad e función de la altitud
g = g0*(1-b*z);
%Calculo del parametro de variación de temperaturas en cada capa:
for j = 1:20
    LZ(j) = (Tmi(j+1)-Tmi(j))/(Zi(j+1)-Zi(j));        
end
%Calculo de la presion al inicio de cada capa
for j = 1:20
    if abs(LZ(j))>0.001
        aux1 = 1+b*(Tmi(j)/LZ(j)-Zi(j));
        aux2 = aux1*g0/(R*LZ(j));
        aux3 = Tmi(j+1)/Tmi(j);
        aux4 = aux3^(-1.0*aux2);
        aux5 = exp(g0*b*(Zi(j+1)-Zi(j))/(R*LZ(j)));
        Pi(j+1) = Pi(j)*aux4*aux5;
        aux7 = aux2 + 1;
        Di(j+1) = Di(j)*aux5*aux3^(-1.0*aux7);
    else
        aux8 = (-1.0*g0*(Zi(j+1)-Zi(j)))*(1-b/2*(Zi(j+1)-Zi(j)))/(R*Tmi(j));
        Pi(j+1) = Pi(j)*exp(aux8);
        Di(j+1) = Di(j)*exp(aux8);
    end
end


for j = 1:20
    if (z>=Zi(j)) && (z<Zi(j+1))
        if abs(LZ(j))>=0.001
            aux1 = 1+b*(Tmi(j)/LZ(j)-Zi(j));
            Tm = Tmi(j)+LZ(j)*(z-Zi(j));
            aux2 = aux1*g0/(R*LZ(j));
            aux3 = Tm/Tmi(j);
            aux4 = aux3^(-1.0*aux2);
            aux5 = exp(b*g0*(z-Zi(j))/(R*LZ(j)));
            P = Pi(j)*aux4*aux5;
            aux7 = aux2+1.0;
            D = Di(j)*aux3^(-1.0*aux7)*aux5;
            disp(['Se supone que calculo la presion con LZ/=0. P = ', num2str(P),'  Pa'])
            
        else
            Tm = Tmi(j);
            aux8 = -1.0*g0*(z-Zi(j))*(1-b/2)*(z-Zi(j))/(R*Tmi(j));
            P = Pi(j)*exp(aux8);
            D = Di(j)*exp(aux8);
            disp(['Se supone que calculo la presion con LZ=0. P = ', num2str(P),' Pa'])
       
        end
        a = sqrt(gamma*R*Tm);
        Mm = Mmi(j)+(Mmi(j+1)-Mmi(j))/(Zi(j+1)-Zi(j))*(z-Zi(j));
        T = Mm*Tm/Mm0;
        % Salida de la funcion
        var(1,1) = P;
        var(2,1) = T;
        var(3,1) = D;
        var(4,1) = a;
    end 
end

end