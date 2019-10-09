function [time, x, y] = present_stimWPT(window,data,color,where,stim,trialWithinBlock,trial,time,presExample,clearmode,trainTest, blockNum)

%Screen res is 2560 x 1440

%Draw the sun/rain on either the left or the right (depending on col 4? in stim
%file?

%locations to present on eihter the left or the right
presentleftsource = []
%presentleftdest = [600 1500 800 1700]
presentleftdest = [1600 600 1800 800]
presentrightsource = []
%presentrightdest = [200 1700 300 1900]
presentrightdest = [1800 600 2000 800]
%Screen res is 2560 x 1440

%pattern location
presentpatterndest = [900 500 1400 900]

%correct weather location for study cond
correctweatherdest = [900 1000 1400 1200]

%displays the weather cards
disp('presenntstim0'); save temp.mat
try
    
    Screen('Flip', window);
    %Screen('DrawTexture',window,grating.g,[], grating.rect); %orientation and sf
    Screen('DrawingFinished', window);
    if ~presExample
        if trialWithinBlock==1; %synchronize on first trial
           [time.stim_flip_begin time.stim_onset time.stim_flip_end Missed Beampos]=...
            Screen('Flip', window, time.starttime + time.initial_delay,clearmode); %clearmode = 0;
        else
           [time.stim_flip_begin time.stim_onset time.stim_flip_end Missed Beampos]=...
            Screen('Flip', window, time.fb_end + time.ITI-time.ifi,clearmode); %clearmode = 0;
         
        end
    else %don't clear screen on practice trials
         [time.stim_flip_begin time.stim_onset time.stim_flip_end Missed Beampos]= ...
                Screen('Flip', window, [],clearmode); %if clearmode = 1, "too slow" appears on the screen. i have no idea why. i cannot find where this text would have been drawn previously       
    end
disp('presenntstim0.1'); save temp.mat    
   

%If study condition we show the sun/rain with (above?) the cards    
if (data.trainingCondition == 1 && trainTest == 1); %Study
    
    if (stim.stim(trialWithinBlock,2)) == 1;
        Weather = imread('sun.jpg')
    else
        Weather= imread('rain.jpg')
    end   
     WeatherTexture = Screen('MakeTexture', window, Weather);Screen('DrawTexture', window, WeatherTexture, [], correctweatherdest, 0);
    string = ['The correct weather pattern'];
     Screen('DrawText',window,string, [950], [1225], color.textColor);
    %draw the card patterns
    WeatherPattern = imread([(num2str(stim.stim(trialWithinBlock,1))) '.jpg']);WeatherPatternTexture = Screen('MakeTexture', window, WeatherPattern);Screen('DrawTexture', window, WeatherPatternTexture, [], presentpatterndest, 0);
  
%Draw the sun/rain on either the left or the right (depending on col 4? in stim
%file?
%

if (stim.stim(trialWithinBlock,4) == 1) %present the sun on the right
    SunWeatherPattern = imread('sun.jpg'); SunWeatherPatternTexture = Screen('MakeTexture', window, SunWeatherPattern);Screen('DrawTexture', window, SunWeatherPatternTexture, presentrightsource, presentrightdest, 0);
    RainWeatherPattern = imread('rain.jpg'); RainWeatherPatternTexture = Screen('MakeTexture', window, RainWeatherPattern);Screen('DrawTexture', window, RainWeatherPatternTexture, presentleftsource, presentleftdest, 0);
else %present the sun on the left
    SunWeatherPattern = imread('sun.jpg'); SunWeatherPatternTexture = Screen('MakeTexture', window, SunWeatherPattern);Screen('DrawTexture', window, SunWeatherPatternTexture, presentleftsource, presentleftdest, 0);
    RainWeatherPattern = imread('rain.jpg'); RainWeatherPatternTexture = Screen('MakeTexture', window, RainWeatherPattern);Screen('DrawTexture', window, RainWeatherPatternTexture, presentrightsource, presentrightdest, 0);
end 

    % Wait for 5 seconds

    string = ['Do the cards predict the sun or the rain?'];
    Screen('DrawText',window,string, [1600], [800], color.textColor);
    
         if trial == 1
        [time.stim_flip_begin time.stim_onset1 time.stim_flip_end Missed Beampos]=...
            Screen('Flip', window, time.starttime + time.initial_delay,clearmode); 
        else
           [time.stim_flip_begin time.stim_onset1 time.stim_flip_end Missed Beampos]=...
            Screen('Flip', window, time.fb_end + time.ITI-time.ifi,clearmode); 
         
        end

        ShowCursor('Arrow');
        SetMouse(where.xc-200,where.yc);
        clicks=0; keyIsDown=0;
        while ~clicks; 
            [clicks,x,y] = GetClicks(window); 
            [keyIsDown,response,time.response] = check_key(keyIsDown); keyIsDown
            if keyIsDown ~= 0
                EscapeSequence(response,'getResponse.m');
            end
        end
        time.response = GetSecs;
        HideCursor;

        [time.stim_flip_begin time.stim_onset time.stim_flip_end Missed Beampos]=...
            Screen('Flip', window, time.stim_flip_end - time.ifi,clearmode); 
          
    
    
    
else
%Test Condition   %traintest == 2
  %Something to select the actual pattern
disp('presenntstim1'); save temp.mat
    WeatherPattern = imread([(num2str(stim.stim(trialWithinBlock,1))) '.jpg']);WeatherPatternTexture = Screen('MakeTexture', window, WeatherPattern);Screen('DrawTexture', window, WeatherPatternTexture, [], presentpatterndest, 0);
    
if (stim.stim(trialWithinBlock,4) == 1) %present the sun on the right
    SunWeatherPattern = imread('sun.jpg'); SunWeatherPatternTexture = Screen('MakeTexture', window, SunWeatherPattern);Screen('DrawTexture', window, SunWeatherPatternTexture, presentrightsource, presentrightdest, 0);
    RainWeatherPattern = imread('rain.jpg'); RainWeatherPatternTexture = Screen('MakeTexture', window, RainWeatherPattern);Screen('DrawTexture', window, RainWeatherPatternTexture, presentleftsource, presentleftdest, 0);
else %present the sun on the left
    SunWeatherPattern = imread('sun.jpg'); SunWeatherPatternTexture = Screen('MakeTexture', window, SunWeatherPattern);Screen('DrawTexture', window, SunWeatherPatternTexture, presentleftsource, presentleftdest, 0);
    RainWeatherPattern = imread('rain.jpg'); RainWeatherPatternTexture = Screen('MakeTexture', window, RainWeatherPattern);Screen('DrawTexture', window, RainWeatherPatternTexture, presentrightsource, presentrightdest, 0);
end 

%we also need to show the cumulative percent correct at the bottom of the
%screen
    string = ['Do the cards predict the sun or the rain?'];
    Screen('DrawText',window,string, [1600], [800], color.textColor);

if trainTest == 1;
currentCondition = 2;
             out = comp_pc_rt_trial(data,trial,currentCondition);
             data.block_pc(blockNum,:)=out(2,:); data.block_rt(blockNum,:)=out(1,:);

  string = ['Percent correct is ',num2str(data.block_pc(blockNum)) '. Higher numbers are better (e.g., 100% is perfect).'];
  Screen('DrawText',window,string, [500], [1200], color.textColor);
end
%Screen('DrawTexture', windowPointer, texturePointer [,sourceRect] [,destinationRect] [,rotationAngle] [, filterMode] [,
%globalAlpha] [, modulateColor] [, textureShader] [, specialFlags] [, auxParameters]);

% 
%     left
%     The x-coordinate of the upper-left corner of the rectangle.
%     top
%     The y-coordinate of the upper-left corner of the rectangle
%     right
%     The x-coordinate of the lower-right corner of the rectangle
%     bottom
%     The y-coordinate of the lower-right corner of the rectangle.

        if trial == 1
        [time.stim_flip_begin time.stim_onset1 time.stim_flip_end Missed Beampos]=...
            Screen('Flip', window, time.starttime + time.initial_delay,clearmode); 
        else
           [time.stim_flip_begin time.stim_onset1 time.stim_flip_end Missed Beampos]=...
            Screen('Flip', window, time.fb_end + time.ITI-time.ifi,clearmode); 
         
        end

        ShowCursor('Arrow');
        SetMouse(where.xc-200,where.yc);
        clicks=0; keyIsDown=0;
        while ~clicks; 
            [clicks,x,y] = GetClicks(window); 
            [keyIsDown,response,time.response] = check_key(keyIsDown); keyIsDown
            if keyIsDown ~= 0
                EscapeSequence(response,'getResponse.m');
            end
        end
        time.response = GetSecs;
        HideCursor;

        [time.stim_flip_begin time.stim_onset time.stim_flip_end Missed Beampos]=...
            Screen('Flip', window, time.stim_flip_end - time.ifi,clearmode); 
       
%Screen('Flip', window);   
    
end
catch
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
end   

