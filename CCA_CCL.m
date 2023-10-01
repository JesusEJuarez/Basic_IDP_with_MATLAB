
%{
------------------------ CCA CCL-------------------------

%}

clear all; clc;  close all; %Limpia la ventana y la memoria 
imag = imread('./img/imagPrac47.png'); % Lee la imagén y la guarda en una variable 
[fil,col,capa] = size(imag); % Se obtiene el tamaño de la imagén
binarizada = umbral(imag,30); % Invoca la función de umbralizado
etiqueta = 1; % Crea una variable para guardar las etiquetas

visitado = false(size(imag)); % Crea una matriz logica con el maaño de la imagen, para así registrar pixeles visitado.


B = zeros(fil,col); %Crea una matriz con las mismas dimeciones de la imagén, aqui se guardara los componentes con su etiqueta.
imagaSalida = zeros(fil,col,capa); % En esta matriz de guardara una imagén recoloreada por etiqueta. 

for i = 2 : fil-1
    for j = 2 : col-1
        %Recorre la matriz sin concerara los bordes
        if imag(i,j) == 0 %Si el pixel en la imagne es 0, solo se marca como visitado
            visitado(i,j) = true;

        elseif visitado(i,j) %Cuando el valor es diferente de 0 pero ya fue revisado el pixel no se realiza acción 
            continue;
        else %Cuando el valor es 1 y no se ha visitado ese pixel 
            pila = [i j]; % Agrega la ubicación a una pila
            while ~isempty(pila) % Mientras la pila no este vacia
                ubicacion = pila(1,:); %Guarda la ubicación 
                pila(1,:) = []; %Saca el primer valor de la pila
                if visitado(ubicacion(1),ubicacion(2)) % Si el pixel ya fue visitado, continue
                    continue;
                end

               
                visitado(ubicacion(1),ubicacion(2)) = true; % Marca el pixel como visitado
                B(ubicacion(1),ubicacion(2)) = etiqueta; %Asigna el valor de la etiqueta actual

                
                [ubicacion_y, ubicacion_x] = meshgrid(ubicacion(2)-1:ubicacion(2)+1, ubicacion(1)-1:ubicacion(1)+1); %obitene los indices de la ubicacion para revisar la vecindad 8 
                ubicacion_y = ubicacion_y(:);
                ubicacion_x = ubicacion_x(:);


         
                iSvisited = visitado(sub2ind([fil col], ubicacion_x, ubicacion_y)); %Revisa si el pixel fue visitado

                ubicacion_y(iSvisited) = [];
                ubicacion_x(iSvisited) = [];

                esObjeto = imag(sub2ind([fil col], ubicacion_x, ubicacion_y)); %Revisa los pixeles vecinos con valor 0
                ubicacion_y(~esObjeto) = [];
                ubicacion_x(~esObjeto) = [];

                
                pila = [pila; [ubicacion_x ubicacion_y]]; %Guarda las ubicaciones con valor 1 en la pila
            end

            
            etiqueta = etiqueta + 1;% aumenta la el valor de la etiqueta 
        end
    end 
 end   
for k = 1:etiqueta % Recorre todas las etiquetas 
    Red = 255*rand; %Genera un nivel de rojo aleatorio 
    Blue = 255*rand; %Genera un nivel de azul aleatorio 
    Green = 255*rand; % %Genera un nivel de verde aleatorio 
    for i = 2 : fil-1
        for j = 2 : col-1
            if B(i,j) == k %Asigna los niveles aletarios a aquellos piexeles con la etiqueta correspondiente
                imagaSalida(i,j,1) = Red; 
                imagaSalida(i,j,2) = Blue; 
                imagaSalida(i,j,3) = Green; 
            end
        end
    end
end
subplot(2,2,1);
imshow(imag), title('Imágen Original'); %Imágen Original
subplot(2,2,2);
imshow(binarizada), title('Imagen umbralizada'); %Imagen umbralizada
subplot(2,2,3);
imshow(uint8(imagaSalida)), title('Imagen etiquetada'); %Imagen umbralizada
NumObje = etiqueta-1;
fprintf('El numero de elementos es %i \n', NumObje)

function umbra = umbral(imag,nivel)
%{
Esta función toma una imagen la convierte a niveles de gris y compara pixel
por pixel si el nivel es superior que un nivel de interes introducido por
el usuario, en cas de serlo le asigna el valor maximo de nivel de gris en
caso comtrario le asgina del valor minimo.
%}
gris = colorgris(imag);
umbra = gris;
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

%Se muestran las imagenes 

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