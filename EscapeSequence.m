function out = escapeSequence(key,location)

out = 0;
beginTime = GetSecs;


if isequal(upper(key), 'Q')
    [keyIsDown,secs,keyCode] = KbCheck;
    while keyIsDown, [keyIsDown,secs,keyCode] = KbCheck; end;
    lastKey = keyCode;
    while (~keyIsDown) && (GetSecs-beginTime < 0.5)
        [keyIsDown,secs,keyCode] = KbCheck;
        lastKey = keyCode;
    end
    key = KbName(lastKey)
    
    if isequal(upper(key), 'P')
        out = 1;
        clean_up
        while(KbCheck);end %Wait for all keys to be released.
        error_text = ['user quit the experiment in ' location '. You may need to type "command" + "." in order to regain control.'];
        fprintf('\n%s',error_text);
        clear all
        clear mex
    else
        out = 0;
    end
else
    out = 0;
end

