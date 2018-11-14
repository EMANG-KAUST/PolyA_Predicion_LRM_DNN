contP_A = 0;
contP_G = 0;
contP_C = 0;
contP_T = 0;
    for j = 1:606
    if current_EIIP(i,j) == 0.126;
        contP_A = contP_A + 1;
    elseif current_EIIP(i,j) == 0.0806;
        contP_G = contP_G + 1;
    elseif current_EIIP(i,j) == 0.134;
        contP_C = contP_C + 1;
    else
        contP_T = contP_T + 1;
    end
    end
