function [keyIsDown,response,endtime] = check_key(keyIsDown)


keyCode=0;
[keyIsDown,secs,keyCode]=KbCheck;
clear response endtime
if keyIsDown
    ind=find(keyCode>0);
    if length(ind)>1; keyCode(ind(1))=0; end; %hack to deal with simultaneous key press
    response = KbName(keyCode);
    endtime = GetSecs;

else
    response = 99; endtime = 99;
end
response=response(1);
%response=response;