 ######################### DNN Model Using Python ##########################
#  Author:  Somayah.Albaradei@kaust.edu.sa
   
#  Advicor : vladimir.bajic@kaust.edu.sa 
  
   
# Done: May, 2018

 
# Description
# This script applys the trained DNN models using the extracted features from generating_the_features.m

###############################################################################

import numpy as np 
import scipy.io as sio
from sklearn.externals import joblib
from keras.models import load_model
from sklearn.metrics import confusion_matrix
from sklearn.preprocessing import  RobustScaler


path='DNNmodels/' 
#Step1 

#############################################################
# write the PAS you want 'CATAAA', 'AATACA',
# 'AATATA', 'GATAAA', 'AAGAAA', 'TATAAA', 
#'AGTAAA', ACTAAA, 'AAAAAG','AATAGA','ATTAAA','AATAAA'

motif='ATTAAA'

##############################################################

#Step 2 convert mat to numpy and extract features as X_test and labels as y_test

mat=motif+'_features.mat'
mat_contents = sio.loadmat(mat)
mat_FEATURE = mat_contents['features_TS']
npdata=np.array(mat_FEATURE)
X_test= npdata[:,:-1]
y_test= npdata[:,205]






#Step 3 load and apply scaler

scaler_filename = path+motif+"_scaler.save"
scaler = joblib.load(scaler_filename) 
X_test=scaler.transform(X_test)


#Step 4 load and applly DL model

model_name=path+motif+'_model'
model = load_model(model_name)
y_pred = model.predict(X_test)

#Step 5 Evalute 

y_pred = [ 1 if y>=0.50 else 0 for y in y_pred ]
tn, fp, fn, tp= confusion_matrix(y_test, y_pred).ravel()
accuracy=(tp+tn)/(tn+tp+fn+fp)
print ('Accuracy : ' + str(accuracy*100)+"%")
sensitivity = tp/(tp+fn)
print('Sensitivity : '+ str(sensitivity*100)+"%")
specificity = tn/(tn+fp)
print('Specificity : '+ str(specificity*100)+"%")

