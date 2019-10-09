function out = comp_pc_rt_trial(data,trial,currentCondition)
%function out = comp_pc_rt(data,trial,currentCondition)
%
%simple function to filter RT and comupute mean. written to make feedback.m simpler to read
%
%5/19/05        swe     written for set switching/reg focus exp
%10/16/06   swe     modified for split-brain study; computes avg RT (after removing outliers for correct trials) and avg PC for each visual field
%                   returns 2 data (RT and PC) x 2 VF (LVF and RVF) matrix
%5/23/07    swe     modified for new button switch experiment (from splitCatExp_2rule_osxPT3_v2.m and button_switch_nr.m)
%4/17/12    swe     modified to provide end of block fb for inference training
%
save temp4.mat
out = 9999*ones(4,1);
%d=data.MyData(trial-data.trialsPerBlock+1:trial,:); %extract last data.trialsPerBlock trials
d=data.MyData(); %extract last data.trialsPerBlock trials

%RT: filtered by corret and rt_cutoff
if currentCondition==1 || currentCondition==2
    ind = find(d(:,data.rt_col)<data.rt_cutoff & d(:,data.fb_col)==1); 
else
    ind = find(d(:,data.rt_col)<data.rt_cutoff); 
end
out(1) = mean(d(ind,data.rt_col)) ; 
if length(ind)==0; out(1,1) = data.rt_cutoff; end; %set avg RT to RTcutoff if all responses are slow


%PC
if currentCondition==1 || currentCondition==2
    %ind = find(d(:,data.fb_col)==0 | d(:,data.fb_col)==1); 
    ind = [1:trial-1];
    ind2 = find(d(ind,data.fb_col)==0 | d(ind,data.fb_col)==1);
    out(2) = 100*mean(d(ind2,data.fb_col)); 
end

%rmse on length and orient for inference training
% if currentCondition==2
%     %infer diameter ==> 1 line, 1 circle to produce
%     ind = find(d(:,data.inferDimensionCol)==11);
%     out(3) = (mean((d(ind,data.diameter_responseCol) - d(ind,data.diameterCol)).^2))^.5;
%     %infer OR ==> 1 circle, 1 line to produce
%     ind = find(d(:,data.inferDimensionCol)==22);
%     out(4) = (mean((d(ind,data.orient_responseCol) - d(ind,data.orientCol)*180/data.o_gain).^2))^.5;
% end
