%% ######################### Features Generation ##########################
 % Authors:  
    % Fahad Albalawi:     fahad.albalawi@kaust.edu.sa 
    % Abderrazak Chahid : abderrazak.chahid@kaust.edu.sa 
    % Xingang Guo:        xingang.guo@kaust.edu.sa  
 % Advicor : 
   % Professor Taous_Meriem Laleg . EMANGroup KAUST  Email: taousmeriem.laleg@kaust.edu.sa 
   
% Done: May, 2018

 
 %% Description
% This script generates signal processing-based features and other type of
% features 
% The code is divided as follows: 
% THE FIRST PART resample the data first and then split them into
% training and testing data

% THE SECOND PART generates all type of features for both the training and
% testing data
% Note that :
% all features are independent in the sense that they do not
% depend on any type of information when they are created except the
% position weight matrix-based features where they need PWM matrix to be 
% used to create the features. For that reason, we only build the position
% weigh matrix based on only the training data.
%% ###############################################################################

clear all;close all;warning('off','all');addpath ./Functions; Include_function;

fprintf('______________________________________________________________________________\n');
fprintf('  Signal processing, Statictics, PWM-based Feature generation  (KAUST 2018)\n');
fprintf('______________________________________________________________________________\n\n');


global Ratio_PWM  % Ratio_PWM is the proportion of the size of the training data used 
                  % to construct the PWM matrices 
                  
%% Inputs 
    % folder where thefeatures will be saved    
    root_folder ='./FEATURES/';       

    % Load the DNA Mapping
    file_p = './Input_data/ATTAAA_pos.fa';
    file_n = './Input_data/ATTAAA_neg.fa';

%% --------------------- Features Generation   ----------------------------
Ratio_PWM = 1;       
% The three DNA-Mapping

EIIP_map = [0.126 0.134 0.0806 0.1335]; %[A C G T] 
quar_map = [0.25 0.5 0.75 1]; %[A C G T]
nuceltide_mapping = [1 2 3 4]; %[A C G T]

% The following functions perform the DNA mapping using three
% different mapping where one of them is built in matlab
% by a function called "nt2int"

[Patern_pos, EIIP_pos,quar_pos] = read_DNA_Sequences(file_p,EIIP_map,quar_map); 
[Patern_neg,EIIP_neg,quar_neg] = read_DNA_Sequences(file_n,EIIP_map,quar_map);

%% TASK 2                 
% Resampling the three mapped-DNA sequences using the function below

[EIIP_pos,quar_pos,Patern_pos] = Shuffle_data(EIIP_pos,quar_pos,Patern_pos);
[EIIP_neg,quar_neg,Patern_neg] = Shuffle_data(EIIP_neg,quar_neg,Patern_neg);
        
%% Task 3
[Mp, Np] = size(EIIP_pos);
[Mn, Nn] = size(EIIP_neg);

Mmin = min(Mp,Mn); % Since the data are unbalanced we need only to 
                 % take the size of the minumum data size of either 
                 % the positive or the negative sequneces to make
                 % the training and testing data balanced
                 
% Splitting the data to training and test data
           
TR = floor(0.8*Mmin); % TR represents the size of the trainign data

% Dividing the positive and negative EIIP-sequnces into training (TR_EIIP)
% testing (TS_EIIP and TSS_EIIP)

 TR_EIIP_pos = EIIP_pos(1:TR,:);    
 TR_EIIP_neg = EIIP_neg(1:TR,:);
 
 TS_EIIP_pos = EIIP_pos(TR+1:Mmin,:);  
 TS_EIIP_neg = EIIP_neg(TR+1:Mmin,:);

 % Dividing the positive and negative patern-sequnces into 
 % training (TR_patern) and testing (TS_patern and TSS_patern) 

 TR_Patern_pos = Patern_pos(1:TR,:);       
 TR_Patern_neg = Patern_neg(1:TR,:);
 
 TS_Patern_pos = Patern_pos(TR+1:Mmin,:);  
 TS_Patern_neg = Patern_neg(TR+1:Mmin,:);
     
