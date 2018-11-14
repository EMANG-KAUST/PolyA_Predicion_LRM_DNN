function [accuracy,sensitivity,specificity,precision,gmean,f1score,C]=prediction_performance(ytrue, yfit)


C=confusionmat(ytrue, yfit);

sensitivity = C(2,2)/(C(2,1)+C(2,2))*100;
specificity = C(1,1)/(C(1,1)+C(1,2))*100;
precision = (C(2,2)/(C(2,2)+C(1,2)))*100;
accuracy= (C(1,1)+C(2,2))/(C(1,1)+C(1,2)+C(2,1)+C(2,2))*100;
gmean = (sqrt(sensitivity*specificity));
f1score = (2*((precision*sensitivity)/(precision+sensitivity)));
