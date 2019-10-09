function David_Pilot_4WPT


% function  David_Pilot_4WPT
%Pilot Experiment looking at the testing effect with the weather prediciton
%task
%
%
% ************************************************************
%
%
%
%
%2/28/19 DBS created for the weather prediction task

%
% dependencies:
%
%   check_key.m -- collects keypresses
%   cleanup.m -- cleans stuff up, closes psychtoolbox screens
%   comp_pc_rt.m -- computes pc and rt at the end of a block
%   correctkey.m -- delivers feedback about which category label was correct
%   displayText.m -- prints text to Psychtoolbox window
%   end_of_block -- bookkeeping at end of block
%   escape.m -- quits program
%   escapeSequence -- used in getResp to enable "QP" sequence to exit the experiment
%   feedback_init.m -- initialize auditory and visual feedback
%   genGratings_single.m -- generate Psychtoolbox textures
%   getResponse.m -- converts keypresses to responses, computes fb
%   instructs.m -- displays instructions, sample stimuli, practice trials
%   present_stim.m -- displays stimulus images
%   randrows.m -- randomizes rows of a matrix/column vector
%   savestruct.m -- useful function borrowed from Matthew Brett (saves data structures)
%   scaleif.m -- fancy scaling used with stimulus generation
%   space_bar.m -- used to prompt user to press space bar to continue
%   too_slow.m -- presents feedback on trials where they responded after time limit
%   visual_feedback.m -- presents visual and auditory feedback
%   write_header.m -- creates header file with useful summary information
%   wrong_key.m -- presents annoying beep and message when Ss hit wrong key
%clear all existing variables and functions from memory
clear all
clear mex
clc
warning off %maybe not the best idea, but otherwise you get many annoying messages due to differences in case (e.g., screen vs. Screen). slowly fixing this crap
echo off
format loose
PsychJavaTrouble


% Here we call some default settings for setting up Psychtoolbox
PsychDefaultSetup(2);

%warning off %maybe not the best idea, but otherwise you get many annoying messages due to differences in case (e.g., screen vs. Screen). slowly fixing this crap
%echo off
format loose

%reset the random number generator based on the current time.
rng('shuffle')


interleaved=1;

%PsychJavaTrouble

% Screen is able to do a lot of configuration and performance checks on
% open, and will print out a fair amount of detailed information when
% it does.  These commands supress that checking behavior and just let
% the demo go straight into action.  See ScreenTest for an example of
% how to do detailed checking.
%oldVisualDebugLevel = Screen('Preference', 'VisualDebugLevel', 3);
%oldSupressAllWarnings = Screen('Preference', 'SuppressAllWarnings', 1);

