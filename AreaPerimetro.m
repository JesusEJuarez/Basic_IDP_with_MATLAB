%{
------------------------Area y Perimetro-------------------------
%}
clc;clear all;close all;%se limpia la ventana de comandos, se cierran figuras y las variables 

ima=imread('./img/imagPrac47.png');%Lee la imagen indicada y se la asigna a una variale
[fil ,col,capa]=size(ima);%Se declaran el numero de filas, columnas y capas que tiene la imagen
if capa==3
    gris=colorgris(ima);
end
ima_bin=umbralizado(gris,100);%La imagen umbralizada la convierte a escala de grises

B=ones(3,3);%Crea una matriz de unos de 3*3
im_pas=ima_bin;%Crea una nueva variable con los mismos elementos de la imagen binaria

pos_ele=find(im_pas==1);pos_ele=pos_ele(1);%Almacena la posiciones de los elementos de la imagen
[fil,col] = size(im_pas);%Los valores de fila y columna usando las dimensiones de la imagen
Etiqueta=zeros(fil,col);%Crea una nueva matriz de ceros 
Num_obj=0;%Establece el contador de objetos 

%Con este ciclo se puede saber las posicion de cada figura de la imagen y
%acada figura se le asigna un numero para poder identificarla para las
%demas operaciones
while(~isempty(pos_ele))
    Num_obj=Num_obj+1;
    pos_ele=pos_ele(1);
    x=zeros(fil,col);
    x(pos_ele)=1;
    y=im_pas&imdilate(x,B);%Se crea una nueva variable obtenida de la operacion AND entre la imagen original y la imagen dilatada x
    
    %Con este ciclo mientras que x=y sea igual se seguira obteniendo nuevas
    %variables
while(~isequal(x,y))
    x=y;
    y=im_pas&imdilate(x,B);
end

pos=find(y==1);%Crea una nueva matriz con las posiciones de y 
im_pas(pos)=0;%Las posiciones indicadas las variable imagen convirtiendolas en 0

Etiqueta(pos)=Num_obj;%Las posiciones indicadas las variable imagen convirtiendolas en el numero de objetos de la imagen
pos_ele=find(im_pas==1);%Se busca en la imagen donde hay un 1  

end

imagaSalida=zeros(fil,col,3);%Se hace una imagen RGB 
Red=zeros(fil,col);%Crea una matriz de ceros para la componente R 
Green=zeros(fil,col);%Crea una matriz de ceros para la componente G 
Blue=zeros(fil,col);%Crea una matriz de ceros para la componente B 

red = 255*rand; %Genera un nivel de rojo aleatorio 
blue = 255*rand; %Genera un nivel de azul aleatorio 
green = 255*rand; % %Genera un nivel de verde aleatorio

%Con este ciclo sacamos el valor de area de cada figura que hay en la
%imagen ademas que se cambia el color de  de las figuras aleatoriamente
for i=1:Num_obj  
    pos=find(Etiqueta==i);
    area(i) = round(length(pos));
    Num = i;
    fprintf('Area del Objeto %i:\n',Num);
    disp(area(i));
    Red(pos)= mod(i,2)*red;
    Green(pos)= mod(i,100)*green;
    Blue(pos)= mod(i,50)*blue;
end

t = size(ima_bin);%Tamaño de la imagen binaria
Mat=zeros(t(1),t(2));%Matriz

%Esta funcion a define las coordenadas en un pixel de pixeles 8-vecinos
for obj = 1:Num_obj
for i = 2:t(1)-1
    for j = 2:t(2)-1
        if ima_bin(i,j)==obj
            if ima_bin(i-1,j-1)==0 || ima_bin(i-1,j)==0 || ima_bin(i-1,j+1)==0 || ima_bin(i,j+1)==0 || ima_bin(i,j-1)==0 || ima_bin(i+1,j-1)==0 || ima_bin(i+1,j)==0 || ima_bin(i+1,j+1)==0
                Mat(i,j)=obj;
            end
        end
    end
end
end

M = size(Mat);%Tamaño de la Matriz
Matriz = Mat;%Matriz

%Con esta funcion se puede seguir la secuencia del contorno
pos = 1;
r2 = sqrt(2);
for p_obj = 1:Num_obj 
    for i = 1:M(1)
        for j = 1:M(2)
            if Matriz(i,j) == 1
                x = i;
                y = j;
                while true
                 if Matriz(x,y+1) == 1 
                    y = y+1;
                    posicion(pos) = 1;
                    pos = pos+1;
                    Matriz(x,y) = 0;
                elseif Matriz(x+1,y+1) == 1
                    x = x+1;
                    y = y+1;
                    posicion(pos) = r2;
                    pos = pos+1;
                    Matriz(x,y) = 0;
                elseif Matriz(x+1,y) == 1 
                    x = x+1;
                    posicion(pos) = 1;
                    pos = pos+1;
                    Matriz(x,y) = 0;
                elseif Matriz(x+1,y-1) == 1 
                    x = x+1;
                    y = y-1;
                    posicion(pos) = r2;
                    pos = pos+1;
                    Matriz(x,y) = 0;
                elseif Matriz(x,y-1) == 1
                    y = y-1;
                    posicion(pos) = 1;
                    pos = pos+1;
                    Matriz(x,y) = 0;
                elseif Matriz(x-1,y-1) == 1
                    x = x-1;
                    y = y-1;
                    posicion(pos) = r2;
                    pos = pos+1;
                    Matriz(x,y) = 0;
                elseif Matriz(x-1,y) == 1 
                    x = x-1;
                    posicion(pos) = 1;
                    pos = pos+1;
                    Matriz(x,y) = 0;
                elseif Matriz(x-1,y+1) == 1 
                    x = x-1;
                    y = y+1;
                    posicion(pos) = r2;
                    pos = pos+1;
                    Matriz(x,y) = 0;
                 else
                     break
                 end
                end
                
            end
        end
    end
end

%Con este ciclo sacamos el valor del perimetro de cada figura que hay en la
%imagen
for i=1:Num_obj    
    pos=find(Etiqueta==i);
    perimetro(i) = sum(pos(i));
    Num1 = i;
    fprintf('Perimetro del Objeto %i:\n',Num1);
    disp(perimetro(i));
end
      imagaSalida(:,:,1) = Red; %Asigna los valores a R
      imagaSalida(:,:,2) = Blue; %Asigna los valores a G
      imagaSalida(:,:,3) = Green;%Asigna los valores a B

figure;
subplot(2,2,1),imshow(ima), title('imagen original');%Muestra la imagen original
subplot(2,2,2),imshow(uint8(imagaSalida));title('Objetos etiquetados');%Crea una figura y muetra la imagen con los objetos etiquetados
figure;
imshow(Mat),title('Perimetro de la imagen');%Muestra Imagen del contorno de las figuras

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

function[xr]=umbralizado(x,level)
t=size(x);%La variable t dara el tamaño de la matriz x
xr=zeros(t);%Se cre una matriz de caros del tamaño del  mismo tamaño de t
%Se hace un  2 ciclos for donde se usara la condicional para determinar el valor del cada pixel 
for i=1:t(1)
    for j=1:t(2)
        if x(i,j)>=level
            xr(i,j)=1;
            %En caso contrario en la posicion se le asiganra el 0
        else
            xr(i,j)=0;
        end
    end
end
xr=uint8(xr);%Se convierten datos a enteros de 8 bits
end