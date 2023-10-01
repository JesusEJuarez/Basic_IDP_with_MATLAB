%{
-----------------------Dilatar -------------------------
%}
clc, clear all, close all;%Limpiamos la memoria
ima=imread('./img/imaBinaria.bmp');%Leemos la imágen
subplot(1,2,1) %Pone la imagen en subplot
imshow(ima),title("Imagen Original"); %Muestra la imagen
imaDilatada = dilatar(ima); %Invoca la función de dilatar 
subplot(1,2,2)  %Pone la imagen en subplot
imshow(imaDilatada),title("Imagen con dilatación");%Muestra la imagen con dilatación
function imaDilatada = dilatar(ima)
%{ 
Esta función toma una imagen binaria y aplica la operación morfologica de
dilatación 
%}
%Toma el tamaño de la imagen
[fil,col] = size(ima);
%Crea una matriz limpia con la dimenciones de la imagen
imaDilatada = zeros(fil,col);
%Los for recorren la imagen sin considerar los bordes 
for i=3:fil-2
    for j=3:col-2
        %Considera la matriz donde se va a buscar los bordes del objeto
        %Se esta consierando una matriz de 5x5 
        matriz = [0, 0, ima(i-2,j),0,0;
                  0, 0, ima(i-1,j),0,0;
                  ima(i,j-2:j+2);
                  0, 0, ima(i+1,j),0,0;
                  0, 0, ima(i+2,j),0,0];
         
        if max(max(matriz)) == 1
            %Cuando detecta un borde se le asigna un valor lógico al resultado 
            imaDilatada(i,j) = 1;
        end
    end
end
end

