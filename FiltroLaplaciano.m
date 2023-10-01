%{
---------------------Filtro Laplaciano-----------------------------
%}

%clc, clear all, close all;
% Lee la imagen
x = imread('./img/flor.jpeg');
% Cambia la imagen a gris 
gris = colorgris(x);

filtrada = filtroLaplaciano(gris,1);
filtrada2 = filtroLaplaciano(gris,2);
filtrada3 = filtroLaplaciano(gris,3);

figure,subplot(2,2,1);%Abre una nueva ventana de figura
imshow(x), title('Imágen Original'); %Imágen Original
subplot(2,2,2);
imshow(gris), title('Imágen en Grises');%Imágen en Grises
subplot(2,2,3)
imshow(filtrada), title('Imagen con filtro Laplaciano tipo 1');%Imágen filtrada 

figure,subplot(2,2,1);%Abre una nueva ventana de figura
imshow(x), title('Imágen Original'); %Imágen Original
subplot(2,2,2);
imshow(gris), title('Imágen en Grises');%Imágen en Grises
subplot(2,2,3)
imshow(filtrada2), title('Imagen con filtro Laplaciano tipo 2');%Imágen filtrada 

figure,subplot(2,2,1); %Abre una nueva ventana de figura
imshow(x), title('Imágen Original'); %Imágen Original
subplot(2,2,2);
imshow(gris), title('Imágen en Grises');%Imágen en Grises
subplot(2,2,3)
imshow(filtrada2), title('Imagen con filtro Laplaciano tipo 3');%Imágen filtrada 


function filtrado = filtroLaplaciano(ima,tipo)
%{
Esta función toma una imagen en niveles de gris y un numero del 
1 al 3 para aplicar uno de los 3 tipos de filtros Laplacianos  
%}
% switch es para seleccionar el tipo de filtro a utilizar 
switch tipo
    case 1
        %Matriz de tipo 1
Laplace = [1,-2,1;
           -2,4,-2;
           1,-2,1];
    case 2
         %Matriz de tipo 2

Laplace = [-1,-1,-1;
           -1,8,-1
           -1,-1,-1];
    case 3
         %Matriz de tipo 3

Laplace = [0,-1,0
           -1,4,-1
           0,-1,0];
    otherwise
        %Marca error en caso de que no sea un numero del 1 al 3
        disp('Solo numeros 1 al 3')
end
%Toma el tamaño de la imagen
[fil,col,capa] = size(ima);
%En casa de que la imagen no este en niveles de grises la convierte
if capa == 3 
    ima = colorgris(ima)
end
%Crea una matriz limpia con la dimenciones de la imagen
filtrado = zeros(fil,col);
%Los for recorren la imagen sin considerar los bordes 
for i=2:fil-1
    for j=2:col-1
        %Crea la matriz que se va usar para la convolución 
        matriz = double(ima(i-1:i+1,j-1:j+1));
        %Realiza la convolución 
        for k=1:3
            for m=1:3
             filtrado(i,j) = double(filtrado(i,j)+matriz(k,m)*Laplace(k,m));
            end
        end
    end
end
     %Covierte 
     filtrado = uint8(filtrado);
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