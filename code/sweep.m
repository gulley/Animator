function sweep(filename, codeLine, sweepRangeText, lineNumber, ...
        nSteps, animationOption, reverseFlag, ...
        saveAnimFlag, gifFileName, framesPerSecond)
    %SWEEP Perform a parameter sweep for a section of code
    
    sweepRange = findSweepRange(sweepRangeText);
    
    codeParts = regexp(codeLine,'=','split');
    % Strip all whitespace from the variable name
    sweepVar = regexprep(codeParts{1},'\s','');
    
    target = [sweepVar '\s*=\s*-?\.?\d'];
    
    % Get handle to editor
    edit(filename);
    hEditor = matlab.desktop.editor.getActive;
    
    sweepVals = smoothSteps(sweepRange,nSteps,animationOption);
    
    hEditor.goToLine(lineNumber);
    code = char(hEditor.Text);
    [posStart,posStop] = findLineStartAndStop (hEditor,lineNumber);
    codeLine = code(posStart:posStop);
    if isempty(regexp(codeLine,target,'once'))
        disp('Line doesn''t match expected assignment')
        return
    end
    
    if saveAnimFlag
        % Animation initialization
        delayTime = 1/framesPerSecond;
        firstFrame = true;
        animFilename = fullfile(pwd,gifFileName);                
    end
    
    if reverseFlag
        sweepValsReversed = fliplr(sweepVals);
        % Remove the ends to make the animation as smooth as possible
        sweepValsReversed([1 end]) = [];
        sweepVals = [sweepVals sweepValsReversed];
        disp(' ')
    end
    
    for n = 1:length(sweepVals)
        
        replaceLine(hEditor,lineNumber,sweepVar,sweepRange,sweepVals(n),false)
        code = char(hEditor.Text);
        
        % Grab the code from the current section
        % Split it into sections
        code2 = regexprep(code,'\n%%','\nxxx-cellbreak-xxx%%');
        sections = regexp(code2,'xxx-cellbreak-xxx','split');
        
        sectionStarts = cumsum([1 cellfun(@length,sections)]);
        sectionIndex = find(posStart >= sectionStarts,1,'last');
        
        sectionCode = sections{sectionIndex};
        
        % Evaluate it
        evalin('base',sectionCode)
        drawnow update
        
        if saveAnimFlag
            % Save a frame
            im = getframe(gcf);
            [A,map] = rgb2ind(im.cdata,256);
            if firstFrame
                firstFrame = false;
                try
                    imwrite(A,map,animFilename,'LoopCount',Inf,'DelayTime',delayTime);
                catch ME
                    disp(ME.message)
                    return
                end
            else
                imwrite(A,map,animFilename,'WriteMode','append','DelayTime',delayTime);
            end
        end
        
    end
    
    % Sweep is complete. Now replace the range in the comments.
    commentFlag = true;
    replaceLine(hEditor,lineNumber,sweepVar,sweepRange,sweepRange(1),commentFlag)
    
end


% ==============================================================================
function sweepRange = findSweepRange(sweepRangeText)
    codeParts = regexp(sweepRangeText,'\.\.','split');
    if length(codeParts)==2
        sweepRange = [str2double(codeParts{1}) str2double(codeParts{2})];
    end
end


% ==============================================================================
function vals = smoothSteps(sweepRange,nPts, animationOption)
    % Set animation velocity profile
    
    switch animationOption
        case 1
            % smooth animation
            y = sinusoid(nPts);
            vals = interp1([0 1],sweepRange,y);
        case 2
            % sharp animation
            vals = linspace(sweepRange(1),sweepRange(2),nPts);
        otherwise
            error('Unknown animation option')
    end
    
end


% ==============================================================================
function y = sinusoid(nPts)
    tx = pi/2;
    t = linspace(-tx,tx,nPts);
    y = sin(t);
    y = (y+1)/2;
end


% ==============================================================================
function replaceLine(hEditor,lineNumber,sweepVar,sweepRange,sweepVal,commentFlag)
    
    % BUILD THE NEW LINE
    % Form the new line based on range
    
    lastColumn = 60;
    
    codepart1 = sprintf('%s = %s;', ...
        sweepVar, num2str(sweepVal));
    if commentFlag
        codepart2 = sprintf('%% %s .. %s', ...
            num2str(sweepRange(1)), num2str(sweepRange(2)));
        extraspaceLen = lastColumn - length(codepart1) - length(codepart2);
        extraspace = char(32*ones(1,extraspaceLen));
        newCodeLine = [codepart1 extraspace codepart2];
    else
        newCodeLine = codepart1;
    end
    
    % REPLACE THE OLD LINE
    % Find the positions corresponding to the beginning and end of the line
    [posStart,posStop] = findLineStartAndStop (hEditor,lineNumber);
    
    txt = hEditor.Text;
    newText = [txt(1:(posStart-1)) newCodeLine txt(posStop:end)];
    hEditor.Text = newText;
    
    hEditor.goToLine(lineNumber);
    
end


% ==============================================================================
function [posStart,posStop] = findLineStartAndStop (hEditor,lineNum)
    % Find the positions corresponding to the beginning and end of the line
    
    posStart = matlab.desktop.editor.positionInLineToIndex(hEditor,lineNum,1);
    posStop = matlab.desktop.editor.positionInLineToIndex(hEditor,lineNum,10000);
    
end