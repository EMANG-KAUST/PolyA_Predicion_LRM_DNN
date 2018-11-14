Run Main.m

This txt file describes the tasks of the functions appear in the main file. 



read_DNA_Sequences.m is used to transform the DNA sequences into 
three numerical sequences using three different mappings.

  
Shuffle_data.m is used to randomly resample the three numerical sequences via the built in function in Matlab "randperm function" 	                           


generate_wavelet_features.m is used to generate the wavelet-based features (8 features in total). 



generate_fre_features.m is used to create the 4 frequency-based features and 3 statical-based features (7 feature in total). 


Generate_pattern.m is used to generate the Mono-DNA patterns to be used as inputs for creating the mono-Position Weight Matrices


cat.m is used to concatenate either the training positive pattern together in one matrix or the negative ones. 


General_PWM_matrices_generatures3D.m is used to create the position weight matrix using only training samples. This function is used to create the mono position weight matrices, di position matrices and the tri position weight matrices. 


Apply_General_PWM_feature_generator.m is used to generate the mono-mer PWM-based features (8 features in total), di-mer PWM-based features (32 features in total) or tri-mer PWM-based features (128 features in total) for either the training data or the testing data using the corrsponding constructed PWM matrices. 


Extract_Miers2.m is used to generate the di-binary patterns extracted from the DNA sequences.
   

Extract_Miers3.m is used to generate the tri-binary patterns extracted from the DNA seqeunces.
   
EIIP_feature_generator.m is used to create the EIIP statistical-based features such as the mean, median and the standard deviation of the EIIP sequence ( 9 features in total). 


counting_feature_generator.m is used to generate the remaining statistical-based features which are counting the most discriminative mono and di nucleotides appear in the positive and negative poly(A) samples (13 features in total).

 
Run_Cross_Validation_of_features.m is used to run 10-fold cross vlaidation and extract the optimal model out of these 10 models.

Test_LR.m is used to apply the extracted optimal model out of these 10 models to the testing data and compute the performance meastues such as accuracy and sensitivity. 

  