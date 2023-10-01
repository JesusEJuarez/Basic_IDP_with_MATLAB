%{
---------------------Umbralizado-----------------------------
%}
%Ayuda a limpiar todos los datos
clear all; clc;  close all;
umbral(imread('./img/GATO.jpg'),100);
function umbra = umbral(imag,nivel)
%{
Esta función toma una imagen la convierte a niveles de gris y compara pixel
por pixel si el nivel es superior que un nivel de interes introducido por
el usuario, en cas de serlo le asigna el valor maximo de nivel de gris en
caso comtrario le asgina del valor minimo. Al final muestra 3 imagenes 
la orignial, la imagen en niveles de gris y la imagen umbralizada.
%}
gris = colorgris(imag);
umbra = gris;
TAM = size(imag);  % Se obtiene el tambaño del la imagen

for i = 1:TAM(1) % Crea un ciclo for para iterar sobre la altura
    for j = 1:TAM(2) %Crea un ciclo for para iterar sobre el ancho
        %Se comprueba si el pixel tiene un nivel de gris mayor
        %que el umbral de interes
        if  umbra(i,j) > nivel
            %En caso de estar sobre el umbral de interes se le asigna el
            %valor maximo de nivel de gris
            umbra(i,j) = 255;
        else
            %En caso de no estar sobre el umbral de interes se le asigna el
            %valor minimo de nivel de gris
            umbra(i,j) = 0;
        end
    end
end

%Se muestran las imagenes 
subplot(2,2,1);
imshow(imag), title('Imágen Original'); %Imágen Original
subplot(2,2,2);
imshow(gris), title('Imágen en Grises');%Imágen en Grises
subplot(2,2,3), imshow(imag), title('Imágen Original');
subplot(2,2,2);
imshow(umbra), title('Imagen umbralizada'); %Imagen umbralizada

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