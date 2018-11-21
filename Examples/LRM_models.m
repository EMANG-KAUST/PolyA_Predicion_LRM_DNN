%% ######################### Features Generation ##########################
 % Authors:  
    % Fahad Albalawi:     fahad.albalawi@kaust.edu.sa 
    % Abderrazak Chahid : abderrazak.chahid@kaust.edu.sa 
    % Xingang Guo:        xingang.guo@kaust.edu.sa  
 % Advicor : 
   % Professor Taous_Meriem Laleg . EMANGroup KAUST  Email: taousmeriem.laleg@kaust.edu.sa 
   
% Done: May, 2018

 
 %% Description
% This script performs   cross validation and the testing stage of the
% optimal algorithm 

%% ###############################################################################

clear all;close all;warning('off','all');addpath ../Functions; Include_function;

fprintf('______________________________________________________________________________\n');
fprintf('               LRM based Cross validation  (KAUST 2018)\n');
fprintf('______________________________________________________________________________\n\n');

%% Choose the model 

%% #########################    Load data   ################################
ext = './Example/*_TS.mat';  
[filename rep]= uigetfile({ext}, 'File selector')  ;
chemin = fullfile(rep, ext);  list = dir(chemin);  
file_data=strcat(rep, filename)  ;
file_model=strcat('../LRMmodels/', strcat(filename(1:6),'_model.mat')) ;

load(file_model)
load(file_data)

          
%% TESTING The Optimal Model Obtained from 10-fold cross validation 
[accuracy_TS,sensitivity_TS,specificity_TS,precision_TS,gmean_TS,f1score_TS,ytrue_TS,yfit_TS,C_TS] = Test_LR(Mdl_optimal,features_TS);

size_Test = size(features_TS,1);

Result_TS = [size_Test,accuracy_TS,sensitivity_TS,specificity_TS,precision_TS,gmean_TS,f1score_TS];

fprintf('\n Performance : \n');

CV_Result=array2table(Result_TS,'VariableNames',{'TestSize','Accuracy','Sensitivity','Specificity','Precision','Gmean','F1score'})

