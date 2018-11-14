function mtrix2excel(filename,A,colnames,sheetname)
 xlsheets(sheetname,filename);
  % Save into spreadsheet myfile.xlsx
 header = 'The classification results';
%  colnames = {'1st','2nd','3rd','4th','5th'};
 xlswrite2(A,header,colnames,filename,char(sheetname));

 function xlswrite2(m,header,colnames,filename,sheetname)
% xlswrite     Easily create an Excel spreadsheet from MATLAB
%
%  xlswrite(m,header,colnames,filename) creates a Microsoft Excel spreadsheet using
%  the MATLAB ActiveX interface.  Microsoft Excel is required.
%
%Inputs:
%    m          Matrix to write to file
% (Optional):
%    header     String of header information.  Use cell array for multiple lines
%                  DO NOT USE multiple row character arrays!!
%    colnames   (Cell array of strings) Column headers.  One cell element per column
%    filename   (string) Name of Excel file.  If not specified, contents will
%                  be opened in Excel.
%    sheetname:  Name of sheet to write data to . The default is 'Sheet1'
%                       if specified, a sheet with the specified name must
%                       exist
%
% ex:
%   m = rand(100,4);
%   header = 'my data';
%   colnames = {'Ch1','Ch2','Ch3','Ch4'};
%
%   % Save into spreadsheet myfile.xlsx
%   xlswrite(m,header,colnames,'myfile.xlsx');
%
%   % Open in a new spreadsheet, since filename not specified
%   xlswrite(m,header,colnames);
%
% ex 2:
%      filename = 'xlssample.xlsx';          % can be named without '.xls'
%      sheetname = 'Sheet2';
%      header = 'MATLAB wrote this file';
%      colnames = {'1st','2nd','3rd','4th','5th'};
%      m = rand(10,5);
%      xlswrite(m,header,colnames,filename,sheetname)


% Michelle Hirsch
% (c) 2001-2014 The MathWorks, Inc.

% Parse inputs
if nargin<2
    header = [];
end;

if nargin<3
    colnames = {};
end;

if nargin<4 || isempty(filename)
    visible = 1;    % Not saving to a file, so make Excel visible
    filename = '';
else
    visible = 0;    % Saving to a file.  Keep Excel hidden
end;

if nargin < 5 || isempty(sheetname)
    sheetname = 'Sheet1';
end;

[nr,nc] = size(m);
if nc>256
    error('Matrix is too large.  Excel only supports 256 columns');
end;

% Open Excel, add workbook, change active worksheet, 
% get/put array, save.
% First, open an Excel Server.
Excel = actxserver('Excel.Application');

% Three cases:
% * Open a new workbook, but don't save (filename is empty)
% * Open a new workbook, save with given file name
% * Open an existing workbook
if isempty(filename)
    % Insert a new workbook.
    op = invoke(Excel.Workbooks, 'Add');
    
elseif exist(filename,'file')==0
    % The following case if file does not exist (Creating New File)
    op = invoke(Excel.Workbooks,'Add');
    invoke(op, 'SaveAs', [pwd filesep filename]);
    new = 1;	% Flag to check during debugging, apparently.
else
    % The following case if file does exist (Opening File)
    disp(['Opening Excel File ...(' filename ')']);
    op = invoke(Excel.Workbooks, 'open', [pwd filesep filename]);
    new = 0;	% Flag to check during debugging, apparently.
end

%If the user does not specify a filename, we'll make Excel visible
%If they do, we'll just save the file and quit Excel without ever making
% it visible
set(Excel, 'Visible', visible);      %You might want to hide this if you autosave the file



% Make the specified sheet active.
try 
    Sheets = Excel.ActiveWorkBook.Sheets;
    target_sheet = get(Sheets, 'Item', sheetname);
