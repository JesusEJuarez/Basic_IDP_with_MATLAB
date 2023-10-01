%{
-------------------- Brillo-----------------------------
%}
clc,clear all,close all;%Ayuda a limpiar todos los datos

ima=imread('./img/GATO.jpg');%Lee la imagen original
imagenengris=colorgris(ima);%se hace una conversion de la imagen original a escala de grises
[fil,col]=size(imagenengris);%asignar numero de filas y columnas con respecto a la imagen a grises
%{
Con este for se busca aumentar el brillo de cada pixel de la imagen a
escala de gises 
%}
val = 40;
for i=1:fil
    for j=1:col
        brillo(i,j)=val+double(imagenengris(i,j));
    end
end
%Se muestran las imagenes
figure
subplot(2,2,1),imshow(uint8(ima)), title('Imágen Original');%Muestra la Imágen Original
subplot(2,2,2),imshow(uint8(imagenengris)), title('Imágen en Grises');%Muestra la Imágen en escala de grises
subplot(2,2,3),imshow(uint8(brillo)), title('Imágen con brillo');%Muestra la Imágen a escala de grises pero con brillo 

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