function [EIIP_pos,EIIP_neg,ESD_pos,ESD_neg,wavelet_pos,wavelet_neg]=shuffle_wave_eiip_esd(oEIIP_pos,oEIIP_neg,oESD_pos,oESD_neg,owavelet_pos,owavelet_neg)
% Input : original dataset of EIIP, ESD, wavelet features
% Output : reordered data

%% Shuffle the data
[M, N]=size(oEIIP_pos);
shuffle_p=randi(M,[1 M]);
EIIP_pos=oEIIP_pos(shuffle_p,:);
EIIP_neg=oEIIP_neg(shuffle_p,:);
ESD_pos = oESD_pos(shuffle_p,:);
ESD_neg = oESD_neg(shuffle_p,:);
wavelet_pos = owavelet_pos(shuffle_p,:);
wavelet_neg = owavelet_neg(shuffle_p,:);

end
