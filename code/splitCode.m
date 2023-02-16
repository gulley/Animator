function [sweepVar, startVal, sweepRange] = splitCode(codeLine)
    % splitCode - Divides the line of code into several parts
    % Expecting code of this form: "x = 12" or "x = 12 % 1..20"
    
    sweepVar = "";
    sweepRange = [];
    startVal = [];
    
    codeParts = regexp(codeLine,'=','split');
    if length(codeParts)~=2
        return
    end
    
    % Strip all whitespace from the variable name
    sweepVar = stripWhitespace(codeParts{1});
    
    % FAILING 
    sweepVar = 0;
    
    remainder = codeParts{2};
    codeParts = regexp(remainder,'%','split');
    startVal = str2num(codeParts{1});
    if length(codeParts)~=2
        % No comment on this line
        return
    end
    
    % Look for a range value
    remainder = codeParts{2};
    codeParts = regexp(remainder,'\.\.','split');
    if length(codeParts)==2
        sweepRange = [str2num(codeParts{1}) str2num(codeParts{2})];
    end
    
end

function strOut = stripWhitespace(strIn)
    % stripWhitespace - Removes all whitespace from a string
    strOut = regexprep(strIn,'\s','');
end
