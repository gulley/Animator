function [sweepVar, startVal, sweepRange] = splitCode(codeLine)
    % splitCode - Parses a given line of code and extracts variable name, initial value, and optional range
    % 
    % This function expects a line of code in one of the following formats:
    % 1. "x = 12" - Where 'x' is the variable name and '12' is the initial value.
    % 2. "x = 12 % 1..20" - Where 'x' is the variable name, '12' is the initial value, and '1..20' is the range.
    %
    % Outputs:
    % sweepVar - The extracted variable name (char).
    % startVal - The initial value of the variable (numeric).
    % sweepRange - A two-element vector specifying the range [start, end] (numeric).
    %
    % Example usage:
    % [varName, initialValue, range] = splitCode('x = 5 % 1..10')

    sweepVar = '';
    sweepRange = [];
    startVal = [];

    % Split the code line at '=' to separate the variable name and value
    codeParts = regexp(codeLine, '=', 'split');
    if length(codeParts) ~= 2
        % If the format is incorrect, return empty values
        return
    end
    
    % Remove all whitespace from the variable name for consistency
    sweepVar = stripWhitespace(codeParts{1});
    
    % Process the remaining part of the code line
    remainder = codeParts{2};
    codeParts = regexp(remainder, '%', 'split');
    startVal = str2num(codeParts{1});
    if length(codeParts) ~= 2
        % If there's no comment specifying the range, return the current values
        return
    end
    
    % Extract the range from the comment section
    remainder = codeParts{2};
    codeParts = regexp(remainder, '\.\.', 'split');
    if length(codeParts) == 2
        % Convert the range parts to numeric values and store them
        sweepRange = [str2num(codeParts{1}), str2num(codeParts{2})];
    end
    
end

function strOut = stripWhitespace(strIn)
    % stripWhitespace - Removes all whitespace from a string    
    strOut = regexprep(strIn, '\s', '');
end