try
	%get resolution
    whichScreen = max(Screen('Screens'));
    [window, screenRect] = PsychImaging('OpenWindow', whichScreen, 0);
    [data.res_x, data.res_y]=Screen('WindowSize', window);
    sca

    %**********NUMBER OF BLOCKS
    %I think this will depend on the condition? 
    %Maybe not, I can set it so that on blocks 1-4 do X for condition X. 
    data.numTrainingBlocks = 4; data.numTransferBlocks = 1; data.numBlocks = data.numTrainingBlocks + data.numTransferBlocks; 
    data.trialsPerBlock = 50; 
    data.numTrainingTrials = data.trialsPerBlock*data.numTrainingBlocks;
    data.numTestTrials = 200;
    
    cur_dir = cd;
    proceed = 0;
    while ~proceed;
        fprintf('\n*************************************************************************\n\n')
        fprintf('EXPERIMENTERS, PLEASE READ. \n')
        fprintf('Place the monitor approximately 20 in (50.8 cm) from the subject\n')
        fprintf('x_resolution = %i\n', data.res_x);
        fprintf('y_resolution = %i\n', data.res_y);
        fprintf('\n\n\nResponse Keys\n');
        fprintf('\n     Category response labels A/B and AnA conditions.');
        fprintf('\n     If the category-keyboard mapping = 1, f=catA/Yes, j=catB/No:');
        fprintf('\n     If the category-keyboard mapping = 2, j=catA/Yes, f=catB/No:');
        fprintf('\n\n   Production task keys.');
        fprintf('\n     z=OK, /=ADJ, t=up arrow, y=down arrow');
        fprintf('\n     If the category-keyboard mapping = 2, k=catA/Yes, d=catB/No:');        fprintf('\n\n\nIMPORTANT!!!!\n');
        fprintf('\n*************************************************************************\n\n\n')
        proceed = input('Are you ready to proceed? (1=yes, -1=quit program)  :  ');
        if proceed==-1; escape('Q','initial instructions'); end
    end %end while proceed

    setup_done = 0;
    while ~setup_done
        
        %******************INPUT
        debug = input('DEBUG MODE? (1=yes,0=no): ');
        while debug
            debug_check = input('Are you sure that you want to DEBUG? (1=yes,0=no): '); 
            if debug_check == 1
                break;
            else
                debug = input('DEBUG MODE? (1=yes,0=no): ');
            end
        end
    
        if debug; data.sub = 99; else data.sub = input('Enter subject number: '); end;
      
       fprintf('\n\nSTOP! All participants will be completing two days of the experiment: ');
       fprintf('\nPlease double check that you are entering the correct day.')

       data.day = input('Enter task day:  day 1 or 2    ');                         
        
               %check to help experimenter run correct task on correct day
        switch data.day 
            case 1,
                data.dayText = 'day1';
                data.day = 1;
            case 2,
                data.dayText = 'day2';
                data.day = 2;
            otherwise,
                escape('Q','when entering dayText'); 
        end
        
        data.trainingCondition = input('Training Condition: (Study = 1; Test = 2)  ');
        switch data.trainingCondition
            case 1,
                data.trainingConditionText = 'Study'; 
            case 2,
                data.trainingConditionText = 'Test';  
            otherwise,
                escape('Q','when entering training condition text'); 
        end
         
        
       
        data.task = input('Enter task:  Immediate or Delay (Immediate = 1; Delay = 2)    ');         
       switch data.task 
                 case 1,
                data.taskText = 'Immediate';
                 case 2,
                data.taskText = 'Delay';
                 otherwise,
                escape('Q','when entering taskText'); 
        end
       fprintf('\n') 
       if debug; data.gender = 1; else data.gender = input('Enter subject gender female (1), male (2): '); end
        switch data.gender 
            case 1,
                data.genderText = 'female';
            case 2,
                data.genderText = 'male';
            otherwise,
                escape('Q','when entering genderText'); 
        end
