%{
-----------------------Filtros Frecuenciales -------------------

%}
Ima = double(colorgris(imread('./img/GATO.jpg')));
[f,c] = size(Ima);

%Filtro frecuencial 
DFT_Ima = fft2(Ima);
%Centro el espectro 
DFT_Ima = fftshift(DFT_Ima);

%Filtro pasa bajas 
D0 = f/2/15; %Frecuencia partir de la que se filtra
Pasabajas = zeros(f,c); %Crea una matriz de 0 para el filtro

for i = 1:f
    for j = 1:c
        D = sqrt((i-f/2)^2+(j-c/2)^2); %Distancia del centro al punto i,j
        if D<D0 % Sí la frecuencia se encuntra por debajo de la frecuenciade corte 
                % entonces se asigna 1 a esa posición
            Pasabajas(i,j) =1;
        end
    end
end
%Transformada de la imagen por el filtro
DFT_Ima_Filtrada = DFT_Ima.*Pasabajas; %Multiplicación elemento por elemento 
                                      % para mantener las posiciónes por
                                      % debajo de la frecuencia de corte 
%DFT inversa
Ima_Filtrada = ifft2(DFT_Ima_Filtrada);

%Filtro pasa altas 
PasaAltas = zeros(f,c); %Crea una matriz de 0 para el filtro
for i = 1:f
    for j = 1:c
        D = sqrt((i-f/2)^2+(j-c/2)^2); %Distancia del centro al punto i,j
        if D>D0
            PasaAltas(i,j) =1; % Sí la frecuencia se encuntra por arriba de la frecuenciade corte 
                                % entonces se asigna 1 a esa posición
        end
    end
end
%Transformada de la imagen por el filtro
DFT_Ima_FiltradaA = DFT_Ima.*PasaAltas; %Multiplicación elemento por elemento 
                                        % para mantener las posiciónes por
                                        % arriba de la frecuencia de corte 
%DFT inversa
Ima_FiltradaA = ifft2(DFT_Ima_FiltradaA);

%Se toma el modulo para descartar cualquier residuo de tipo complejo 
Ima_Filtrada = abs(Ima_Filtrada);
Ima_FiltradaA = abs(Ima_FiltradaA);

figure,subplot(2,3,1) %Crea una figura y despliega en un subplot
imshow(uint8(Ima)) % Muestra la imágen 
title('Imagen Original')
subplot(2,3,2)       %Crea una figura y despliega en un subplot
mesh(abs(log(DFT_Ima+1)))% Muestra el espectro de la imágen filtrada 
title('Espectro de la imagen original')
subplot(2,3,3)     % Despliega en un subplot
mesh(abs(log(DFT_Ima_Filtrada+1))) % Muestra el espectro de la imágen filtrada
title('Espectro de la imagen filtrada')
subplot(2,3,4)     % Despliega en un subplot
imshow(uint8(Ima_Filtrada)) %Muestra la imágen filtrada 
title('Imagen filtrada')
subplot(2,3,5)  % Despliega en un subplot
imshow(Pasabajas) %Muestra el filtro 
title('Filtro pasa bajas') 

figure,subplot(2,3,1)
imshow(uint8(Ima)) % Muestra la imágen 
title('Imagen Original')
subplot(2,3,2) 
mesh(abs(log(DFT_Ima+1))) % Muestra el espectro de la imágen 
title('Espectro de la imagen original')
subplot(2,3,3) 
mesh(abs(log(DFT_Ima_FiltradaA+1))) % Muestra el espectro de la imágen filtrada
title('Espectro de la imagen filtrada')
subplot(2,3,4)
imshow(uint8(Ima_FiltradaA))
title('Imagen filtrada')  %Muestra la imágen filtrada 
subplot(2,3,5)
imshow(PasaAltas)
title('Filtro pasa altas')%Muestra el filtro

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

