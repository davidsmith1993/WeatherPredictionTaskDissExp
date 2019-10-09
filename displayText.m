function displayText(window, filename,color,where,stim,clearmode)
% draws the text in file <filename> to the screen.
%
%borrowed from Alan Robinson's website (UCSD), modified to work with OSX and PTB3
%
%2/20/07    swe     added clearmode as input parameter (0=clear next drawing surface; 1 = do not clear) (optional)
%

if nargin<6
    clearmode=0;
end

Screen('Flip', window);
textfid=fopen(filename);
if textfid==-1; escape('Q','The file you are trying to open in displayText.m does not exist.'); end;
lCounter = 1;
while 1
    tline = fgetl(textfid);
    if ~ischar(tline), break, end
    
    
    if numel(tline)>0 & tline(1) ~= '.'
        Screen('DrawText', window, tline, where.screenRect(1)+where.shift_from_edge, where.shift_from_edge+lCounter*2*stim.textSize, color.textColor,color.bgColor);
    end
    lCounter = lCounter + 1;
end
fclose(textfid);

% Updates the screen to reflect our changes to the window.
Screen('Flip', window,[],clearmode);


