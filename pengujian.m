clc; clear; close all; warning of all;

%%% matang
% membaca file citra
nama_folder = 'data uji/matang';
nama_file = dir(fullfile(nama_folder,'*.jpg'));
jumlah_file = numel(nama_file);

% menginisialisasi variabel ciri_matang dan target_matang
ciri_matang = zeros(jumlah_file,3);
target_matang = cell(jumlah_file,1);

% melakukan pengolahan citra terhadap seluruh file
for n = 1:jumlah_file
    Img = im2double(imread(fullfile(nama_folder,nama_file(n).name)));
   
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
   ciri_matang(n,1) = Red;
   ciri_matang(n,2) = Green;
   ciri_matang(n,3) = Blue;
   target_matang{n} = 'matang';
    
end

%%% mentah
% membaca file citra
nama_folder = 'data uji/mentah';
nama_file = dir(fullfile(nama_folder,'*.jpg'));
jumlah_file = numel(nama_file);

% menginisialisasi variabel ciri_matang dan target_matang
ciri_mentah = zeros(jumlah_file,3);
target_mentah = cell(jumlah_file,1);

% melakukan pengolahan citra terhadap seluruh file
for n = 1:jumlah_file
    Img = im2double(imread(fullfile(nama_folder,nama_file(n).name)));
   
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
   ciri_mentah(n,1) = Red;
   ciri_mentah(n,2) = Green;
   ciri_mentah(n,3) = Blue;
   target_mentah{n} = 'mentah';
    
end

ciri_uji = [ciri_matang;ciri_mentah];
target_uji = [target_matang;target_mentah];

% memanggil mode k-nn hasil pelatihan
load Mdl

% membaca kelas keluaran hasil pengujian
hasil_uji = predict(Mdl,ciri_uji);
% menghitung akurasi pengujian
jumlah_benar = 0;
jumlah_data = size(ciri_uji,1);
for k = 1:jumlah_data
    if isequal(hasil_uji{k},target_uji{k})
        jumlah_benar = jumlah_benar+1;
    end
end

akurasi_pengujian = jumlah_benar/jumlah_data*100
