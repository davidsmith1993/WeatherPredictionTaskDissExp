function out = comp_pc_rt(data,trial, currentCondition)
%function out = comp_pc_rt(data,trial)
%
%simple function to filter RT and comupute mean. written to make feedback.m simpler to read
%
%5/19/05        swe     written for set switching/reg focus exp
%10/16/06   swe     modified for split-brain study; computes avg RT (after removing outliers for correct trials) and avg PC for each visual field
%                   returns 2 data (RT and PC) x 2 VF (LVF and RVF) matrix
%5/23/07    swe     modified for new button switch experiment (from splitCatExp_2rule_osxPT3_v2.m and button_switch_nr.m)
%
out = zeros(2,1);
d=data.MyData(trial-data.trialsPerBlock+1:trial,:); %extract last data.trialsPerBlock trials

%RT: filtered by corret and rt_cutoff
ind = find(d(:,data.rt_col)<data.rt_cutoff & d(:,data.fb_col)==1); 
out(1) = mean(d(ind,data.rt_col)) ; 
if length(ind)==0; out(1,1) = data.rt_cutoff; end; %set avg RT to RTcutoff if all responses are slow


%PC
ind = find(d(:,data.fb_col)<=1); 
out(2) = 100*mean(d(ind,data.fb_col)); 