% constructing the target vector for the training and testing data
% so that this vector will be concantainating with other features

 [Mp, Np] = size(TR_EIIP_pos); 
 pos_target = ones([Mp,1]);
 [Mn, Nn] = size(TR_EIIP_neg); 
 neg_target = zeros([Mn,1]);
 TR_Target_bit = [pos_target;neg_target];
 
 [Mp, Np] = size(TS_EIIP_pos);
 pos_target = ones([Mp,1]);
 [Mn, Nn] = size(TS_EIIP_neg);
 neg_target = zeros([Mn,1]);
 TS_Target_bit = [pos_target;neg_target];
 
 %% THE SECOND PART OF THE CODE GENERATES 7 FEATURES
 
if exist(root_folder) == 0
      mkdir(root_folder)
end      
     
%% FEATURE 1: Generating the Wavelet Features   
[Wavelet_pos,Wavelet_neg]  =  generate_wavelet_features(quar_pos,quar_neg);
 
% The first 80% are the training features 
TR_Wavelet_features_pos = Wavelet_pos(1:TR,:);       
TR_Wavelet_features_neg = Wavelet_neg(1:TR,:);

% The remaining 20% are the testing features
TS_Wavelet_features_pos = Wavelet_pos(TR+1:Mmin,:);  
TS_Wavelet_features_neg = Wavelet_neg(TR+1:Mmin,:);

% Taking the same positive testing features with new negative features

     
% Concatenating the positive and the negative wavelet features together            
Wavelet_features_TR = [TR_Wavelet_features_pos;TR_Wavelet_features_neg];
Wavelet_features_TS = [TS_Wavelet_features_pos;TS_Wavelet_features_neg];
     
     
% saving the derived features in a file 
%save(strcat(root_folder,'Wavelet_based_Features.mat'),'Wavelet*','TR_*','TS_*')
fprintf(' Wavelet features are generated\n'); 
        
 %% FEATURE 2: Generating the Frequency-Based Features
 [fre_feature_pos,fre_feature_neg]  =  generate_fre_features(quar_pos,quar_neg);
        
 % The first 80% are the training features                    
 TR_fre_feature_pos = fre_feature_pos(1:TR,:);       
 TR_fre_feature_neg = fre_feature_neg(1:TR,:);
 
 % The remaining 20% are the testing features
 TS_fre_feature_pos = fre_feature_pos(TR+1:Mmin,:);  
 TS_fre_feature_neg = fre_feature_neg(TR+1:Mmin,:);
 
 % Taking the same positive testing features with new negative features

     
 % Concatenating the positive and the negative frequency features together           
 fre_feature_TR = [TR_fre_feature_pos;TR_fre_feature_neg];
 fre_feature_TS = [TS_fre_feature_pos;TS_fre_feature_neg];

  
% saving the derived features in a file 
 %save(strcat(root_folder,'fre_feature.mat'),'fre*','TR_*','TS_*')
 fprintf(' Fourier features are generated\n'); 

%% FEATURE 3: Single-Mer Position Weight Matrix-BASED FEATURES

% Generating the Mono-DNA patterns to be used as input for the Position
% Weight Matrices and the single nucletide PWM-based features 

% the following varaibles are used as inputs to generate the mono pattern
% A_th = 7;
% T_th = 2.5;
% C_th = 3;
% G_th = 3.2;
% Th_Seq = [A_th,T_th,C_th,G_th];
Name_Seq = {'A','T','C','G'};


% Generating Mono-DNA patterns for training data
 [ P_featuresA_TR, P_featuresC_TR, P_featuresG_TR, P_featuresT_TR] = Generate_pattern(TR_EIIP_pos, TR_EIIP_neg, EIIP_map, Name_Seq);