catch
    % Error if the sheet doesn't exist.  It would be nice to create it, but
    % I'm too lazy.
    % The alternative to try/catch is to call xlsfinfo to see if the sheet exists, but
    % that's really slow.
    error(['Sheet ' sheetname ' does not exist!']);
end;

invoke(target_sheet, 'Activate');

[nr,nc] = size(m);
if nc>256
    error('Matrix is too large.  Excel only supports 256 columns');
end;



%Write header
Activesheet = Excel.Activesheet;
if isempty(header)
    nhr=0;
elseif iscell(header)
    nhr = length(header);       %Number header rows
    for ii=1:nhr
        ActivesheetRange = get(Activesheet,'Range',['A' num2str(ii)],['A' num2str(ii)]);
        set(ActivesheetRange, 'Value', header{ii});
    end;
else
    nhr = 1;                   %Number header rows
    ActivesheetRange = get(Activesheet,'Range','A1','A1');
    set(ActivesheetRange, 'Value', header);
end;


%Add column names

if ~isempty(colnames)
    nhr = nhr + 1;      %One extra column name
    ncolnames = length(colnames);
    for ii=1:ncolnames
        colname = localComputLastCol('A',ii);
        %    cellname = [char(double('A')+ii-1) num2str(nhr+1)];
        cellname = [colname num2str(nhr)];
        ActivesheetRange = get(Activesheet,'Range',cellname,cellname);
        set(ActivesheetRange, 'Value', colnames{ii});
    end;
end;


% Put a MATLAB array into Excel.
FirstRow = nhr+1;           %You can change the first data row here.  I start right after the headers
LastRow = FirstRow+nr-1;
FirstCol = 'A';         %You can change the first column here
LastCol = localComputLastCol(FirstCol,nc);
ActivesheetRange = get(Activesheet,'Range',[FirstCol num2str(FirstRow)],[LastCol num2str(LastRow)]);
set(ActivesheetRange, 'Value', m);



% If user specified a filename, save the file and quit Excel

% If user specified a filename, save the file and quit Excel
if ~isempty(filename)
    [pathstr,name,ext] = fileparts(filename);
    if isempty(pathstr)
        pathstr = pwd;
    end;
    
invoke(op, 'Save');
%     invoke(Workbook, 'SaveAs', [pathstr filesep name ext]);
    invoke(Excel, 'Quit');
    
    [pathstr,name,ext] = fileparts(filename);
    disp(['Excel file ' name '.xls has been created.']);
end;

%Delete the ActiveX object
delete(Excel)

% localComputLastCol - Computes the last column that will have data written to it
% in Excel, given the letter(s) of the first column and the number of columns to write.
% Modification of Michelle Hirsch's code 
% by Mark Hayworth, The Procter & Gamble Company, September 2006.
function LastColumnLetters = localComputLastCol(FirstCol, numberOfColumnsToWrite)
	% Convert to upper case.
	FirstCol = upper(FirstCol);
	
	if length(FirstCol) == 1 
		FirstColOffset = double(FirstCol) - double('A');    %Offset from column A
	else
		% Fix for starting columns having double letters
		% provided by Mark Hayworth, Procter & Gamble
		firstLetter = FirstCol(1);
		secondLetter = FirstCol(2);
		FirstColOffset = 26 * (double(firstLetter) - double('A') + 1) + (double(secondLetter) - double('A'));    %Offset from column A
	end
	
	% Compute the numerical column number where the last data will reside.
	lastColumnNumber = FirstColOffset + numberOfColumnsToWrite;
	if lastColumnNumber > 256
		% Excel (STILL!) can handle only 256 columns.
		% Set it to 256 if it exceeds this, just to avoid an error.
		lastColumnNumber = 256;
	end
	
	% Compute the column header letters.  It will either be one letter in the range of A-Z
	% or two letters, like AA, AB, . . . IV.  IV is the most Excel can handle.
	if lastColumnNumber <= 26
		% It needs just a single letter.
		% Just convert to ASCII code, add the number of needed columns, 
		% and convert back to a string.
		LastColumnLetters = char(double(FirstCol) + numberOfColumnsToWrite - 1);
	else
		% It needs a double letter.
		
		% This block fixes Michelle Hirsch's code (which has a bug for high 
		% column letters and/or high numbers of columns to write).
		% Fixed by Mark Hayworth, The Procter & Gamble Company.
		
		% Get which group of 26 it's in: A-Z, AA-AZ, BA-BZ, ... HA-HZ, or IA-IV
		% A* = group #0, B* = group #1, I* = group #8.
		groupNumber = ceil(lastColumnNumber / 26) - 2;  
		
		% Find out what the offset is for the last column with that group of 26.
		% In other words, how many columns beyond the last group of 26 is it?
		groupOffset = rem(lastColumnNumber - 1, 26);
		% The above line maps ranges 27-52, 53-78, 79-104, 105-130, 106-156, 
		% 157-182, 183-208, 209-234, and 235-260 into the range 0-25.
		
		LastColFirstLetter  = char(double('A') + groupNumber);
		LastColSecondLetter = char(double('A') + groupOffset);
		% Append first and last letters together to get combined double letter.
		LastColumnLetters = [LastColFirstLetter LastColSecondLetter];
	end
	return;

    
    function xlsheets(sheetnames,varargin)

