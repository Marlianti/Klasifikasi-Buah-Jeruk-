clc; clear; close all; warning off all;

[nama_file,nama_folder] = uigetfile('*.jpg');

if ~isequal(nama_file,0)
     Img = im2double(imread(fullfile(nama_folder,nama_file)));
   
    Img_gray = rgb2gray(Img);
   % figure, imshow(Img)
   % figure, imshow(Img_gray)
    
    bw = imbinarize(Img_gray,.9);
   % figure, imshow(bw)    
    bw = imcomplement(bw);
   % figure, imshow(bw)    
    bw = imfill(bw,'holes');
   % figure, imshow(bw)
    bw = bwareaopen(bw,100);
   % figure, imshow(bw)
   R = Img(:,:,1);
   G = Img(:,:,2);
   B = Img(:,:,3);
   R(~bw) = 0;
   G(~bw) = 0;
   B(~bw) = 0;
   RGB = cat(3,R,G,B);
   %figure, imshow(RGB)
   Red = sum(sum(R))/sum(sum(bw));
   Green = sum(sum(G))/sum(sum(bw));
   Blue = sum(sum(B))/sum(sum(bw));
   
   ciri_uji = [Red,Green,Blue];
   % memanggil mode k-nn hasil pelatihan
   load Mdl

   % membaca kelas keluaran hasil pengujian
   hasil_uji = predict(Mdl,ciri_uji);
   
   figure, imshow(Img)
   title({['Nama File: ',nama_file],['Kelas Keluaran: ',hasil_uji{1}]})
else
    return
end
