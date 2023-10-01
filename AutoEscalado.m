%{
--------------------Auto-escalamiento-----------------------------
%}

%Borra las varibles creadas, limpia la consola y cierra las ventans de imagenes  
clear all; clc;  close all;
%Carga la imagenn en la varible ima
ima=imread('./img/GATO.jpg');
%Invoca la función para convertir la imagen a niveles de gris
imagris=colorgris(ima);
%Invoca la función que umenta el brillo de forma global
imabrillo= brillo(imagris,80);
%Invoca la función para el auto Escalamiento 
x= autoEscalamiento(imabrillo);


subplot(2,2,1);
imshow(ima), title('Imágen Original'); %Imágen Original
subplot(2,2,2);
imshow(imagris), title('Imágen en Grises');%Imágen en Grises
subplot(2,2,3);
imshow(imabrillo), title('Imágen en con brillo');%Imágen con brillo
subplot(2,2,4);
imshow(x), title('Imagen con Autoescalamiento'); %Imagen umbralizada

function g = autoEscalamiento(gris)
%{
Esta función toma una imagen en niveles de gris de 8 bits y
produce un auto-escalamiento
%}
%En caso de que se quiera usar una imagen en RGB gris = colorgris(gris);


%El primer max obtiene un vector con los máximos de cada columna en la
%matriz, el segundo obtiene el maximo de toda la matriz 
fMax = max(max(gris));
%El primer min obtiene un vector con los minimos de cada columna en la
%matriz, el segundo obtiene el minimo de toda la matriz 
fmin = min(min(gris));
%Obtiene el tamaño
TAM =size(gris);
%Crea una matriz de ceros del tamaño de la imagen 
g = zeros(TAM);
%Los for recorren la matriz pixel por pixel
for i=1:TAM(1)
    for j=1:TAM(2)
        %Aplica el autoescalamiento pixel por pixel
        g(i,j) = double((255/(fMax-fmin))*(gris(i,j)-fmin));
    end
end
%Convierte a entero sin signo
g = uint8(g);

end

function imagenengris = colorgris(imagencolor)
%{
Esta función toma como argumento una imagen en formato RGB
la transforma a grises de acuerdo al estadar NTSC y la devuelve
como salida
%}
ima = imagencolor; %Asigna la imagen a una variable interna en la función  
TAM = size(ima); % Se obtiene el tambaño del la imagen
for i = 1:TAM(1) % Crea un ciclo for para iterar sobre la altura
    for j = 1:TAM(2) %Crea un ciclo for para iterar sobre el ancho
        %Crea un vector con los 3 niveles RGB para un pixel
        vector= [ima(i,j,1),ima(i,j,2),ima(i,j,3)]; 
        %Multiplica el vector RBG por los factores de conversión estandar
        % del NTSC y se lo asigna a una nueva imagen en la misma posición 
        % de la imagen original 
        imagenengris(i,j) = double(vector)*[0.299;0.587;0.114];
        
    end
end
% Convierte la matriz obtenida por los for en formato sin signo de 8 bits
imagenengris = uint8(imagenengris); 

end
function salida = brillo(ima,bri)
%{Esta función toma una imagen en niveles de gris y aumenta un nivel de brillo definido por el usuario 
%}
[fil,col]=size(ima); %toma el tamaño de la imagen en grises 
%los for recorren toda la matriz pixel por pixel
for i=1:fil
    for j=1:col
        brillo(i,j)=bri+double(ima(i,j)); %agrega el brillo a cada pixel
    end
end
salida = uint8(brillo);

end