% 
%        if debug; data.age = 1; else data.age = input('Enter subject age: '); end

 load WPT.stim;
 load WPTtrainingstim.stim;
 trainingStim = WPTtrainingstim;
 data.numTrainingTrials = size(trainingStim,1);   
 testStim = WPT;
 data.numTestTrials = size(testStim,1);
          
     %controls cat label - key counterbalancing
        data.catKeyMapping = input('Enter category-keyboard mapping. (1 or 2).  ');
        switch data.catKeyMapping 
            case 1, 
                data.catKeyMapping_text = '1 n=Sun, j=Rain';
            case 2,
                data.catKeyMapping_text = '2 v=Rain, f=Sun';
            otherwise,
                escape('Q','when entering catKeyMapping'); 
        end
        
        

      
        %*************INITIAL MONITOR SETUP

        data.monitor_size = 16;%input('Enter the horizontal size of the monitor in inches: (MacBookPro = 14.5, lab testing machines = 16 - should work for any size) ');
        if data.monitor_size<10; escape('Q','unlikely monitor size'); end;
        data.monitor_text = [num2str(data.monitor_size) ' inch monitor (horizontal)'];
        data.monitor_res_text = [num2str(data.res_x) ' x ' num2str(data.res_y) 'resolution'];
        data.monitor_dist = 20; %distance from edge of desk (inches)

        fprintf('\n\nDo you want to present the instructions?\n');
        present_instructions = input('Enter 1 for full instructions, or 0 for no instructions.  ');

        
        %generate datafile name

      %data.outname = ['S' int2str(data.sub) '_' data.trainingConditionText 'train_' data.taskText 'day_' data.dayText '_map' num2str(data.catKeyMapping)];
       data.outname = ['S' int2str(data.sub) '_' data.trainingConditionText '_' data.taskText '_' data.dayText '_map' num2str(data.catKeyMapping)];

        %delete generic debugging data
        if debug
            delete([cur_dir '/data/S' int2str(99) '*']);
            diary([data.outname '.txt'])
        end
        

      
        done = 0;
        while ~done
            fprintf('\n\nChecking for duplicate data files . . .\n\n')
            if exist([cur_dir '/data/' data.outname '.dat'],'file') == 2
                fprintf('\n\nThis data file already exists.  Double check the stimulus parameters.\n\n');
                data.sub = input('Subject Number?  ');
                %file name
                data.outname = ['S' int2str(data.sub) '_' data.trainingConditionText '_' data.taskText '_' data.taskText '_DAY' num2str(data.day)];
            else
                fprintf('\n\nNo duplicates found.  Experiment proceeding.\n\n')
                disp(' ')
                % confirm subject settings
                fprintf('You have selected the following parameters for this subject:\n');
                fprintf('     Subject Number = %i\n',data.sub);
                fprintf('     Training Condition = %s\n', data.trainingConditionText);
                fprintf('     Day = %s\n', data.dayText);
                fprintf('     Task = %s\n', data.taskText);
                fprintf('     Gender = %s\n', data.genderText);
                fprintf('     data filename =  %s\n',[data.outname '.dat']);
                fprintf('     Monitor size = %s\n', data.monitor_text);
                fprintf('     Monitor resolution = %s\n\n\n', data.monitor_res_text);
                fprintf('Please take a moment to double check these parameters against the experiment log.\n');
                resp = lower(input('Accept, Reset, or Quit program (a, r, q): ', 's'));
                if strcmp(resp,'a'); done = 1; setup_done = 1; elseif strcmp(resp,'q'), error('quit when confirming subject settings'); else; done = 1; end %end if strcmp
            end %end if exist
        end %end while ~done
    end %while setup_done
