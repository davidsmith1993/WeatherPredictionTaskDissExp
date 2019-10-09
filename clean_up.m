function clean_up
%function clean_up
%
%clean up the mess

%FlushEvents('keyDown');
Screen('CloseAll');
clear mex
Priority(0); %lets other programs play
ShowCursor; %Restores the mouse cursor.
%ListenChar(0); %turns keyboard output back on
