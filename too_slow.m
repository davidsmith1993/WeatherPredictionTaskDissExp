function time = too_slow(window,color,sounds,where,stim,time,doNotClear)
%function time = too_slow(window,color,sounds,where,stim,time,doNotClear)
%
%tells subject that they pressed the wrong key
%
%input:
%window - window pointer
%color - structure containing color information
%sounds - structure containing wrongkey, ching - played if mean(data)<rt_crit, and buzz - played if mean(data)>= rt_crit
%where - structure containing location information
%
%5/22/05        swe     
%12/3/06    swe     modified to work with OpenGL-Psychtoolbox version 3.0.8 on OSX
 %9/4/15         swe     modified slightly for using flip on pc.
 
if nargin<7
    doNotClear = 0;
end

string = 'Too slow '; 
[normBoundsRect, offsetBoundsRect]= Screen('TextBounds', window, string);
Screen('DrawText',window,string, where.xc-normBoundsRect(3)/2, where.yc-normBoundsRect(4)/2, color.textColor);

string = ['Please try to respond within ' num2str(time.responseDeadline) ' seconds'];
[normBoundsRect, offsetBoundsRect]= Screen('TextBounds', window, string);
Screen('DrawText',window,string, where.xc-normBoundsRect(3)/2, 2*stim.textSize+where.yc-normBoundsRect(4)/2, color.textColor);

[time.fb_begin time.fb_onset time.fb_end Missed Beampos]=...
    Screen('Flip', window, time.response+time.ifi, doNotClear);    
Snd('Play',sounds.WrongKey,sounds.rate); 
sound_playing = 1; 
%manually enforce fb duration rather than spending time to figure out mapping to duration variable in feedback_init.m
while sound_playing; 
    time.fb_end = GetSecs;
    if (time.fb_end-time.fb_onset)>time.fbDuration;
        Snd('Quiet'); sound_playing=0; 
    end; 
end; 

%time = space_bar(window,color,where,'continue to the next trial.',time,doNotClear);

