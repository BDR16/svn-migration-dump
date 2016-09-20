function varargout = plotter(varargin)
% PLOTTER MATLAB code for plotter.fig
%      PLOTTER, by itself, creates a new PLOTTER or raises the existing
%      singleton*.
%
%      H = PLOTTER returns the handle to a new PLOTTER or the handle to
%      the existing singleton*.
%
%      PLOTTER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PLOTTER.M with the given input arguments.
%
%      PLOTTER('Property','Value',...) creates a new PLOTTER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before plotter_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to plotter_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help plotter

% Last Modified by GUIDE v2.5 05-Oct-2015 00:51:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @plotter_OpeningFcn, ...
                   'gui_OutputFcn',  @plotter_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before plotter is made visible.
function plotter_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to plotter (see VARARGIN)

% Choose default command line output for plotter
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes plotter wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = plotter_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in yData.
function yData_Callback(hObject, eventdata, handles)
% hObject    handle to yData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns yData contents as cell array
%        contents{get(hObject,'Value')} returns selected item from yData


% --- Executes during object creation, after setting all properties.
function yData_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in xData.
function xData_Callback(hObject, eventdata, handles)
% hObject    handle to xData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns xData contents as cell array
%        contents{get(hObject,'Value')} returns selected item from xData


% --- Executes during object creation, after setting all properties.
function xData_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in plotData.
function plotData_Callback(hObject, eventdata, handles)
% hObject    handle to plotData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if ~isfield(handles, 'data')
    handles = loadData_Callback(hObject, eventdata, handles);
end
if ~isfield(handles, 'data')
    return;
end
data = handles.data;

% Get the graph type
xVar = strtrim(handles.xData.String(handles.xData.Value, :));
yVar = strtrim(handles.yData.String(handles.yData.Value, :));
if strcmp(xVar, 'SA')
    type = 'lat';
else
    type = 'long';
end

% Get the tire data
tires = handles.tireTable.Data;
cla(handles.plot, 'reset');
hold(handles.plot, 'on');
blankRows = {};
legendRows = {};
for row = 1:length(tires)
    tire = tires(row, :);
    tireID = tire{1};
    rimWidth = tire{2};
    pressure = tire{3};
    load = tire{4};
    camber = tire{5};
    slipAngle = tire{6};
    tireDataIndex = getIndex(type, tireID, rimWidth, pressure, load, camber, slipAngle);
    if isKey(data, tireDataIndex)
        tireData = data(tireDataIndex);
        xData = tireData.data{:, xVar};
        yData = tireData.data{:, yVar};
        fit = getFit(tireData, xVar, yVar, true);
        plot(handles.plot, xData, yData, '.');
        legendRows{length(legendRows) + 1} = sprintf('Row %s', num2str(row));
    else
        blankRows{length(blankRows) + 1} = num2str(row);
    end
end
hold(handles.plot, 'off');
title(sprintf('%s vs. %s', yVar, xVar));
xlabel(xVar);
ylabel(yVar);
legend(legendRows);

if ~isempty(blankRows)
    handles.errorText.String = sprintf('Could not load the following rows: %s.', strjoin(blankRows, ', '));
end


function dataFile_Callback(hObject, eventdata, handles)
% hObject    handle to dataFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dataFile as text
%        str2double(get(hObject,'String')) returns contents of dataFile as a double


% --- Executes during object creation, after setting all properties.
function dataFile_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dataFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in browseDateFile.
function browseDateFile_Callback(hObject, eventdata, handles)
% hObject    handle to browseDateFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[fileName, pathName] = uigetfile('*.mat', 'Select data file');
handles.dataFile.String = strcat(pathName, fileName);
guidata(hObject,handles)


% --- Executes on button press in clearPlot.
function clearPlot_Callback(hObject, eventdata, handles)
% hObject    handle to clearPlot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla(handles.plot, 'reset');
handles.errorText.String = '';


% --- Executes during object creation, after setting all properties.
function plot_CreateFcn(hObject, eventdata, handles)
% hObject    handle to plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate plot


% --- Executes on button press in loadData.
function [handles] = loadData_Callback(hObject, eventdata, handles)
% hObject    handle to loadData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Get the data
if exist(handles.dataFile.String, 'file') == 2
    handles.data = importdata(handles.dataFile.String);
else 
    handles.errorText.String = 'Could not find data file.';
    return;
end
guidata(hObject,handles)
