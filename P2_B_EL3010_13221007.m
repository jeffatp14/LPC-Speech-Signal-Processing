%Jeffa Triana Putra/13221007
%Proses Sintesis

[audio_ori, fs]=audioread('P2_ORI_EL3010_13221007.wav');

s=audio_ori; %Menyimpan audio pada variabel s

%Substitusi koefisien prediksi untuk rekonstruksi sinyal
ak=[1,-1.72189794806953,0.732151711217480;1,-1.72189794806953,0.732151711217480];

%Rekonstruksi sinyal
rekon_s=filter([0 -ak(2:end)], 1, s);

% Menghitung error
lpc_error = s - rekon_s;

% Menyimpan error LPC ke file
recon_file = 'P2_RECON_EL3010_13221007.wav';
audiowrite(recon_file, rekon_s, fs);

% Menyimpan error LPC ke file
error_file = 'P2_ERROR_EL3010_13221007.wav';
audiowrite(error_file, lpc_error, fs);

% Plot sinyal original, prediksi, dan error LPC
figure;
subplot(3,1,1);
plot(s);
title('Sinyal Asli');
xlabel('Sample Number');
ylabel('Amplitude');

subplot(3,1,2);
plot(rekon_s);
title('Sinyal Rekonstruksi LPC');
xlabel('Sample Number');
ylabel('Amplitude');

subplot(3,1,3);
plot(lpc_error);
title('LPC error');
xlabel('Sample Number');
ylabel('Amplitude');

% Menghitung power density spektrum
window = 1024;
overlap = 512;

[ori_psd, f] = pwelch(s, window, overlap, window, fs);
[rekonstruksi_psd, ~] = pwelch(rekon_s, window, overlap, window, fs);
[error_psd, ~] = pwelch(lpc_error, window, overlap, window, fs);

% Plot PSD
figure;
subplot(3,1,1);
plot(f, 10*log10(ori_psd));
title('Power Density Spectrum - Sinyal Asli');
xlabel('Frequency (Hz)');
ylabel('Power/Frequency (dB/Hz)');

subplot(3,1,2);
plot(f, 10*log10(rekonstruksi_psd));
title('Power Density Spectrum - Sinyal Rekonstruksil');
xlabel('Frequency (Hz)');
ylabel('Power/Frequency (dB/Hz)');

subplot(3,1,3);
plot(f, 10*log10(error_psd));
title('Power Density Spectrum - LPC Error');
xlabel('Frequency (Hz)');
ylabel('Power/Frequency (dB/Hz)');


% Analisis performa sinyal rekonstruksi
% Menghitung FoM (Figure of Merit)
FoM = sum(abs(s).^2) / sum(abs(lpc_error).^2);

% Menghitung SNR (Signal-to-Noise Ratio)
SNR = 10 * log10(sum(abs(s).^2) / sum(abs(lpc_error).^2));

disp(['Figure of Merit (FoM): ', num2str(FoM)]);
disp(['Signal-to-Noise Ratio (SNR): ', num2str(SNR), ' dB']);