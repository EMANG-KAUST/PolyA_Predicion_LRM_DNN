# PolyA_Predicion_LRM_DNN
# PolyA_Predicion_LRM_DNN

PolyA Prediction using Logistic Regression Model (LRM) and Deep Neural Networks (DNN)

PolyA_Predicion_LRM_DNN is a novel method for predicting poly(A) signal (PAS) in human genomic DNA. It first utilizes signal processing transforms (Fourier-based and wavelet-based), statistics and position weight matrix PWM to generate sets of features that can help the poly(A) prediction problem to perform better due to the different aspects that these features offer. Then, it uses deep neural networks DNN and Logistic Regression Model (LRM) to distinguish between true PAS and pseudo PAS efficiently.  

This repository contains scripts which were used to generate three sets of features, namely: signal processing-based, statistics-based and PWM-based features. Then, we use these features to train and then test the DNN and LRM models.


Scripts

The scripts should be executed in the following order: 

First: The script “Generate_the_features.m” should be executed first to generate the training and testing sets of features that will be used later to build the DNN and LRM models. 

Second: The script “Run_LRM.m” will build the LRM model by using the generated training and testing features from the “Generate_the_features.m” script.   

Third: The script “Run_DNN.py” will build the DNN model by using the generated training and testing features from the “Generate_the_features.m” script. 


Dataset

You can use human genome hg38 from GENCODE folder at EBI ftp server
(ftp://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_28/GRCh38.primary_assembly.genome.fa.gz)
For GENCODE annotation, you can use
(ftp://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_28/gencode.v28.polyAs.gff3.gz) 

Citation

If you use “PolyA_Predicion_LRM_DNN” for your research, or incorporate our learning algorithms in your work, please cite:

F. Albalawi, A. Chahid, X. Guo, S. Albaradei, A. Magana-Mora, B. R. Jankovic, M. Uludag1, C. V. Neste1, M. Essack1, T.M. Laleg-Kirati1, V. B. Bajic, “Efficient prediction of Poly(A) motifs human genomic DNA”. Methods. 2018. 



  
