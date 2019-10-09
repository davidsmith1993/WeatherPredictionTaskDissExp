function right_key_wrong_hand(window,color,sounds,where,stim)
%right_key_wrong_hand(window,color,sounds,where,stim)
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

string = 'Right keys, but you used the wrong hand.'; 
[normBoundsRect, offsetBoundsRect]= Screen('TextBounds', window, string);
SCREEN('DrawText',window,string, where.xc-normBoundsRect(3)/2, where.yc-normBoundsRect(4)/2, color.textColor);

string = 'If the stimulus is on the right, use the labeled keys on the right to respond';
[normBoundsRect, offsetBoundsRect]= Screen('TextBounds', window, string);
SCREEN('DrawText',window,string, where.xc-normBoundsRect(3)/2, 2*stim.textSize+where.yc-normBoundsRect(4)/2, color.textColor);

string = 'If the stimulus is on the left, use the labeled keys on the left to respond';
[normBoundsRect, offsetBoundsRect]= Screen('TextBounds', window, string);
SCREEN('DrawText',window,string, where.xc-normBoundsRect(3)/2, 3*stim.textSize+where.yc-normBoundsRect(4)/2, color.textColor);

Screen('Flip', window,[],1);

snd('Play',sounds.WrongKey,sounds.rate); Snd('Wait');


space_bar(window,color,where,'continue to the next trial.');