%XLSHEETS creates or opens existing Excel file and names sheets
%
% xlsheets(sheetnames,filename)
% xlsheets(sheetnames)
%
% xlsheets  : Creates new excel file (or opens it if file exists)
%               and name the sheets as listed in (sheetnames)
%               and saves the workbook as (filename).
%
%       sheetnames:     List of sheet names (cell array).
%       filename:       Name of excel file.
% 
% NOTE: Follow the following rules when naming your sheets:
%       1- Make sure the name you entered does not exceed 31 characters.
%       2- Make sure the name does not contain any of the following characters:  :  \  /  ?  *  [  or  ]
%       3- Make sure you did not leave the name blank.
%       4- Make sure each sheet name is a character string.
%       5- Make sure you do not have two sheets or more with the same name.
%
% Example:
% 
%      sheetnames = {'Mama','Papa','Son','Daughter','Dog'};
%      filename = 'family.xls';          % can be named without '.xls'
%      xlsheets(sheetnames,filename);
%      xlsheets(sheetnames);            % Will leave file open
%

%   Copyright 2004 Fahad Al Mahmood
%   Version: 1.0 $  $Date: 12-Feb-2004
%   Version: 1.5 $  $Date: 16-Feb-2004  (Open exisiting file feature)
%   Version: 2.0 $  $Date: 26-Feb-2004  (Fixed [Group] problem + Making process invisible)
%   Version: 2.1 $  $Date: 27-Feb-2004  (Fixed replacing existing sheets problem)
%   Version: 2.5 $  $Date: 15-Mar-2004  (Fixed filename problem)
%   Version: 3.0 $  $Date: 04-Apr-2004  (Fixed Naming to an existing sheetnames problem + Fixed Opening Multiple Excel Programs Problem)
%   Version: 3.1 $  $Date: 10-Apr-2004  (Added more help about the rules of naming Excel sheets)
%   Version: 3.2 $  $Date: 10-Apr-2004  (Supporting Full or Partial Path)

    
% Making sure the names of the sheets are according to Excel rules.
for n=1:length(sheetnames)
%  (1) Making sure each sheetname entered does not exceed 31 characters.    
    if length(sheetnames{n})>31
        error(['sheet (' sheetnames{n} ') exceeds 31 characters! (see xlsheets help)'])
    end
