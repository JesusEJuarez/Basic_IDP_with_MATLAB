%{
--------------------- Realce de rangos-----------------------------
%}
%Ayuda a limpiar todos los datos
clear all; clc;  close all;


realceRangos(imread('./img/GATO.jpg'),190,250,50);


function realce = realceRangos(imag,nivelInf,nivelSup,valRealce)
%{
Esta función toma como argumento una imagen en formato RGB
la transforma a grises utilizando otra función y compara el nivel de
gris en cada pixel con un rango de valores, en caso de estar en ese rango
se aumenta el nivel de gris sumando valRealce, en caso contrario
se le resta valRealce. Al final muestra la imagen orginal, la imagen en 
grises y la imagen con realce
%}
gris = colorgris(imag); % Invoca la función para obtener los niveles de gris
realce = gris; % Asigna la imagen en niveles de gris a una nueva variable
TAM = size(imag);  % Se obtiene el tambaño del la imagen

for i = 1:TAM(1) % Crea un ciclo for para iterar sobre la altura
    for j = 1:TAM(2) %Crea un ciclo for para iterar sobre el ancho
        %Comprueba si el nivel de gris se encuentra dentro del rango de
        %interes 
        if nivelInf <= realce(i,j) & realce(i,j) <= nivelSup
            %Cuando se encuntra dentro del rango de interes se agrega
            %valRealce al nivel actual de gris
            realce(i,j) = realce(i,j)+ valRealce;
        else
            %Cuando no se encuntra dentro del rango de interes se resta
            %valRealce al nivel actual de gris
            realce(i,j) = realce(i,j)-valRealce;
        end
    end
end
%Se muestran las imagenes 
subplot(2,2,1);
imshow(imag), title('Imágen Original'); %Imágen Original
subplot(2,2,2);
imshow(gris), title('Imágen en Grises');%Imágen en Grises
subplot(2,2,3)
imshow(realce), title('Imagen con realce de rangos');%Imágen con realce de rangos

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
