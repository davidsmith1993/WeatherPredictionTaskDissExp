function [show_instructions,doPracticeOnly] = instructsWPT(window,color,where,stim,time,feedback,sounds,data,doPracticeOnly,presExample,present_instructions, trainTest, blockNum, trialWithinBlock)
disp('instructs0'); save temp.mat  
%Screen res is 2560 x 1440

%Draw the sun/rain on either the left or the right (depending on col 4? in stim
%file?

%locations to present on eihter the left or the right
presentleftsource = [];
%presentleftdest = [600 1500 800 1700]
presentleftdest = [1600 600 1800 800];
presentrightsource = [];
%presentrightdest = [200 1700 300 1900]
presentrightdest = [1800 600 2000 800];
%Screen res is 2560 x 1440

%pattern location
presentpatterndest = [900 500 1400 900];

%correct weather location for study cond
correctweatherdest = [900 1000 1400 1200];

if trainTest == 1


%3/3/2019  dbs     modified for the weather prediction task
disp('instructs1'); save temp.mat  
if present_instructions > 0 %full instructions
    if data.trainingCondition == 1
        %1. basic written instructions
        displayText(window, 'instructs1_study.txt',color,where,stim,0);
        while(KbCheck);end %Wait for all keys to be released.
        KbWait;
    clearmode=0;
    %Show examples
    disp('instructs2'); save temp.mat  

    Weather = imread('sun.jpg')
    WeatherTexture = Screen('MakeTexture', window, Weather);Screen('DrawTexture', window, WeatherTexture, [], correctweatherdest, 0);
    WeatherPattern = imread('1.jpg');WeatherPatternTexture = Screen('MakeTexture', window, WeatherPattern);Screen('DrawTexture', window, WeatherPatternTexture, [], presentpatterndest, 0);
    SunWeatherPattern = imread('sun.jpg'); SunWeatherPatternTexture = Screen('MakeTexture', window, SunWeatherPattern);Screen('DrawTexture', window, SunWeatherPatternTexture, presentrightsource, presentrightdest, 0);
    RainWeatherPattern = imread('rain.jpg'); RainWeatherPatternTexture = Screen('MakeTexture', window, RainWeatherPattern);Screen('DrawTexture', window, RainWeatherPatternTexture, presentleftsource, presentleftdest, 0);
    Screen('Flip', window);
    WaitSecs(4);
disp('instructs3'); save temp.mat      
space_bar(window,color,where,'see another example.',clearmode);

    %Load and display the image
    Weather = imread('rain.jpg')
    WeatherTexture = Screen('MakeTexture', window, Weather);Screen('DrawTexture', window, WeatherTexture, [], correctweatherdest, 0);
    WeatherPattern = imread('4.jpg');WeatherPatternTexture = Screen('MakeTexture', window, WeatherPattern);Screen('DrawTexture', window, WeatherPatternTexture, [], presentpatterndest, 0);
    SunWeatherPattern = imread('sun.jpg'); SunWeatherPatternTexture = Screen('MakeTexture', window, SunWeatherPattern);Screen('DrawTexture', window, SunWeatherPatternTexture, presentleftsource, presentleftdest, 0);
    RainWeatherPattern = imread('rain.jpg'); RainWeatherPatternTexture = Screen('MakeTexture', window, RainWeatherPattern);Screen('DrawTexture', window, RainWeatherPatternTexture, presentrightsource, presentrightdest, 0);
    Screen('Flip', window);
    WaitSecs(4);
space_bar(window,color,where,'continue with instructions.',clearmode);        

disp('instructs4'); save temp.mat  
        
 Weather = imread('sun.jpg')
    WeatherTexture = Screen('MakeTexture', window, Weather);Screen('DrawTexture', window, WeatherTexture, [], correctweatherdest, 0);
    WeatherPattern = imread('7.jpg');WeatherPatternTexture = Screen('MakeTexture', window, WeatherPattern);Screen('DrawTexture', window, WeatherPatternTexture, [], presentpatterndest, 0);
    SunWeatherPattern = imread('sun.jpg'); SunWeatherPatternTexture = Screen('MakeTexture', window, SunWeatherPattern);Screen('DrawTexture', window, SunWeatherPatternTexture, presentrightsource, presentrightdest, 0);
    RainWeatherPattern = imread('rain.jpg'); RainWeatherPatternTexture = Screen('MakeTexture', window, RainWeatherPattern);Screen('DrawTexture', window, RainWeatherPatternTexture, presentleftsource, presentleftdest, 0);
    Screen('Flip', window);
    WaitSecs(4);
space_bar(window,color,where,'continue with instructions.',clearmode);        

disp('instructs5'); save temp.mat  

         %2. explain feedback, etc...
        displayText(window, 'instructs2.txt',color,where,stim,0);
        while(KbCheck);end %Wait for all keys to be released.
        KbWait;
  disp('2b')
        %feedback following correct trial
        time.response = GetSecs;
        trial=1;
        time = visual_feedbackWPT(window,1,color,where,sounds,feedback,stim,time,trial,trialWithinBlock,trainTest,blockNum, data);
  disp('2c')

        %feedback following incorrect trial
        displayText(window,'instructs3.txt',color,where,stim); while(KbCheck);end; KbWait;
        trial=2;
        time = visual_feedbackWPT(window,0,color,where,sounds,feedback,stim,time,trial,trialWithinBlock,trainTest,blockNum, data);

  disp('2d')
        %wrong key
        displayText(window,'instructs4.txt',color,where,stim); while(KbCheck);end; KbWait;
        trial=2;
        time = visual_feedbackWPT(window,2,color,where,sounds,feedback,stim,time,trial,trialWithinBlock,trainTest,blockNum, data);
disp('2e')


        %too long
        displayText(window,'instructs5.txt',color,where,stim); while(KbCheck);end; KbWait;
        trial=2;
        time = visual_feedbackWPT(window,99,color,where,sounds,feedback,stim,time,trial,trialWithinBlock,trainTest,blockNum, data);
disp('2f')
    
        %summary
        str = ['instructs_summary.txt'];
        displayText(window,str,color,where,stim); while(KbCheck);end; KbWait;
        
            disp('3')
            
            
    else %test cond
        
        
        
               %1. basic written instructions
        displayText(window, 'instructs1.txt',color,where,stim,0);
        while(KbCheck);end %Wait for all keys to be released.
        KbWait;
    clearmode=0;
    %Show examples
    disp('instructs2'); save temp.mat  

   % Weather = imread('sun.jpg')
   % WeatherTexture = Screen('MakeTexture', window, Weather);Screen('DrawTexture', window, WeatherTexture, [], correctweatherdest, 0);
    WeatherPattern = imread('1.jpg');WeatherPatternTexture = Screen('MakeTexture', window, WeatherPattern);Screen('DrawTexture', window, WeatherPatternTexture, [], presentpatterndest, 0);
    SunWeatherPattern = imread('sun.jpg'); SunWeatherPatternTexture = Screen('MakeTexture', window, SunWeatherPattern);Screen('DrawTexture', window, SunWeatherPatternTexture, presentrightsource, presentrightdest, 0);
    RainWeatherPattern = imread('rain.jpg'); RainWeatherPatternTexture = Screen('MakeTexture', window, RainWeatherPattern);Screen('DrawTexture', window, RainWeatherPatternTexture, presentleftsource, presentleftdest, 0);
    Screen('Flip', window);
    WaitSecs(4);
disp('instructs3'); save temp.mat      
space_bar(window,color,where,'see another example.',clearmode);

    %Load and display the image
   % Weather = imread('rain.jpg')
   % WeatherTexture = Screen('MakeTexture', window, Weather);Screen('DrawTexture', window, WeatherTexture, [], correctweatherdest, 0);
    WeatherPattern = imread('4.jpg');WeatherPatternTexture = Screen('MakeTexture', window, WeatherPattern);Screen('DrawTexture', window, WeatherPatternTexture, [], presentpatterndest, 0);
    SunWeatherPattern = imread('sun.jpg'); SunWeatherPatternTexture = Screen('MakeTexture', window, SunWeatherPattern);Screen('DrawTexture', window, SunWeatherPatternTexture, presentleftsource, presentleftdest, 0);
    RainWeatherPattern = imread('rain.jpg'); RainWeatherPatternTexture = Screen('MakeTexture', window, RainWeatherPattern);Screen('DrawTexture', window, RainWeatherPatternTexture, presentrightsource, presentrightdest, 0);
    Screen('Flip', window);
    WaitSecs(4);
space_bar(window,color,where,'continue with instructions.',clearmode);        

disp('instructs4'); save temp.mat  
        
 Weather = imread('sun.jpg')
   % WeatherTexture = Screen('MakeTexture', window, Weather);Screen('DrawTexture', window, WeatherTexture, [], correctweatherdest, 0);
    WeatherPattern = imread('7.jpg');WeatherPatternTexture = Screen('MakeTexture', window, WeatherPattern);Screen('DrawTexture', window, WeatherPatternTexture, [], presentpatterndest, 0);
    SunWeatherPattern = imread('sun.jpg'); SunWeatherPatternTexture = Screen('MakeTexture', window, SunWeatherPattern);Screen('DrawTexture', window, SunWeatherPatternTexture, presentrightsource, presentrightdest, 0);
    RainWeatherPattern = imread('rain.jpg'); RainWeatherPatternTexture = Screen('MakeTexture', window, RainWeatherPattern);Screen('DrawTexture', window, RainWeatherPatternTexture, presentleftsource, presentleftdest, 0);
    Screen('Flip', window);
    WaitSecs(4);
space_bar(window,color,where,'continue with instructions.',clearmode);        

disp('instructs5'); save temp.mat  

         %2. explain feedback, etc...
        displayText(window, 'instructs2.txt',color,where,stim,0);
        while(KbCheck);end %Wait for all keys to be released.
        KbWait;
  disp('2b')
        %feedback following correct trial
        time.response = GetSecs;
        trial=1;
        time = visual_feedbackWPT(window,1,color,where,sounds,feedback,stim,time,trial,trialWithinBlock,trainTest,blockNum, data);
  disp('2c')

        %feedback following incorrect trial
        displayText(window,'instructs3.txt',color,where,stim); while(KbCheck);end; KbWait;
        trial=2;
        time = visual_feedbackWPT(window,0,color,where,sounds,feedback,stim,time,trial,trialWithinBlock,trainTest,blockNum, data);

  disp('2d')
        %wrong key
        displayText(window,'instructs4.txt',color,where,stim); while(KbCheck);end; KbWait;
        trial=2;
        time = visual_feedbackWPT(window,2,color,where,sounds,feedback,stim,time,trial,trialWithinBlock,trainTest,blockNum, data);
disp('2e')


        %too long
        displayText(window,'instructs5.txt',color,where,stim); while(KbCheck);end; KbWait;
        trial=2;
        time = visual_feedbackWPT(window,99,color,where,sounds,feedback,stim,time,trial,trialWithinBlock,trainTest,blockNum, data);
disp('2f')
    
        %summary
        str = ['instructs_summary.txt'];
        displayText(window,str,color,where,stim); while(KbCheck);end; KbWait;
        
            disp('3') 
        
        
        
%         
%         else %present brief reminder instructions
%             %summary
%             str = ['instructs_pretask_summary.txt'];
%             displayText(window,str,color,where,stim); while(KbCheck);end; KbWait;
        
    end
    disp('4')

end

else

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

end
disp('6')
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


        
    