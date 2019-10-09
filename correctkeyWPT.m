function correctkeyWPT(window,color,where,stim,feedback,trial,trialWithinBlock,fb)
%correctkey(window,color,where,stim,trial)
%
%tells subject which category label they should have selected
%
%input:
%window - window pointer
%color - structure containing color information
%sounds - structure containing wrongkey, ching - played if mean(data)<rt_crit, and buzz - played if mean(data)>= rt_crit
%where - structure containing location information
%
%5/22/05        swe     
%12/3/06    swe     modified to work with OpenGL-Psychtoolbox version 3.0.8 on OSX
%7/20/2010  swe     modified for focalBG - wm experiment to be run @ Berkeley on PC

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




disp('correctkey1'); save tempCC.mat   
switch stim.stim(trialWithinBlock,2)
case 1,
    %Load and display the image
    WeatherPattern = imread('Sun.jpg');
    WeatherPatternTexture = Screen('MakeTexture', window, WeatherPattern);
    % Draw the image to the screen, unless otherwise specified PTB will draw
    % the texture full size in the center of the screen. We first draw the
    % image in its correct orientation.
Screen('DrawTexture', window, WeatherPatternTexture, [], correctweatherdest, 0);

[normBoundsRect, offsetBoundsRect]= Screen('TextBounds', window, 'The Rain was correct');
Screen('DrawText',window,'The Sun was correct', where.xc-normBoundsRect(3)/2, where.yc+2*feedback.fb_size(1)-normBoundsRect(4)/2, color.textColor);


%Draw the pattern 
   WeatherPattern = imread([(num2str(stim.stim(trialWithinBlock,1))) '.jpg']);WeatherPatternTexture = Screen('MakeTexture', window, WeatherPattern);Screen('DrawTexture', window, WeatherPatternTexture, [], presentpatterndest, 0);
%Inform them if they get it correct or incorrect
if fb == 1; %correct
        %Screen('TextSize',window, stim.fbSize);
     	fb_string = 'CORRECT'; %TextWidth = Screen('TextWidth',window, fb_string);
        Screen('DrawText',window, fb_string, [950], [1225], color.green);
else %incorrect
        %Screen('TextSize',window, stim.fbSize);
     	fb_string = 'INCORRECT'; %TextWidth = Screen('TextWidth',window, fb_string);
        Screen('DrawText',window, fb_string, [950], [1225], color.red);
end


    Screen('Flip', window);
    WaitSecs(2);
case 2,
    %Load and display the image
    WeatherPattern = imread('Rain.jpg');
    WeatherPatternTexture = Screen('MakeTexture', window, WeatherPattern);
    % Draw the image to the screen, unless otherwise specified PTB will draw
    % the texture full size in the center of the screen. We first draw the
    % image in its correct orientation.
Screen('DrawTexture', window, WeatherPatternTexture, [], correctweatherdest, 0);

    
    [normBoundsRect, offsetBoundsRect]= Screen('TextBounds', window, 'The Rain was correct');
Screen('DrawText',window,'The Rain was correct', where.xc-normBoundsRect(3)/2, where.yc+2*feedback.fb_size(1)-normBoundsRect(4)/2, color.textColor);
    

%Draw the pattern 
   WeatherPattern = imread([(num2str(stim.stim(trialWithinBlock,1))) '.jpg']);WeatherPatternTexture = Screen('MakeTexture', window, WeatherPattern);Screen('DrawTexture', window, WeatherPatternTexture, [], presentpatterndest, 0);
%Inform them if they get it correct or incorrect
if fb == 1; %correct
        %Screen('TextSize',window, stim.fbSize);
     	fb_string = 'CORRECT'; %TextWidth = Screen('TextWidth',window, fb_string);
        Screen('DrawText',window, fb_string, [950], [1225], color.green);
else %incorrect
        %Screen('TextSize',window, stim.fbSize);
     	fb_string = 'INCORRECT'; %TextWidth = Screen('TextWidth',window, fb_string);
        Screen('DrawText',window, fb_string, [950], [1225], color.red);
end



Screen('Flip', window);
    
    WaitSecs(2);
otherwise,
    corrLabel = ['fix this later'];
end
disp('correctkey2'); save temp.mat   

%[normBoundsRect, offsetBoundsRect]= Screen('TextBounds', window, corrLabel);

disp('correctkey3'); save temp.mat   

%Screen('DrawText',window,corrLabel, where.xc-normBoundsRect(3)/2, where.yc+2*feedback.fb_size(1)-normBoundsRect(4)/2, color.textColor);

%Screen('Flip', window,[],clearmode);