%  (2) Making sure each sheetname does not contain any illegal character.
    if any(ismember([':','\','/','?','*'],sheetnames{n})) | ismember('[',sheetnames{n}(1))
        error(['sheet (' sheetnames{n} ') contains an illegal character! (see xlsheets help)'])
    end
%  (3) Making sure each sheetname is not blank.
    if isempty(sheetnames{n})
        error(['sheet ' int2str(n) ' is empty! (see xlsheets help)'])
    end
%  (4) Making sure each sheetname is a character string.
    if ~ischar(sheetnames{n})
        error(['sheet (' int2str(n) ') is NOT a character string! (see xlsheets help)'])
    end
end

%  (5) Making sure two or more sheets do not have the same name.
if length(sheetnames)>length(unique(sheetnames))
    error('Two or more sheets have the same name!')

end

% Opening Excel
target_num_sheets = length(sheetnames);
Excel = actxserver('Excel.Application');
if nargin==2
    filename = varargin{1};
    [fpath,fname,fext] = fileparts(filename);
    if isempty(fpath)
        out_path = pwd;
    elseif fpath(1)=='.'
        out_path = [pwd filesep fpath];
    else
        out_path = fpath;
    end
    filename = [out_path filesep fname fext];
    if ~exist(filename,'file')
        % The following case if file does not exist (Creating New Workbook)
        Workbook = invoke(Excel.Workbooks,'Add');
        % getting the number of sheets in new workbook      
        numsheets = get(Excel,'SheetsInNewWorkbook');    
        new=1;
    else
        % The following case if file does exist (Opening Workbook)
        Workbook = invoke(Excel.Workbooks, 'open', filename);
        % getting the number of sheets in new workbook  
        workSheets = Excel.sheets;
        for i = 1:workSheets.Count
            sheet = get(workSheets,'item',i);
            description{i} = sheet.Name;
            if ~isempty(sheet.UsedRange.value)
                indexes(i) = true;
            else
                indexes(i) = false;
            end
        end
        descr = description(indexes);
        numsheets = length(descr);
        new=0;
    end
    leave_file_open = 0;
else
    % The following case if file does not exist (Creating New Workbook)
    Workbook = invoke(Excel.Workbooks,'Add');
    % getting the number of sheets in new workbook      
    numsheets = get(Excel,'SheetsInNewWorkbook');    
    new=1;
    leave_file_open = 1;
end

% making Excel visible only if workbook name is not specified or new workbook is created. 
if nargin==1
    set(Excel,'Visible', 1);
end

if target_num_sheets > numsheets
    
    % Activating Last sheet of new (filename)
    Sheets = Excel.ActiveWorkBook.Sheets;
    sheet = get(Sheets, 'Item', numsheets);
    invoke(sheet, 'Activate');
    
    % Adding sheets to match the number of (sheetnames) specified.
    for i=1:target_num_sheets-numsheets
        invoke(Excel.Sheets,'Add');
    end
    
elseif target_num_sheets < numsheets
    
    % Deleting sheets to match the number of (sheetnames) specified.
    for i=numsheets-target_num_sheets:-1:1
        sheet = get(Excel.ActiveWorkBook.Sheets, 'Item', i);
        invoke(sheet, 'Delete');
    end
end

% Renaming sheets to temporary names
for i=1:target_num_sheets
    Sheets = Excel.Worksheets;
    sheet = get(Sheets, 'Item', i);
    invoke(sheet, 'Activate');
    Activesheet = Excel.Activesheet;
    temp_name = ['temp_' int2str(i)];
    set(Activesheet,'Name',temp_name);
end

% Renaming sheets to the designated names
for i=1:target_num_sheets
    Sheets = Excel.Worksheets;
    sheet = get(Sheets, 'Item', i);
    invoke(sheet, 'Activate');
    Activesheet = Excel.Activesheet;
    set(Activesheet,'Name',char(sheetnames(i)));
end

if nargin>1
    if new invoke(Workbook, 'SaveAs', filename);
    else invoke(Workbook, 'Save'); end
end

if ~leave_file_open invoke(Excel, 'Quit'); end
delete(Excel);

