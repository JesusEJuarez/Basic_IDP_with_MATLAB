%{
--------------------Filtro Sobel-----------------------------
%}
% Lee la imagen
ima = imread('./img/flor.jpeg');
% Cambia la imagen a gris 
gris = colorgris(ima);
Hh = filtroSobel(gris,1);
Hv = filtroSobel(gris,2);
imaMod = Hh +Hv;

subplot(2,2,1);%Abre una nueva ventana de figura
imshow(gris), title('Imágen  en Grises'); %Imágen en grises
subplot(2,2,2);
imshow(Hh), title('Imágen con el operador Hh');%Imágen con operador Hh
subplot(2,2,3)
imshow(Hv), title('Imágen con el operador Hv'); %Imágen con operador Hv
subplot(2,2,4)
imshow(imaMod), title('Imagen con filtro Sobel');%Imágen filtrada 


function filtrado = filtroSobel(ima,operador)
%{
Esta función toma una imagen en niveles de gris y un numero para selecionar el operador 
 1 para Hh y 2 para Hv
%}
% switch es para seleccionar el operador 
switch operador
    case 1
        %Operador Hh
sobel = [1,0,-1;
         2,0,-2
         1,0,-1];
    case 2
         %Operador Hv

sobel = [-1,-2,-1;
          0,0,0,
          1,2,1];
   
    otherwise
        %Marca error en caso de que no sea un numero del 1 al 2
        disp('Solo numeros 1 al 2')
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
             filtrado(i,j) = double(filtrado(i,j)+matriz(k,m)*sobel(k,m));
            end
        end
    end
end
     
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