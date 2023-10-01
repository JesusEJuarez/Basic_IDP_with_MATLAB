%{
---------------------Filtro mediana-----------------------------
%}
clc, clear all, close all;
% Lee la imagen
x = imread('./img/GATO.jpg');
% Cambia la imagen a gris 
gris = colorgris(x);
% Agrega ruido a la imagen
ruido = imnoise(gris,'salt & pepper',0.05);
% Limpia el ruido utilizando el filtro mediana 
filtrada = filtroMediana(ruido);

subplot(2,2,1);
imshow(x), title('Imágen Original'); %Imágen Original
subplot(2,2,2);
imshow(gris), title('Imágen en Grises');%Imágen en Grises
subplot(2,2,3)
imshow(ruido), title('Imagen con ruido'); %Imágen con ruido
subplot(2,2,4)
imshow(filtrada), title('Imagen con filtro por mediana');%Imágen filtrada 


function imaFiltrada = filtroMediana(ima)
%Toma el tamaño de la imagen
[fil,col,capa] = size(ima);
%En casa de que la imagen no este en colores de grises la convierte
if capa == 3 
    ima = colorgris(ima);
end

%Utiliza dos for para recorrer la matriz sin considerar los bordes
for i=2:fil-1
    for j=2:col-1
        %Toma la matriz de 3x3 del pixel de interes y la asigna como un
        %vector renglon, para utilizar un algoritmo de ordenamiento.
        ordena = ordenaBurbuja([ima(i-1,j-1:j+1), ima(i,j-1:j+1),ima(i+1,j-1:j+1)]);
        % De la lista ordenada toma el valor que se encuntra a la mitad es
        % decir la mediana
        mediana = ordena(1,5);
        %Se asgina la medina al pixel de interes en la nueva matriz
        imaFiltrada(i,j) = mediana; 
    end
end
imaFiltrada;
end

function orden = ordenaBurbuja(a)
%Toma el tamaño del arreglo
[x,tam] = size(a);
    for i=1:tam
        for j=1:(tam-1)
            %Compara el valor de cada posicion con el valor de la posición
            %siguente, en caso de ser una valor mayor los intercambia de
            %posición 
            if(a(j)>a(j+1))
                aux = a(j);
                a(j) = a(j+1);
                a(j+1) = aux;
            end
        end 
    end 
    orden=a;
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