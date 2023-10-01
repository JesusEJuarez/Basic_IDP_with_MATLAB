%{
------------------------Erosión -------------------------
%}

clc, clear all, close all;%Limpiamos la memoria
ima=imread('./img/imaBinaria.bmp');%Leemos la imágen
subplot(1,2,1)%Pone la imagen en subplot
imshow(ima),title("Imagen Original");%Muestra la imagen
imaErosion = erosion(ima); %Invoca la función de erosión
subplot(1,2,2)%Pone la imagen en subplot
imshow(imaErosion),title("Imagen con erosión");%Muestra la imagen
function imaErosion = erosion(ima)
%{ 
Esta función toma una imagen binaria y aplica la operación morfologica de
erosión
%}
%Toma el tamaño de la imagen
[fil,col] = size(ima);
%Crea una matriz limpia con la dimenciones de la imagen
imaErosion = zeros(fil,col);
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
         
        if sum(sum(matriz)) == 9
            %Cuando todos los elementos de la matriz de interes son True
            %se asgina un True a la nueva matriz
            imaErosion(i,j) = 1;
        end
    end
end
imaErosion = imaErosion*255;
end