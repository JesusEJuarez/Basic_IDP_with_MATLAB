%{
--------------------OTSU-----------------------------
%}
clc,clear all, close all;%Ayuda a limpiar todos los datos
imag=imread('./img/GATO.jpg');%Lee la imagen original
[fil,col,capa]=size(imag);%asignar numero de filas, columnas y capa con respecto a la imagen original
%% Creación del historgrama 
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
        histograma(1,valor+1)=(histograma(1,valor+1)+1);
    end
end

histograma = histograma/(fil*col); %En esta linea se normaliza el histograma 
%% Suma de probabilidad y Media acumulativa 
P = zeros(1,256); %Se declara un vector para guardar las sumas acumulativas 
m = zeros(1,256); %Se declara un vector para guardar la medias 
for k=1:256 %Este for recorre todos los valores de k
    for d = 1:k %Este for controla hasta que valor de k se calcula 
        P(1,k) = histograma(1,d)+P(1,k);   %Calculo de la probabilidad para cada k
        m(1,k) = histograma(1,d)*d + m(1,k); %Calculo de la media para cada k 
    end
end
%% Media global 
mG =0; 
for k=1:256
    mG = mG+k*histograma(1,k);
end
%% Vaianza 
sigma = zeros(1,256);
for k=1:256
sigma(1,k) = ((mG*P(1,k) - m(1,k))^2)/(P(1,k)*(1-P(1,k))); %Esta es la función que se debe maximizar para encontrar el limite 
end

[M,limite]= max(sigma,[],'all','linear'); %Se obtiene el valor de 'k' para el cual la función sigma es máxima

%% Segmentación 
imaOTSU = zeros(fil,col); %Se crea una imagen vacia con las mismas dimenciones de la imagen original
imaOTSU = umbral(ima,limite); %Se utiliza la función de umbralizar para binarizar con base al valor de k para el cual la función sigma es máxima
%% Despliegue de imagenes 
figure 
subplot(2,2,1),imshow(uint8(ima)),title('Imágen a Grises');%Se muestra la Imágen a Grises
subplot(2,2,2), bar(histograma),title('Histograma');%Se muestra el Histograma
subplot(2,2,3), imshow(uint8(imaOTSU)),title('Imágen Otsu');%Se muestra la Imágen binarizada 
%% Funciones 
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

function umbra = umbral(imag,nivel)
%{
Esta función toma una imagen la convierte a niveles de gris y compara pixel
por pixel si el nivel es superior que un nivel de interes introducido por
el usuario, en caso de serlo le asigna el valor maximo de nivel de gris en
caso comtrario le asigna el valor minimo.
%}

umbra = imag;
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


end