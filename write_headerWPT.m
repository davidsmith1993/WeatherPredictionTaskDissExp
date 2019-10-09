function write_headerWPT(data,stim,time,where)
save temp.mat;
disp('write_header_')
%function write_header(data,stim,time,where)
%
%writes header file for pd_wp_vs_ii experiment 
%
%10/16/06   swe     modified for split-brain study, no longer unpack structres b/c inefficient
%5/23/07    swe     modified for new button switch experiment (from splitCatExp_2rule_osxPT3_v2.m and button_switch_nr.m)
%4/22/08    swe     modified button_exp.m (i.e., button switch labels on screen vs. labels on keys) for relational learning experiment (relational_exp.m)
%7/20/2010  swe     modified relationa_bonus.m for focalBG - wm experiment to be run @ Berkeley on PC
%3/10/17    swe     modified for online stressor experiment Spring 2017

% Create header file - i love redundancy
cd data
date_str = date;
fid = fopen([data.outname '.hdr'],'w');
fprintf(fid,'filename = %s \n',data.outname);
fprintf(fid,'date = %s \n\n',date_str);
save temp.mat;
disp('write_header__2');
fprintf(fid,'\nCONDITION INFORMATION:\n');
fprintf(fid,'Subject Number = %i \n',data.sub);
%fprintf(fid,'Task = %s\n', data.categoryStructureText);
%fprintf(fid,'Type of Trier = %s\n', data.trierTypeText);
fprintf(fid,'Gender = %s\n', data.genderText);
%fprintf(fid,'Age= %i \n',data.age);
save temp.mat;disp('write_header__3');
fprintf(fid,'\nTIMING VARIABLES (in seconds):\n');
fprintf(fid,'fixation duration = %6.3f \n',time.fixTime);
fprintf(fid,'stimulus duration = %6.3f \n',time.stimDuration);
fprintf(fid,'Subject must respond within = %6.3f \n',time.responseDeadline);
fprintf(fid,'fb duration = %6.3f \n',time.fbDuration);
fprintf(fid,'ITI = %6.3f \n',time.ITI);
fprintf(fid,'Experiment began = % g % g % g % g % g % g \n',time.experiment_begin);
fprintf(fid,'Experiment duration (minutes) = %6.3f \n',(time.now-time.starttime)/60);
save temp.mat;disp('write_header__4');
fprintf(fid,'\nPOSITION VARIABLES:\n');
fprintf(fid,'Assumed distance between subject and monitor = %f \n',where.viewing_distance);

% fprintf(fid,'\nSTIMULUS VARIABLES:\n');
% fprintf(fid,'Stimulus: gratings varying in spatial frequency (arbitrary) and angle (arbitrary). \n');
% fprintf(fid,'     Converted to cycles/degree (ultimately cycles/image) and degrees from horizontal. \n');
% fprintf(fid,'Orientation scaling factors:\n');
% fprintf(fid,'%6.2f\n',data.o_gain);
% fprintf(fid,'orientation scaling: scaled_or = data.o_gain(1)+data.o_gain(2)*arbitrary_or; %DEGREES FROM HORIZONTAL  -- see genGratings_single.m. \n');
% fprintf(fid,'Visual angle = %f \n',data.visual_angle_of_array);
% fprintf(fid,'Spatial frequency scaling factors:\n');
% fprintf(fid,'%6.2f\n',data.sf_gain);
% fprintf(fid,'spatial frequency scaling: scaled_sf = data.sf_gain(1)+data.sf_gain(2)*arbitrary_sf; %CYCLES/DEGREE)  -- see genGratings_single.m. \n');
% save temp.mat;disp('write_header__45');

fprintf(fid,'\nRESPONSE VARIABLES:\n');
fprintf(fid,'If the category-keyboard mapping = 1 (i.e., using right hand), n=Sun, j=Rain\n');
fprintf(fid,'If the category-keyboard mapping = 2 (i.e., using left hand), v=Sun, f=Rain\n');
fprintf(fid,'Category-keyboard mapping = %s \n',data.catKeyMapping_text);

fprintf(fid,'\nOTHER VARIABLES:\n');
fprintf(fid,'number of training blocks = %i \n',data.numBlocks);
fprintf(fid,'Trials per block = %i \n',data.trialsPerBlock);
fprintf(fid,'Total number of trials = %i \n',data.numTrials);
fprintf(fid,'Monitor size = %s \n',data.monitor_text);
fprintf(fid,'Monitor resolution = %s \n',data.monitor_res_text);

save temp.mat;disp('write_header__46');
fprintf(fid,'\nPercent correct by block :\n');
fprintf(fid,'%6.2f\n',data.block_pc(:,1)');
	
fprintf(fid,'\nRT (in ms) by block (includes correct trials with RT < data.rt_cutoff):\n');
fprintf(fid,'%6.2f\n',data.block_rt(:,1)');
fprintf(fid,'RT cutoff used to compute avg RT = %f \n',data.rt_cutoff);


fprintf(fid,'\n\nDATA FILE FORMAT:\n');
fprintf(fid,'     columns are [cat, un-scaled_sf, un-scaled_orient, resp, RT, index (for stimulus lookup table), fb, trialWithinExperiment, trialWithinBlock, block] ; \n');
fprintf(fid,'     rows of data file are trials\n');
fprintf(fid,'\n\n Questionnaire DATA FILE FORMAT (filename appended with "_Q") :\n');
fprintf(fid,'     columns are questions with number of total questions = data.num_preAppraisal+data.num_manipulationCheck+data.num_postAppraisal ; \n');
fprintf(fid,'     rows are: [data.sub data.cs data.trierTiming data.trierType question resp rt]\n');
fclose(fid);
save temp.mat;disp('write_header__8');
cd ..


save temp.mat;disp('write_header__end');