% Generating Mono-DNA patterns for testing data 
 [ P_featuresA_TS, P_featuresC_TS, P_featuresG_TS, P_featuresT_TS] = Generate_pattern(TS_EIIP_pos, TS_EIIP_neg, EIIP_map, Name_Seq);

% saving the Mono-DNA patterns in a file
%save(strcat(root_folder,'Pattern_based_Features.mat'),'Name_Seq','Patern_*','P_*','TR_*','TS_*')


% Generating the mononucleotide PWM-based features using the above 
% Mono-DNA patterns 


% Generating the single-Mer PWM matrices in 3 steps

% step 1: creating the training input sequences for the PWM construction

hf = 1;
Mer1_Seq_pos_TR = cat(3,CF_T(P_featuresA_TR,hf), CF_T(P_featuresC_TR,hf),CF_T(P_featuresG_TR,hf), CF_T(P_featuresT_TR,hf));     

hf = 2;
Mer1_Seq_neg_TR = cat(3,CF_T(P_featuresA_TR,hf), CF_T(P_featuresC_TR,hf),CF_T(P_featuresG_TR,hf), CF_T(P_featuresT_TR,hf));     

%step 2: creating position weight matrix using the above training sequences 
[PWMp_Mer1,PWMn_Mer1] = General_PWM_matrices_generatures3D(Mer1_Seq_pos_TR,Mer1_Seq_neg_TR);

% step 3: Scanning the training sequences on the derived PWM matrices
Mer1_PWM_features_TR = Apply_General_PWM_feature_generator(Mer1_Seq_pos_TR,Mer1_Seq_neg_TR, PWMp_Mer1, PWMn_Mer1); 

% Generating the sngle-mer based features using the above PWm matrices 
% Note here that we are using the PWM derived from only the training data

hf = 1;
Mer1_Seq_pos_TS = cat(3,CF_T(P_featuresA_TS,hf), CF_T(P_featuresC_TS,hf),CF_T(P_featuresG_TS,hf), CF_T(P_featuresT_TS,hf));      

hf = 2;
Mer1_Seq_neg_TS = cat(3,CF_T(P_featuresA_TS,hf), CF_T(P_featuresC_TS,hf),CF_T(P_featuresG_TS,hf), CF_T(P_featuresT_TS,hf));     
  
Mer1_PWM_features_TS = Apply_General_PWM_feature_generator(Mer1_Seq_pos_TS,Mer1_Seq_neg_TS, PWMp_Mer1, PWMn_Mer1); 
 
    
  
 

% saving the result in a file
%save(strcat(root_folder,'Mer1_based_Features.mat'),'PWM*','TR_*','TS_*','Patern_*','*Mer1','Mer1*')
fprintf(' Mono-nucleotides features are generated\n'); 


%% FEATURE 4: Dinucleotide Position Weight Matrix-BASED FEATURES
   
% Generating the Dinucleotide-position weight matrix

[name_Mer2, Mer2_Seq_pos_TR, Mer2_Seq_neg_TR] = Extract_Miers2(TR_Patern_pos, TR_Patern_neg);
[PWMp_Mer2,PWMn_Mer2] = General_PWM_matrices_generatures3D(Mer2_Seq_pos_TR,Mer2_Seq_neg_TR);

% Generating the di-mer based features for the training data using the 
% above derived PWM matrices 

Mer2_PWM_features_TR = Apply_General_PWM_feature_generator(Mer2_Seq_pos_TR,Mer2_Seq_neg_TR, PWMp_Mer2, PWMn_Mer2);

% Generating the di-mer based features for the testing data using the 
% PWM matrices derived only from the training data

[name_Mer2, Mer2_Seq_pos_TS, Mer2_Seq_neg_TS] = Extract_Miers2(TS_Patern_pos, TS_Patern_neg);

 Mer2_PWM_features_TS = Apply_General_PWM_feature_generator(Mer2_Seq_pos_TS,Mer2_Seq_neg_TS, PWMp_Mer2, PWMn_Mer2); 
                


