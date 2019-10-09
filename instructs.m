function [show_instructions,doPracticeOnly] = instructs(window,color,where,stim,time,feedback,sounds,data,doPracticeOnly,presExample,present_instructions, trainTest, blockNum, trialWithinBlock)
%function [show_instructions,doPracticeOnly] = instructs(window,color,where,stim,time,feedback,sounds,data,grating,structname,doPracticeOnly,presExample,present_instructions)
%
%
% show instructions for set switching/reg focus exp.
%
%5/24/05    swe
%8/10/05    swe     modified for version 5
%10/16/06   swe     modified for split-brain study
%12/3/06    swe     modified to work with OpenGL-Psychtoolbox version 3.0.8 on OSX
%12/7/06    swe     modified for 2-rule version of split experiment
%12/11/06   swe     added extra set of practice trials for catch trials
%1/23/07    swe     modified for imaging version of select-switch experiment (pilot)
%3/28/08    swe     modified for relational
%7/20/2010  swe     modified for focalBG - wm experiment to be run @ Berkeley on PC
%5/24/2012  swe     modified for stress cog
%3/10/2017  swe     modified for online stressor
%2/28/2019  dbs     modified for the weather prediction task
%


%initial instructions

if doPracticeOnly
    displayText(window, 'instructs_practiceonly.txt',color,where,stim,0);
    while(KbCheck);end %Wait for all keys to be released.
    KbWait;
    
    %select stimuli at random (w/o replacement) from first block of training stimuli
    sample_trials= randrows([1:data.trialsPerBlock]');      
    sample_trials = sample_trials(1:data.numPracticeTrials(1));
    time.fb_end = GetSecs;
    for i=1:length(sample_trials)
        trial = sample_trials(i);
        %Draw a stimulus
        clearmode=0;
        
                %   [time,grating] = present_stim(window,data,color,where,stim,trialWithinBlock,trial,time,presExample,clearmode)
%         time = present_stim(window,stim,trial,time,presExample,clearmode);
%         WaitSecs(2);
%         time = present_stim(window,stim,grating,trial,time,structname,presExample,clearmode);
%         WaitSecs(2);
%9/18/
        %time = present_stim(window,data,color,where,stim,trialWithinBlock,trial,time,presExample,clearmode);
        [time,grating] = present_stim(window,data,color,where,stim,trial,trial,time,presExample,clearmode,blockNum); 
        WaitSecs(2);
        if i<length(sample_trials)            
            clearmode = 0;
            space_bar(window,color,where,'see another example.',clearmode);
        else
            space_bar(window,color,where,'continue with instructions.',clearmode);
        end
    end

    disp('1a')
    
else
    
    
    disp('1c') 
    save temp.mat
    if present_instructions > 0 %full instructions
        %1. basic written instructions
        displayText(window, 'instructs1.txt',color,where,stim,0);
        while(KbCheck);end %Wait for all keys to be released.
        KbWait;

    disp('1b') 
    save temp.mat
        %select stimuli at random (w/o replacement) from first block of training stimuli
        sample_trials = randrows([1:data.trialsPerBlock]');      
        sample_trials = sample_trials(1:data.numPracticeTrials(1));
        time.fb_end = GetSecs;
        for i=1:length(sample_trials)
            trial = sample_trials(i);
            %Draw a stimulus
            clearmode=0;
            
            
    disp('1d') 
    save temp.mat
%                         [time,grating] = present_stim(window,data,color,where,stim,trial,trial,time,presExample,clearmode);
%         time = present_stim(window,data,color,where,stim,trialWithinBlock,trial,time,presExample,clearmode);
%             time = present_stim(window,data,color,where,stim,trial,time,presExample,clearmode)
       % time = present_stim(window,stim,trial,time,presExample,clearmode);

   
    [time,grating] = present_stim(window,data,color,where,stim,trial,trial,time,presExample,clearmode,trainTest, blockNum); 
    save tempinstruct.mat

    disp('1e') 
    save temp.mat
       
WaitSecs(2);
                clearmode = 0;
    disp('1f') 
    save temp.mat
            if i<length(sample_trials)  
     disp('1j') 
    save temp.mat

                
    disp('1gj') 
    save temp.mat
                
                space_bar(window,color,where,'see another example.',clearmode);
                
     disp('1g') 
    save temp.mat
            else
                
     disp('1h') 
    save temp.mat
                space_bar(window,color,where,'continue with instructions.',clearmode);
                
    disp('1hk') 
    save temp.mat
            end
    disp('1k') 
    save temp.mat
        end
    disp('2a')
    save temp.mat
         %2. explain feedback, etc...
        displayText(window, 'instructs2.txt',color,where,stim,0);
        while(KbCheck);end %Wait for all keys to be released.
        KbWait;
  disp('2b')
        %feedback following correct trial
        time.response = GetSecs;
        trial=1;
        time = visual_feedback(window,1,color,where,sounds,feedback,stim,time,trial,trialWithinBlock,trainTest,blockNum, data);
  disp('2c')

        %feedback following incorrect trial
        displayText(window,'instructs3.txt',color,where,stim); while(KbCheck);end; KbWait;
        trial=2;
        time = visual_feedback(window,0,color,where,sounds,feedback,stim,time,trial,trialWithinBlock,trainTest,blockNum, data);

  disp('2d')
        %wrong key
        displayText(window,'instructs4.txt',color,where,stim); while(KbCheck);end; KbWait;
        trial=2;
        time = visual_feedback(window,2,color,where,sounds,feedback,stim,time,trial,trialWithinBlock,trainTest,blockNum, data);
disp('2e')


        %too long
        displayText(window,'instructs5.txt',color,where,stim); while(KbCheck);end; KbWait;
        trial=2;
        time = visual_feedback(window,99,color,where,sounds,feedback,stim,time,trial,trialWithinBlock,trainTest,blockNum, data);
disp('2f')
    
        %summary
        str = ['instructs_summary.txt'];
        displayText(window,str,color,where,stim); while(KbCheck);end; KbWait;
        
            disp('3')
    else %present brief reminder instructions
        %summary
        str = ['instructs_pretask_summary.txt'];
        displayText(window,str,color,where,stim); while(KbCheck);end; KbWait;
        
    end
    disp('4')
end %if doPracticeOnly

%ask to repeat instructions
displayText(window, 'instructs_final.txt',color,where,stim,0);
while(KbCheck);end; 
keyIsDown=0; response=99;
while keyIsDown==0 || response==99; 
    [keyIsDown,response,time.response] = check_key(keyIsDown); 
    if strcmp(response,'i') %repeat instructions
        show_instructions=1; doPracticeOnly = 0;
    elseif strcmp(response,'p') %repeat practice trials
        show_instructions=1; doPracticeOnly = 1; 
    else %done with instructions
        show_instructions=0; doPracticeOnly = 0; 
    end;
    
        disp('5')
end %end while keyIsDown

%1st transfer block

                disp('begin test instructs');
                Screen('Flip', window)
                WaitSecs(1);
                displayText(window, 'notify_experimenter_test.txt',color,where,stim);
                clicks=0;
                while ~clicks; [clicks,x,y] = GetClicks(window); end

disp('instructs test')
save temp.mat
     str = ['instructs_test.txt'];
     displayText(window,str,color,where,stim, 0); while(KbCheck);end; KbWait;
disp('instructs test2')
save temp3.mat     



keyIsDown=0; response=99;
while keyIsDown==0 || response==99; 
    [keyIsDown,response,time.response] = check_key(keyIsDown); 
    if strcmp(response,'i') %repeat instructions
        show_instructions=1; doPracticeOnly = 0;
    elseif strcmp(response,'p') %repeat practice trials
        show_instructions=1; doPracticeOnly = 1; 
    else %done with instructions
        show_instructions=0; doPracticeOnly = 0; 
    end;
    
        disp('5')
end %end while keyIsDown

        