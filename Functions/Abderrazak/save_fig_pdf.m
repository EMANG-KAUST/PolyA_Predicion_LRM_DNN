%% Save figr figure in pdf and fig format 
%Results_path : path to save results
% figr  :  figrure number
% name  : file name to be saved

function save_fig_pdf(Results_path,figr,name)                  
Results_path=strcat(Results_path,'/');
if exist(Results_path)~=7
    mkdir(Results_path);
end

set(figure(figr),'units','normalized','outerposition',[0 0 1 1])

%% save . fig files           
saveas(figure(figr),strcat(Results_path,name,'.fig'))
% %% save . pdf files           
set(figure(figr),'PaperOrientation','landscape');
set(figure(figr),'PaperUnits','normalized');
set(figure(figr),'PaperPosition', [0 0 1 1]);
% print(figure(figr),strcat(Results_path,name,'.pdf'), '-dpdf', '-r300')
%% High resolution 
export_fig(strcat(Results_path,name,'.png'), '-png','-transparent');


end