disp('test1')
     
    %*****************************************set up the experiment variables
    color.white = [255];  % Retrieves the CLUT color code for white.
    color.black = [0];  % Retrieves the CLUT color code for black.
    color.gray = (color.black + color.white) / 2;  % Computes the CLUT color code for gray.
        if round(color.gray)==color.white; color.gray=color.black; end
    color.light_gray = abs(color.white-color.gray)/2;
    color.textColor = color.black;
    color.bgColor = color.gray;
    color.green = [  0   250   0]; %green
    color.red = [250     0   0]; %red
    color.blue = [0 0 200];
    color.yellow = [200 200 0];
    color.stimColor = color.white;
      
    % ---------- Window Setup ----------
    % Find out how many screens and use largest screen number.
    whichScreen = max(Screen('Screens'));
	% Hides the mouse cursor
    HideCursor;
    %if ~debug; ListenChar(2); end; %gets rid of annoying keyboard buffer dump to command window
	% Opens a graphics window on the main monitor (screen 0).  If you have
	% multiple monitors connected to your computer, then you can specify
	% a different monitor by supplying a different number in the second
	% argument to OpenWindow, e.g. Screen('OpenWindow', 2).
	[window, screenRect] = Screen('OpenWindow', whichScreen, color.bgColor, [], 32, 2);
    %Screen(window,'TextFont', 'Verdana');   %       Use Verdana because both Macs and PCs have this.
    Screen(window,'TextFont', 'Arial');   %       Use Verdana because both Macs and PCs have this.
    %Screen('BlendFunction', window, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    %a few technical notes regarding how the new OpenGL version of PTB draws
    %Understanding the Screen('Flip') command is key
    %the above Screen('OpenWindow') command creates a double-buffered window - "invisible" drawing in back buffer; what you see is in the front buffer
    %Screen('Flip') interchanges the contents of the buffers (i.e., moves stuff in the back, to the front)
    %
    %Flip syntax
    %[vbltime sostime fliptime missed beampos] = Screen('Flip', windowPtr [,when] [,clearmode] [,dontsync]);
    %The clearmode flag allows you to specify what should happen after a Flip
    
    
    %monitor setup
    centimeters_per_inch = 2.54;
    %[data.res_x, data.res_y]=Screen('WindowSize', window); %double check resolution
    data.pixels_per_mm = data.res_x/(data.monitor_size*centimeters_per_inch*10);
         
    
    %********************define stimulus structure
       %   stim files are data.numTrials x 4 [cat, sf, orient, block] 
    stim.cat_col = 1; stim.sf_col = 2; stim.orient_col = 3; stim.block_col = 5; %stim.index_col = 5; %useful columns
    %stim.cat_col = 1; stim.sf_col = 2; stim.orient_col = 3; stim.block_col = 4; stim.index_col = 5; %useful columns

    %stim.target_location_col = 5; %only meaningful for 2AFC version of inference task
    stim.range_col = 6; %only meaningful for transfer stimuli
    stim.inferDimension_col = 7; 
    stim.AnotA_col = 8; %only meaningful for A not A training
    %randomize presentation order for block 1. Randomize and generate other stimuli between blocks
disp('test2')
save temp.mat
    if interleaved

        stimuli = trainingStim;
        %stim.stim = randrows(stimuli);
        blockNum = 1;
        stimuli = trainingStim(trainingStim(:,stim.block_col)==blockNum,:);        
        stimuli = randrows(stimuli);
        stim.stim = stimuli;
%         stim.stim = randrows(stimuli);  %randomize presentation order for each sub    
    else %blocked
        trainingStim = randomizedBlocked(trainingStim,stim,data); %removes probe stimuli
        stimuli = trainingStim(trainingStim(:,stim.block_col)==1,:); 
        stim.stim = stimuli;
    end

    data.numTrials = data.numTrainingTrials + data.numTestTrials;
   % stim.increment_diameter = 5; %amount to change circle diameter when fine tuning (pixels)
    %stim.increment_orient = 1; %amount to change orientation when fine tuning (degrees)
    stim.textSize = 15;
    stim.lineWidth = 4;    
    stim.length = 200; %present line at constant length   
    %constrain Ss to produce responses within the possible range of stimuli
    stim.diameter_limits = [10 600]; %scaled %[min([trainingStim(:,stim.diameter_col);testStim(:,stim.diameter_col)])  max([trainingStim(:,stim.diameter_col);testStim(:,stim.diameter_col)])];
    stim.orient_limits = [-50 110]; %scaled %[min([trainingStim(:,stim.orient_col);testStim(:,stim.orient_col)])  max([trainingStim(:,stim.orient_col);testStim(:,stim.orient_col)])];
    %stim.widthOfGrid = 300; %width of grid for generating gratings
    Screen(window, 'TextSize', stim.textSize);

   
 disp('test3')         
save temp.mat
    %********************define where structure
    
        [where.xc, where.yc] = RectCenter(screenRect);
    where.bg_window = screenRect; %convenient for clearing part of screen when using score bar, etc...
    where.screenRect = screenRect;
    where.viewing_distance = 558.8; %assumed distance between S and monitor (in mm; 508 mm = 20 inches) (558.8mm = 22 in).
    where.shift_from_edge = 50; %amount to shift text from edge of screen
    where.top = screenRect(2)+where.shift_from_edge; 
    where.bottom = screenRect(4)-where.shift_from_edge; 
    where.left = screenRect(1)+where.shift_from_edge; 
    where.right = screenRect(3)-where.shift_from_edge;
    where.jitter_range = [150 40];%[100 50] %[0 0] = central stim presentation on all trials
    where.jittered_vertical_center = -where.jitter_range(1)/2 + where.jitter_range(1)*rand(data.numTrials,2);%N dist was not working was hardly noticeable
    where.jittered_horizontal_center = -where.jitter_range(2)/2 + where.jitter_range(2)*rand(data.numTrials,1);
    where.message_position = screenRect(4)-2*stim.textSize;  %y position of message between blocks
    
    %********************define time structure (in seconds)
    time.ifi = Screen('GetFlipInterval', window);
    %hertz = FrameRate(window);
    %nominalHertz = Screen('NominalFrameRate', window);
    time.deadline = [15 5]; %deadlines during [practice experiment] (sec)
    time.stimDuration = time.deadline(1);%presentation time
    time.responseDeadline = time.stimDuration;%total time to respond (includes stimulus presentation time)
    time.ITI = 1; 
    time.fixTime = 0;
    time.fbDuration = 2;
    time.experiment_begin = fix(clock);
    time.start = GetSecs;
    time.topPriorityLevel = MaxPriority(window);
    time.waitFrames = 1; % Numer of frames to wait 
    %%%%%Added 6-16-2016, not sure if needed
    time.delay_interval = 10; %for delay condition
    time.initial_delay = 2; % initial delay of 1st stimulus presentation
    %correct for delay -- at hardware limit, thus same as shifting by 1 ifi, so i will simply do this
    %time.fix2stim_delay = .00847; %estimated from observed onset times (not flip times, b/c onset seems more psychologically relevant -- i.e., drawing onset) in Screen('Flip'), essentiall presents stimulus one frame earlier, thereby decreasing error to approx 1.5 ms (early)
    %time.stim2clear_delay = .00937; %same idea, but error < 1 ms (early)
    %initialize time-check variables
    time.fix_flip_begin=zeros(size(data.numTrials,1),1); time.fix_onset=zeros(size(data.numTrials,1),1); time.fix_flip_end=zeros(size(data.numTrials,1),1);  
    time.stim_flip_begin=zeros(size(data.numTrials,1),1); time.stim_onset=zeros(size(data.numTrials,1),1); time.stim_flip_end=zeros(size(data.numTrials,1),1);  
    time.stim_clear_begin=zeros(size(data.numTrials,1),1); time.stim_clear_onset=zeros(size(data.numTrials,1),1); time.stim_clear_end=zeros(size(data.numTrials,1),1); 
    time.observed_ITI=zeros(size(data.numTrials,1),1); 
    time.fb_begin=zeros(size(data.numTrials,1),1); time.fb_onset=zeros(size(data.numTrials,1),1); time.fb_end=zeros(size(data.numTrials,1),1); 
    time.query_begin=zeros(size(data.numTrials,1),1); time.query_onset=zeros(size(data.numTrials,1),1); time.query_end=zeros(size(data.numTrials,1),1); 
    %time.time_to_present_fix = zeros(size(data.numTrials,1),1);  time.observed_ITI = zeros(size(data.numTrials,1),1); time.between_fix_and_stim = zeros(size(data.numTrials,1),1);
    %time.til_stim_cleared = zeros(size(data.numTrials,1),1); time.to_present_stim = zeros(size(data.numTrials,1),1);
disp('test4')  
    %monitor setup
    centimeters_per_inch = 2.54;
    data.pixels_per_mm = data.res_x/(data.monitor_size*centimeters_per_inch*10);
    data.pixels_per_inch = data.res_x/data.monitor_size;
    
    %********************define data structure
    data.MyData = zeros(data.numTrials,11); %storage %Changed from 14 DBS 11/24/18
    data.block_pc = zeros(data.numBlocks,1); data.block_rt = data.block_pc; data.block_rmse = zeros(data.numBlocks,2);
    data.rt_col = 5; data.resp_col = 4; data.fb_col = 6; 
    data.diameterCol = 2; data.orientCol = 3; data.diameter_responseCol = 7; data.orient_responseCol = 8; data.inferDimensionCol = 12;
    data.rt_cutoff = 5000; %ms - arbitrary RT outlier cutoff
    data.o_gain = 800; % converts pixel units to radians --> r = p*pi/o_gain
		              % determines saliency of the orientation dimension
		              % relative to length dimension (Ashby et al. 1999 unsup paper)
    data.diameter_gain = .5; %scale circle diameter in an attempt to equate saliency
    %stim.orient_limits = stim.orient_limits * 180/data.o_gain; %convert to degrees
    %stim.diameter_limits = [5 600]; %stim.diameter_limits*data.diameter_gain;
    data.possible_shift_range = 0; 
    data.x_shift =0;
    data.numPracticeTrials = [5 3];
 
    
    %********************rest of where structure
    where.message_position = screenRect(4)-2*stim.textSize;  %y position of message during stimulus presentation

disp('test5')
save temp.mat
    %********************define feedback structure
    [sounds,feedback] = feedback_init(window,time);
    feedback.fb_vis_angle = [2 6]; %visual angle of feedback [height width] (arbitrary)
    feedback.fb_size = data.pixels_per_mm*(where.viewing_distance .* tan(feedback.fb_vis_angle*pi/180)); %defines height and width of fb (in pixels)
    %initailize some variables
    blockNum = 1; start_trial = 1; trialWithinBlock = 1;
    trainTest = 1; %training
    currentCondition = data.trainingCondition;
    data.infer_diameter_counter = 0; data.infer_orient_counter = 0; %counters for naming structures containing all adjustments
    %*****************************present instructions   
    % instructions
disp('check 0')    
    Screen('Flip', window);
    doPracticeOnly = 0; presExample = 1;
disp('check 0.5')     
save tempinst.mat
    while present_instructions>0
        if debug;save temp.mat;disp('instructs'); end;
        [present_instructions,doPracticeOnly] = instructsWPT(window,color,where,stim,time,feedback,sounds,data,doPracticeOnly,presExample,present_instructions,trainTest, blockNum, trialWithinBlock);
    end
    presExample = 0;
disp('check 1')
save temp.mat
    if debug
        data.trialsPerBlock = 1; data.numTrainingBlocks = 6; data.numTransferBlocks = 1; data.numBlocks = data.numTrainingBlocks + data.numTransferBlocks;
        data.numTrials = data.numTrainingTrials + data.numTestTrials; data.trialsPerBlock*data.numBlocks;  
        start_trial =1; blockNum = 1; trialWithinBlock = 1;
        %stimuli = trainingStim(trainingStim(:,stim.block_col)==blockNum,:);
        stimuli = trainingStim;
        if interleaved; stim.stim = randrows(stimuli); else stim.stim = stimuli; end
    end
disp('check 2')    
    Screen('Flip', window)
    WaitSecs(1);

    displayText(window, 'notify_experimenter.txt',color,where,stim);
    clicks=0;
    while ~clicks; [clicks,x,y] = GetClicks(window); end

    
    displayText(window, 'get_ready.txt',color,where,stim);    
    while(KbCheck);end %Wait for all keys to be released.
    KbWait;
disp('check 3') 
save temp.mat    
        % Perform some initial Flip to get us in sync with retrace:
    time.vbl=Screen('Flip', window);
    time.starttime = time.vbl; time.response = time.vbl; 
    if debug; disp('startexp');end; clearmode=0;
    
    
    
                if data.day == 2
                    trainTest = 2;
                    stimuli = testStim; 
                    data.trialsPerBlock = data.numTestTrials;
                    stim.stim = randrows(stimuli);  %randomize presentation order for each sub
                    blockNum = 5;
                    %if debug; data.numTrials = trial+data.trialsPerBlock; save temp; end                    
                    Screen('Flip', window)
                    WaitSecs(1);
        
                    [present_instructions,doPracticeOnly] = instructsWPT(window,color,where,stim,time,feedback,sounds,data,doPracticeOnly,presExample,present_instructions,trainTest, blockNum);
                end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%                       Trial loop                            %%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('check 4') 
    for trial = start_trial:data.numTrials
disp('check 4.1'); save temp.mat 

  %present stim
        if debug;save temp2.mat;disp('present_stim'); end;
        [time, x, y] = present_stimWPT(window,data,color,where,stim,trialWithinBlock,trial,time,presExample,clearmode,trainTest,blockNum);
  %get response
disp('check 4.12')
save temp.mat
        if debug;save temp.mat;disp('get_response'); end;
        %[resp,correct,rt,time,data] = getResponseWPT(window,sounds,feedback,color,where,stim,time,data,presExample,trial,trainTest,trialWithinBlock,blockNum);
        [resp,correct,rt,time,data] = getResponseWPT_clicks(window,sounds,feedback,color,where,stim,time,data,presExample,trial,trainTest,trialWithinBlock,blockNum, x, y);

        save temp.mat
disp('check 4.2')       
        
%DBS fix this so STIM isnt saved instead which pattern is        
        %fill in datadata.numTrainingBlocks
        %rows are trials
        %columns are [cat, un-scaled_sf, un-scaled_orient, resp, RT, fb, diameter response (inference only), orient response (degrees: inference only), currentCondition (1=A/B,2=inf,3=AnA), trainTest (1=train), in low/high range (1=low,2=high), 
        %               inferDimension (11=infer SF,22=infer OR), AnA question (AnA only) trial trialWithinBlock block]
        if debug;save temp.mat;disp('store data'); end;       
        %data.MyData(trial,:) = [stim.stim(trialWithinBlock,1:3)   resp   rt   correct   currentCondition   trainTest   stim.stim(trialWithinBlock,stim.range_col) ...
              %stim.stim(trialWithinBlock,stim.inferDimension_col)   stim.stim(trialWithinBlock,stim.AnotA_col)   trial   trialWithinBlock   blockNum ];
        data.MyData(trial,:) = [stim.stim(trialWithinBlock,1:3)   resp   rt   correct   currentCondition   trainTest  ...
                    trial   trialWithinBlock   blockNum ];
        if debug;save temp.mat;disp('end store data'); end;
disp('check 7')
        % if at the end of a block, give fb and take a break
        if debug;save temp.mat;disp('check block'); end;
        if trialWithinBlock == data.trialsPerBlock; %(mod(trialWithinBlock,data.trialsPerBlock) == 0)
 disp('check 8')             
            time.now = GetSecs;
        if debug;save temp.mat;disp('comp_pc'); end;  
        save temp5.mat
            out = comp_pc_rt(data,trial,currentCondition);
            data.block_pc(blockNum,:)=out(2,:); data.block_rt(blockNum,:)=out(1,:);
        if debug;save temp.mat;disp('write_header'); end;
            write_headerWPT(data,stim,time,where);
 disp('check 8.5') 
            if (trial == data.numTrials)
                space_bar(window,color,where,'exit the experiment. Thanks for participating.');
            else
        if debug;save temp.mat;disp('write_header_22'); end;
                blockNum = end_of_block(window,data,color,where,stim,blockNum);
                %if blockNum > data.numTrainingBlocks   %test block 
                %trying to make it so if they are on day 2 then they just
                %do test phase
                if blockNum > data.numTrainingBlocks %test block 
disp('check 9')  
                   
save temp2.mat
%change to test stimuli
%Only do test phase for immediate? 
                if data.task == 1
                    trainTest = 2;
                    stimuli = testStim; 
                    data.trialsPerBlock = data.numTestTrials;
                    stim.stim = randrows(stimuli);  %randomize presentation order for each sub
                    %if debug; data.numTrials = trial+data.trialsPerBlock; save temp; end                    
                    Screen('Flip', window)
                    WaitSecs(1);
                if data.trainingCondition ~= 2
                    [present_instructions,doPracticeOnly] = instructsWPT(window,color,where,stim,time,feedback,sounds,data,doPracticeOnly,presExample,present_instructions,trainTest, blockNum);
                else
                end
                else
                    clean_up  
                    clc
                    disp('Thank you for participating. Please let the experimenter know that you are finished.');

                end    
                    
        if debug;save temp.mat;disp('write_header_3.0'); end;
                   
                    
                else %randomize and generate next block of gratings 
%                     if data.trainingCondition == 2 && blockNum == 5
%                         [present_instructions,doPracticeOnly] = instructs(window,color,where,stim,time,feedback,sounds,data,doPracticeOnly,presExample,present_instructions,trainTest, blockNum);
%                     else
%                     end    
                    %stimuli = trainingStim(trainingStim(:,stim.block_col)==blockNum,:); 
                    %data.trialsPerBlock = data.numTrainingTrials;
                    if interleaved
                        
        stimuli = trainingStim;
        %stim.stim = randrows(stimuli);
        stimuli = trainingStim(trainingStim(:,stim.block_col)==blockNum,:);        
        stimuli = randrows(stimuli);
        stim.stim = stimuli;
                        %stim.stim = randrows(stimuli);  %randomize presentation order for each sub
                    else %blocked
                        stim.stim = stimuli;
                    end
                end %blockNum > data.numTrainingBlocks
%                 if blockNum==4                    
%                     if interleaved; data.trialsPerBlock = 94; end
%                     displayText(window, 'block4.txt',color,where,stim);    
%                     while(KbCheck);end %Wait for all keys to be released.
%                     Kb Wait;
%                 elseif debug
%                     data.trialsPerBlock = 10;
%                 end              
                space_bar(window,color,where,['begin block ',int2str(blockNum)]);
                trialWithinBlock = 0;
            end %(trial == data.numTrials)            
        end%end if (mod(trial,data.trialsPerBlock) == 0)
  disp('check 14.5')
  save temp.mat;
        %save data (losing at most 5 ms right here)
%temp comment out too        
        savestruct([cur_dir '/data/' data.outname],data); %mat file
  disp('check 14.55')         
        %savestruct(data.outname,time); %mat file
%temporarily comment out 9/17/18    
save temp7.mat
        tmp = data.MyData; eval(['save ' cur_dir '/data/'  data.outname '.dat tmp -ascii -tabs']);
disp('check 14.6')        
        trialWithinBlock = trialWithinBlock+1;
    end%end for
 disp('check 15')     
catch exception1
	% ---------- Error Handling ---------- 
	% If there is an error in our code, we will end up here.

	% The try-catch block ensures that Screen will restore the display and return us
	% to the MATLAB prompt even if there is an error in our code.  Without this try-catch
	% block, Screen could still have control of the display when MATLAB throws an error, in
    % which case the user will not see the MATLAB prompt.
    clean_up    
    % Restore preferences
    %Screen('Preference', 'VisualDebugLevel', oldVisualDebugLevel);
    %Screen('Preference', 'SuppressAllWarnings', oldSupressAllWarnings);

	% We throw the error again so the user sees the error description.
	psychrethrow(psychlasterror);
    rethrow(exception1);
end    

clean_up  
clc
disp('Thank you for participating. Please let the experimenter know that you are finished.');

