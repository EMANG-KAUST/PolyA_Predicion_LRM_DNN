function    [pos_EIIP_TR_all, neg_EIIP_TR_all]=build_dirac_patern(pos_EIIP_TR0, neg_EIIP_TR0,Cut_Seq)
En_wind=0;
Cut_Val=1;
pos_EIIP_TR_all=extruct_pattern_Necliotide(pos_EIIP_TR0, Cut_Seq, Cut_Val,En_wind);
neg_EIIP_TR_all=extruct_pattern_Necliotide(neg_EIIP_TR0, Cut_Seq, Cut_Val,En_wind);
