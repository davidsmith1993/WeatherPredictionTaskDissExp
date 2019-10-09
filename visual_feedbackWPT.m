function time = visual_feedback(window,fb,color,where,sounds,feedback,stim,time,trial,trialWithinBlock, trainTest, blockNum, data)
%function visual_feedback(window,fb,color,where,sounds,feedback,stim,time)
%fb of '1' is correct 
%fb of '0' is incorrect
%fb of anything else is wrong key pressed
%
%9/01		swe	modified to clear playsnd at the beginning of every fn call in order to work on PC
%9/13/01	swe 	modified to present visual feedback
%10/22/02	swe modified to present auditory + visual fb for ERP experiment
%9/03       swe modified for conjunction experiment
%6/15/05    swe modified for wp task -- presents trial_fb
%8/10/05    swe modified for version 5
%10/16/06   swe     modified for split-brain study, no longer unpack structres b/c inefficient
%12/3/06    swe     modified to work with OpenGL-Psychtoolbox version 3.0.8 on OSX 
%5/24/12    swe     modified for stress cog trial timing requirements (2s trials)

if trainTest == 1
    %|| (trainTest == 1 && data.trainingCondition == 2 && blockNum < 5)
switch fb
    case 1, %correct
        %Screen('TextSize',window, stim.fbSize);
     	%fb_string = 'CORRECT'; TextWidth = Screen('TextWidth',window, fb_string);
        %Screen('DrawText',window, fb_string, where.xc-TextWidth/2, where.yc, color.green);
        
        %wavplay(sounds.Pos);
        %while GetSecs-time.response<time.fbDuration
        %    GetSecs;
        %end
        %screen(window,'FillRect', color.bgColor, where.bg_window); %draw over stimulus rather than clearing screen
        Screen('DrawTexture',window,feedback.correct,[],[where.xc-feedback.fb_size(2)/2, ...
                                         where.yc-feedback.fb_size(1)/2, ...
                                         where.xc+feedback.fb_size(2)/2, ...
                                         where.yc+feedback.fb_size(1)/2]);
        correctkeyWPT(window,color,where,stim,feedback,trial,trialWithinBlock,fb)
        
        [time.fb_begin time.fb_onset time.fb_end Missed Beampos]=...
            Screen('Flip', window, time.response+time.ifi,0); %clearmode = 0; insert one frame delay                                             
        
        Snd('Play',sounds.Pos,sounds.rate); sound_playing = 1;
        %Snd('Play',sounds.ching,sounds.ching_rate); sound_playing = 1; 
        %manually enforce fb duration rather than spending time to figure out mapping to duration variable in feedback_init.m
        while sound_playing; 
            time.fb_end = GetSecs;
            if (time.fb_end-time.fb_onset)>time.fbDuration;
                Snd('Quiet'); sound_playing=0; 
            end; 
        end; 
    case 0, %incorrect
        Screen('DrawTexture',window,feedback.wrong,[],[where.xc-feedback.fb_size(2)/2, ...
                                         where.yc-feedback.fb_size(1)/2, ...
                                         where.xc+feedback.fb_size(2)/2, ...
                                         where.yc+feedback.fb_size(1)/2]);
        correctkeyWPT(window,color,where,stim,feedback,trial,trialWithinBlock,fb)
        
        [time.fb_begin time.fb_onset time.fb_end Missed Beampos]=...
            Screen('Flip', window, time.response+time.ifi,0); %clearmode = 0; insert one frame delay                                     
        
        Snd('Play',sounds.Neg,sounds.rate);  sound_playing = 1; 
        %Snd('Play',sounds.buzz,sounds.buzz_rate); sound_playing = 1; 
        %manually enforce fb duration rather than spending time to figure out mapping to duration variable in feedback_init.m
        while sound_playing; 
            time.fb_end = GetSecs;
            if (time.fb_end-time.fb_onset)>time.fbDuration;
                Snd('Quiet'); sound_playing=0; 
            end; 
        end; 
        
    case 2, %invalid key
        clearmode=0;
        time = wrong_key(window,color,sounds,where,stim,time,clearmode);
    case 97, %right keys, wrong hand
        %Note: fb duration is unconstrained
        right_key_wrong_hand(window,color,sounds,where,stim);
        time.fb_end = GetSecs;
%	case 98, %prompt to respond; leave the stimulus up
%        screen(window,'TextSize', stim.textSize);
%  		fb_string = 'Please Respond'; TextWidth = SCREEN(window,'TextWidth', fb_string);
%        screen(window,'DrawText', fb_string, where.xc-TextWidth/2, where.message_position, color.red); 
	case 99, %too slow
        clearmode=0;
        time = too_slow(window,color,sounds,where,stim,time,clearmode);
    case -1, %no feedback
        time.fb_end = GetSecs;
        [time.fb_begin time.fb_onset time.fb_end Missed Beampos]=...
            Screen('Flip', window, time.response+time.ifi,0); 
        waiting=1;%manually equate timing on nofb trials
        while waiting;  
            time.fb_end = GetSecs;
            if (time.fb_end-time.fb_onset)>time.fbDuration;
                waiting=0; 
            end; 
        end; 

	otherwise,
  		%error('no fb')
end

else
        time.fb_end = GetSecs;
        [time.fb_begin time.fb_onset time.fb_end Missed Beampos]=...
            Screen('Flip', window, time.response+time.ifi,0); 
        waiting=1;%manually equate timing on nofb trials
        while waiting;  
            time.fb_end = GetSecs;
            if (time.fb_end-time.fb_onset)>time.fbDuration;
                waiting=0; 
            end; 
        end; 
end; 

%display fixation
string = '+';
[normBoundsRect, offsetBoundsRect]= Screen('TextBounds', window, string);
Screen('DrawText',window,string, where.xc, where.yc, color.textColor);