% saving the result

%save(strcat(root_folder,'Mer2_based_Features.mat'),'PWM*','TR_*','TS_*','Patern_*','*Mer2','Mer2*')

fprintf(' Di-nucleotides features are generated\n'); 

%% FEATURE 5: 3-Mer Position Weight Matrix-BASED FEATURES

% Generating the 3-mer position weight matrix

[name_Mer3, Mer3_Seq_pos_TR, Mer3_Seq_neg_TR] = Extract_Miers3(TR_Patern_pos, TR_Patern_neg);
[PWMp_Mer3,PWMn_Mer3] = General_PWM_matrices_generatures3D(Mer3_Seq_pos_TR,Mer3_Seq_neg_TR);

% Generating the 3-mer based features for the training data using the 
% above derived PWM matrices 

Mer3_PWM_features_TR = Apply_General_PWM_feature_generator(Mer3_Seq_pos_TR,Mer3_Seq_neg_TR, PWMp_Mer3, PWMn_Mer3);

% Generating the 3-mer based features for the testing data using the 
% PWM matrices derived only from the training data 

[name_Mer3, Mer3_Seq_pos_TS, Mer3_Seq_neg_TS] = Extract_Miers3(TS_Patern_pos, TS_Patern_neg);

Mer3_PWM_features_TS = Apply_General_PWM_feature_generator(Mer3_Seq_pos_TS,Mer3_Seq_neg_TS, PWMp_Mer3, PWMn_Mer3); 
                
                

% saving the result in a file

%save(strcat(root_folder,'Mer3_based_Features.mat'),'PWM*','TR_*','TS_*','Patern_*','*Mer3','Mer3*')

fprintf(' Tri-nucleotides features are generated\n'); 

%% FEATURE 6: Generating the EIIP-based features

% generating the EIIP features for training data

[EIIP_features_TR, EIIP_features_TR_table] =  EIIP_feature_generator(TR_EIIP_pos,TR_EIIP_neg);

% generating the EIIP features for the two testing data set TS and TSS

[EIIP_features_TS, EIIP_features_TS_table] =  EIIP_feature_generator(TS_EIIP_pos,TS_EIIP_neg);
                

% saving the result in a file

%save(strcat(root_folder,'EIIP_based_Features.mat'),'EIIP_f*','TR_*','TS_*')

     
%% FEATURE 7: Generating the Mer Counting Features                
  
% generating the Mer counting features  for training data
[counting_features_TR,counting_features_TR_table] =  counting_feature_generator(TR_EIIP_pos,TR_EIIP_neg);

% generating the Mer counting features  for the two testing data set TS
% and TSS

[counting_features_TS,counting_features_TS_table] =  counting_feature_generator(TS_EIIP_pos,TS_EIIP_neg);


% saving the result in a file

%save(strcat(root_folder,'counting_based_Features.mat'),'counting*','TR_*','TS_*')

fprintf(' Statistics-based features are generated\n'); 

%% Concatenating Features 

% Concatenating  Training features in one single vector with the target included 
 features_TR =  [ NO_T(EIIP_features_TR), NO_T(fre_feature_TR), NO_T(counting_features_TR), ...
     NO_T(Wavelet_features_TR), NO_T(Mer1_PWM_features_TR), NO_T(Mer2_PWM_features_TR), Mer3_PWM_features_TR];
        
% Concatenating  Testing features in one single vector with the target included 
features_TS =  [ NO_T(EIIP_features_TS)       NO_T(fre_feature_TS) NO_T(counting_features_TS)    NO_T(Wavelet_features_TS) NO_T(Mer1_PWM_features_TS)  NO_T(Mer2_PWM_features_TS)  Mer3_PWM_features_TS];
        
% Concatenating  Testing features in one single vector with the target included 
save(strcat(root_folder,'Features.mat'),'features_TR','features_TS')      
fprintf('Feature generation is done successfully and save in : \n %s\n',root_folder);

