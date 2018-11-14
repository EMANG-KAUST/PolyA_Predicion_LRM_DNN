function wavelet_features = DBWaveletFeature(x)
%% this is to test the wavelet feature extraction
% x is the current EIIP signal

% wavelet_features is a matrix that contains the features generated from wavelet analysis

[wpt,packetlevs,cfreq,energy,relenergy] = modwpt(x,3,'db3');
wavelet_features(1) = energy(1);
wavelet_features(2) = energy(2);
wavelet_features(3) = energy(3);
wavelet_features(4) = energy(4);
wavelet_features(5) = energy(5);
wavelet_features(6) = energy(6);
wavelet_features(7) = energy(7);
wavelet_features(8) = energy(8);

end

