%Jeffa Triana Putra/13221007
%Proses analisis

%Membaca file audio awal
[audio_ori, fs]=audioread('P2_ORI_EL3010_13221007.wav');

s=audio_ori; %Menyimpan audio pada variabel s

%Prediksi Koefisien LPC
orde_lpc=2 ;
ak=lpc(s, orde_lpc); %Koefisien LPC