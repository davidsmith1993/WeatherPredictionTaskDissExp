function [resp,correct,rt,time,data] = getResponseWPT_clicks(window,sounds,feedback,color,where,stim,time,data,presExample,trial,trainTest,trialWithinBlock,blockNum, x, y)

%3/1/19    dbs      Get response for weather prediction task
%3/8/19    dbs      Get response with click, instead of button press

disp('checkgetreponse1'); save temp.mat

% keyIsDown=0; 
% while (keyIsDown==0); 
%     [keyIsDown,response,time.response] = check_key(keyIsDown);
%     if (GetSecs-time.stim_onset>time.responseDeadline); 
%         response = '='; 
%         time.response = GetSecs(); 
%         keyIsDown=99;
%         %break; 
%     end
% end %end while keyIsDown
% 

disp('checkgetreponse2'); save temp.mat


%function [resp,correct,rt,time,data] = getResponse(window,sounds,feedback,color,where,stim,time,data,presExample,trial,grating,trainTest,trialWithinBlock,blockNum)
%function [resp,correct,rt,time,data] = getResponse(window,sounds,feedback,color,where,stim,time,data,presExample,trial,grating)
%
%converts keyboard response to integer and determines if response was correct. Also computes RT
%
%input
%window - window pointer
%feedback - structure containing feedback images
%color - structure containing color information
%where - structure containing location information
%stim - structure containing stimulus information
%time - structure containing timing information
%data - data structure
%presExample - 0 for experimental trials, >0 for practice trials
%trial - current trial
%
%output
%resp - response
%correct - probabilistic fb
%opt_correct - optimal fb
%rt - response time
%time - updated timing structure

%Screen('Close', grating.g);
%GET CATEGORIZATION RESPONSE
correct = 99; resp = 99; rt = 0;
%compute category RT
rt = 1000*(time.response-time.stim_onset); %in ms
disp('checkgetreponse3'); save temp.mat
%TRANSFORM RESPONSE -- response assignments are counterbalanced

%if statement for y bounds?
if (stim.stim(trialWithinBlock,4)) == 1 %present the sun on the right
    if x > 1800 && x < 2000 %x and y are within the bounds for the sun pic
        resp = 1; %Sun
    elseif x > 1600  && x < 1800 %x and y are within the bounds for the rain pic
        resp = 2; %Rain
    end
else %the sun is presented on the left
    if x > 1600 && x < 1800 %x and y are within the bounds for the sun pic
        resp = 1; %Sun
    elseif x > 1800 && x < 2000 %x and y are within the bounds for the rain pic
        resp = 2; %Rain
    end
end




% if data.catKeyMapping==1
%     if sum(strcmp(response,cellstr(['n']')))==1
%         resp = 1; %Sun
%     elseif sum(strcmp(response,cellstr(['j']')))==1
%         resp = 2; %Rain
%     end
% else
%     if sum(strcmp(response,cellstr(['f']')))==1
%         resp = 2; %Rain
%     elseif sum(strcmp(response,cellstr(['v,']')))==1
%         resp = 1; %Sun
%     end
% end
disp('checkgetreponse4'); save temp.mat
%other responses
if resp > 2 %assumes default resp different from 1-4
   % EscapeSequence(response,'getResponseWPT.m');
    %if response == '`'
        %quit experiment
        %escape('Q','user broke out of experiment');
    if x > 2000 || x < 1600
        resp = 10; 
    end %end if response	
end
disp('checkgetreponse5'); save temp.mat
%COMPUTE FEEDBACK
if resp == 99 
    correct = 99;
elseif resp == 97
    correct = 97;
elseif resp == 10;
    correct = 2; 
elseif resp<=2
%     if  trainTest==2 || stim.stim(trialWithinBlock,1)==10 %no feedback trials
%         correct = -1;
%     elseif resp==stim.stim(trialWithinBlock,1)
    if resp==stim.stim(trialWithinBlock,2)
        correct = 1;
    else
        correct = 0;
    end
end %end if resp
  
disp('checkgetreponse6'); save temp.mat 
if presExample==0 || presExample == 2 %fb for experimental and practice trials
    time = visual_feedbackWPT(window,correct,color,where,sounds,feedback,stim,time,trial,trialWithinBlock, trainTest, blockNum, data);
elseif presExample==1 %no fb for example stimuli
    WaitSecs(time.fbDuration); time.fb_end = GetSecs;
end
disp('checkgetreponse7'); save temp.mat
%update ITI
% if presExample==0 || presExample == 2 %fb for experimental and practice trials
%     time = visual_feedback(window,correct,color,where,sounds,feedback,stim,time,trial,trialWithinBlock, trainTest, blockNum, data);
% elseif presExample==1 %no fb for example stimuli
%     waitsecs(time.fbDuration); time.fb_end = GetSecs;
% end

%time.ITI = max(time.trialDuration-(GetSecs-time.stim_onset)+time.ITI_base,time.ITI_base);
