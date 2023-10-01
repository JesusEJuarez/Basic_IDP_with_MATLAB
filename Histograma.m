%{
---------------------Histograma-----------------------------
%}
clc,clear all, close all;%Ayuda a limpiar todos los datos
imag=imread('./img/GATO.jpg');%Lee la imagen original
[fil,col,capa]=size(imag);%asignar numero de filas, columnas y capa con respecto a la imagen original
%{
Con este if se busca convertir la imagen a escala de grises dependiendo de
la capa
%}
if capa==3
    ima=colorgris(imag);
end
histograma=zeros(1,256);%El espacio que se mostrara en el histograma
%{
Con este for se sacara el histograma tomando como base la imagen a escala
de grises
%}
for i=1:fil
    for j=1:col
        valor=double(ima(i,j));
        histograma(1,valor+1)=histograma(1,valor+1)+1;
    end
end
%Se muestran las imagenes
figure 
subplot(2,2,1),imshow(uint8(imag)),title('Imágen Oirginal');%Se muestra la Imágen Original
subplot(2,2,3),imshow(uint8(ima)),title('Imágen a Grises');%Se muestra la Imágen a Grises
subplot(2,2,4), bar(histograma),title('Histograma');%Se muestra el Histograma

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