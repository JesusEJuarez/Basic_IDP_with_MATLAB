%{
---------------------Filtro Gauss-----------------------------
%}

clc, clear all, close all;
% Lee la imagen
x = imread('./img/GATO.jpg');
% Cambia la imagen a gris 
gris = colorgris(x);
% Agrega ruido a la imagen
ruido = imnoise(gris,'salt & pepper',0.05);
% Limpia el ruido utilizando el filtro de Gauss de cada tipo 
filtrada = filtroGauss(ruido,1);
filtrada2 = filtroGauss(ruido,2);
filtrada3 = filtroGauss(ruido,3);

figure,subplot(2,2,1);%Abre una nueva ventana de figura
imshow(x), title('Imágen Original'); %Imágen Original
subplot(2,2,2);
imshow(gris), title('Imágen en Grises');%Imágen en Grises
subplot(2,2,3)
imshow(ruido), title('Imagen con ruido'); %Imágen con ruido
subplot(2,2,4)
imshow(filtrada), title('Imagen con filtro Gauss tipo 1');%Imágen filtrada 

figure,subplot(2,2,1);%Abre una nueva ventana de figura
imshow(x), title('Imágen Original'); %Imágen Original
subplot(2,2,2);
imshow(gris), title('Imágen en Grises');%Imágen en Grises
subplot(2,2,3)
imshow(ruido), title('Imagen con ruido'); %Imágen con ruido
subplot(2,2,4)
imshow(filtrada2), title('Imagen con filtro Gauss tipo 2');%Imágen filtrada 

figure,subplot(2,2,1); %Abre una nueva ventana de figura
imshow(x), title('Imágen Original'); %Imágen Original
subplot(2,2,2);
imshow(gris), title('Imágen en Grises');%Imágen en Grises
subplot(2,2,3)
imshow(ruido), title('Imagen con ruido'); %Imágen con ruido
subplot(2,2,4)
imshow(filtrada3), title('Imagen con filtro Gauss tipo 3');%Imágen filtrada 


function filtrado = filtroGauss(ima,tipo)
%{
Esta función toma una imagen en niveles de gris y un numero del 
1 al 3 para aplicar uno de los 3 tipos de filtros de Gauss  
%}
% switch es para seleccionar el tipo de filtro a utilizar 
switch tipo
    case 1
        %Matriz de Gauss tipo 1
gauss = [1,2,3,2,1;
          2,7,11,7,2;
          3,11,17,11,3;
          2,7,11,7,2;
          1,2,3,2,1];
    case 2
         %Matriz de Gauss tipo 2

gauss = [3,6,7,6,3;
          6,9,11,9,6;
          7,11,17,11,7;
          6,7,11,7,6;
          3,6,7,6,3];
    case 3
         %Matriz de Gauss tipo 3

gauss = [7,8,9,8,7;
         8,10,11,10,8;
         9,11,17,11,9;
         8,10,11,10,8;
         7,8,9,8,7];
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
for i=3:fil-2
    for j=3:col-2
        %Crea la matriz que se va usar para la convolución 
        matriz = double(ima(i-2:i+2,j-2:j+2));
        %Realiza la convolución 
        for k=1:5
            for m=1:5
             filtrado(i,j) = double(filtrado(i,j)+matriz(k,m)*gauss(k,m));
            end
        end
    end
end
     %Invoca la función de auto escalamieto
     filtrado = autoEscalamiento(filtrado);
end


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