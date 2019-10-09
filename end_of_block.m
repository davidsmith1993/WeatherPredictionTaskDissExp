function blockNum = end_of_block(window,data,color,where,stim,blockNum)
%blockNum = end_of_block(window,data,color,where,stim,blockNum,currentCondition)
%
%tells subject that they pressed the wrong key
%
%input:
%window - window pointer
%color - structure containing color information
%where - structure containing location information
%blockNum - accepts current block number, increments, and returns
%
%12/3/06    swe     written to work with OpenGL-Psychtoolbox version 3.0.8 on OSX
%5/23/07    swe     modified for new button switch experiment (from splitCatExp_2rule_osxPT3_v2.m and button_switch_nr.m)
%4/17/12    swe     modified to provide end of block fb for inference training

string = ['You have completed block ' num2str(blockNum)]; 
%[normBoundsRect, offsetBoundsRect]= Screen('TextBounds', window, string);
Screen('DrawText',window,string, where.shift_from_edge, where.shift_from_edge, color.textColor);

% if currentCondition==1 || currentCondition==3%cat
    string = ['Percent correct for block ',int2str(blockNum),' was ',num2str(data.block_pc(blockNum)) '. Higher numbers are better (e.g., 100% is perfect).'];
    Screen('DrawText',window,string, where.shift_from_edge, stim.textSize+where.shift_from_edge, color.textColor);
% else %inf
%     string = ['Score for block ',int2str(blockNum),' was ',num2str(mean(data.block_rmse(blockNum,:))) '. Lower numbers are better (e.g., 0 is perfect).'];
%     Screen('DrawText',window,string, where.shift_from_edge, stim.textSize+where.shift_from_edge, color.textColor);
% end

string = ['You may take a break if you like. ']; 
Screen('DrawText',window,string, where.shift_from_edge, 2*stim.textSize+where.shift_from_edge, color.textColor);
blockNum = blockNum+1;

Screen('Flip', window,[],1);

space_bar(window,color,where,'continue.');