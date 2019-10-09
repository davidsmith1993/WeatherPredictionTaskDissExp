function space_bar(window,color,where,str,clearmode)
%function space_bar(window,color,str)
%
%prompt subject to press space bar to continue
%
%input:
%window - window pointer
%color - structure containing color information
%str - completion string for message
%
%5/22/05    swe     
%12/2/06    swe     modified to work with OpenGL-Psychtoolbox version 3.0.8 on OSX
%4/29/08    swe     added clearmode as optional argument (so screen not cleared on practice trials)


if nargin<5
    clearmode = 0;
end

try
    cont_string = ['Press space bar to ' str ];

    Screen('DrawText',window,cont_string,where.screenRect(1)+10,where.screenRect(4)-100,color.textColor);

    Screen('Flip', window,[],clearmode);

    while(KbCheck);end %only way I've found to clear previous keyboard response when response was made recently as in practice trials
    keyIsDown=0; response = 99;
 
    while keyIsDown==0 && response ~= ' ' 

        [keyIsDown,response,time.response] = check_key(keyIsDown);
    end %end while keyIsDown

    %while (getchar ~= ' ') end;
    Screen('Flip', window); %clear screen, assumes back buffer empty
    while(KbCheck);end
    %keyIsDown=0; 
    %while (keyIsDown==0); [keyIsDown,response,endtime] = check_key(keyIsDown); end;
    %while (getchar ~= ' ') end;
    %Screen(window,'FillRect',color.bgColor);
    %waitsecs(.2);
    %Screen(window,'FillRect', color.bgColor, where.bg_window); 
    %Screen('Flip', window);

catch
	% ---------- Error Handling ---------- 
	% If there is an error in our code, we will end up here.

	% The try-catch block ensures that Screen will restore the display and return us
	% to the MATLAB prompt even if there is an error in our code.  Without this try-catch
	% block, Screen could still have control of the display when MATLAB throws an error, in
	% which case the user will not see the MATLAB prompt.
	Screen('CloseAll');

	% Restores the mouse cursor.
	ShowCursor;
    Priority(0);
    ListenChar(0)
    
    % Restore preferences
    %Screen('Preference', 'VisualDebugLevel', oldVisualDebugLevel);
    %Screen('Preference', 'SuppressAllWarnings', oldSupressAllWarnings);

	% We throw the error again so the user sees the error description.
	psychrethrow(psychlasterror);
end    