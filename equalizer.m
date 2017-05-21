function varargout = equalizer(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @equalizer_OpeningFcn, ...
    'gui_OutputFcn',  @equalizer_OutputFcn, ...
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


% --- Executes just before equalizer is made visible.
function equalizer_OpeningFcn(hObject, eventdata, handles, varargin)
global stop S Fs;
Fs= 44100;
stop=1;
S=zeros(1,10);
set(handles.S1,'min',-20);
set(handles.S1,'max',20);
set(handles.S1,'value',0);
set(handles.S1,'SliderStep',[0.05,0.1]);
set(handles.S1_value,'string',num2str(0));

set(handles.S2,'min',-20);
set(handles.S2,'max',20);
set(handles.S2,'value',0);
set(handles.S2,'SliderStep',[0.05,0.1]);
set(handles.S2_value,'string',num2str(0));

set(handles.S3,'min',-20);
set(handles.S3,'max',20);
set(handles.S3,'value',0);
set(handles.S3,'SliderStep',[0.05,0.1]);
set(handles.S3_value,'string',num2str(0));

set(handles.S4,'min',-20);
set(handles.S4,'max',20);
set(handles.S4,'value',0);
set(handles.S4,'SliderStep',[0.05,0.1]);
set(handles.S4_value,'string',num2str(0));

set(handles.S5,'min',-20);
set(handles.S5,'max',20);
set(handles.S5,'value',0);
set(handles.S5,'SliderStep',[0.05,0.1]);
set(handles.S5_value,'string',num2str(0));

set(handles.S6,'min',-20);
set(handles.S6,'max',20);
set(handles.S6,'value',0);
set(handles.S6,'SliderStep',[0.05,0.1]);
set(handles.S6_value,'string',num2str(0));

set(handles.S7,'min',-20);
set(handles.S7,'max',20);
set(handles.S7,'value',0);
set(handles.S7,'SliderStep',[0.05,0.1]);
set(handles.S7_value,'string',num2str(0));

set(handles.S8,'min',-20);
set(handles.S8,'max',20);
set(handles.S8,'value',0);
set(handles.S8,'SliderStep',[0.05,0.1]);
set(handles.S8_value,'string',num2str(0));


set(handles.S9,'min',-20);
set(handles.S9,'max',20);
set(handles.S9,'value',0);
set(handles.S9,'SliderStep',[0.05,0.1]);
set(handles.S9_value,'string',num2str(0));

set(handles.S10,'min',-20);
set(handles.S10,'max',20);
set(handles.S10,'value',0);
set(handles.S10,'SliderStep',[0.05,0.1]);
set(handles.S10_value,'string',num2str(0));
equalizer_plot(handles)


% Choose default command line output for equalizer
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = equalizer_OutputFcn(hObject, eventdata, handles)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in load_audio.
function load_audio_Callback(hObject, ~, handles)
global audio_file;
audio_file = uigetfile('*.wav;*.mp3','Pick up an audio file');

% --- Executes on button press in play_audio.
function play_audio_Callback(hObject, eventdata, handles)
% Play the audio file loaded previously
global audio_file stop;
% [audio,Fs] = audioread(audio_file);
% player = audioplayer(audio,Fs);
% playblocking(player);

% temp=audioread(audio_file);
% num=100000000000000000;

hafr = dsp.AudioFileReader('Filename',audio_file,'SamplesPerFrame',1000);
hap = dsp.AudioPlayer('SampleRate',44100);
stop = 1;
global G;
global a b;



while ~isDone(hafr)
    
    if(stop==0)
       break;
    end     
        
    audio = step(hafr);
    audio_leftchannel = audio(:, 1);
    audio_rightchannel = audio(:, 2);
    
  %  axes(handles.axes2)
    plot(handles.axes2,audio)

    
%     audio_leftchannelfilter = filter(b, a, audio_leftchannel);
%     audio_rightchannelfilter = filter(b, a, audio_rightchannel);
   
    
    tempgainvalue1 = get(handles.S1, 'value');
    tempgainvalue2 = get(handles.S2, 'value');
    tempgainvalue3 = get(handles.S3, 'value');
    tempgainvalue4 = get(handles.S4, 'value');
    tempgainvalue5 = get(handles.S5, 'value');
    tempgainvalue6 = get(handles.S6, 'value');
    tempgainvalue7 = get(handles.S7, 'value');
    tempgainvalue8 = get(handles.S8, 'value');
    tempgainvalue9 = get(handles.S9, 'value');
    tempgainvalue10 = get(handles.S10, 'value');
    
    
    
    [b1, a1] = shelving(tempgainvalue1, 60, 44100, sqrt(2)/2, 'Base_Shelf');
    audio_leftchannelfilter = filter(b1, a1, audio_leftchannel);
    audio_rightchannelfilter = filter(b1, a1, audio_rightchannel);
    [b2, a2] = shelving(tempgainvalue2, 170, 44100, sqrt(2)/2, 'Base_Shelf');
    audio_leftchannelfilter = filter(b2, a2, audio_leftchannelfilter);
    audio_rightchannelfilter = filter(b2, a2, audio_rightchannelfilter);
    [b3, a3] = shelving(tempgainvalue3, 310, 44100, sqrt(2)/2, 'Base_Shelf');
    audio_leftchannelfilter = filter(b3, a3, audio_leftchannelfilter);
    audio_rightchannelfilter = filter(b3, a3, audio_rightchannelfilter);
    [b4, a4] = shelving(tempgainvalue4, 600, 44100, sqrt(2)/2, 'Base_Shelf');
    audio_leftchannelfilter = filter(b4, a4, audio_leftchannelfilter);
    audio_rightchannelfilter = filter(b4, a4, audio_rightchannelfilter);
    [b5, a5] = shelving(tempgainvalue5, 1000, 44100, sqrt(2)/2, 'Base_Shelf');
    audio_leftchannelfilter = filter(b5, a5, audio_leftchannelfilter);
    audio_rightchannelfilter = filter(b5, a5, audio_rightchannelfilter);
    [b6, a6] = shelving(tempgainvalue6, 3000, 44100, sqrt(2)/2, 'Base_Shelf');
    audio_leftchannelfilter = filter(b6, a6, audio_leftchannelfilter);
    audio_rightchannelfilter = filter(b6, a6, audio_rightchannelfilter);
    [b7, a7] = shelving(tempgainvalue7, 6000, 44100, sqrt(2)/2, 'Base_Shelf');
    audio_leftchannelfilter = filter(b7, a7, audio_leftchannelfilter);
    audio_rightchannelfilter = filter(b7, a7, audio_rightchannelfilter);
    [b8, a8] = shelving(tempgainvalue8, 12000, 44100, sqrt(2)/2, 'Base_Shelf');
    audio_leftchannelfilter = filter(b8, a8, audio_leftchannelfilter);
    audio_rightchannelfilter = filter(b8, a8, audio_rightchannelfilter);
    [b9, a9] = shelving(tempgainvalue9, 14000, 44100, sqrt(2)/2, 'Base_Shelf');
    audio_leftchannelfilter = filter(b9, a9, audio_leftchannelfilter);
    audio_rightchannelfilter = filter(b9, a9, audio_rightchannelfilter);
    [b10, a10] = shelving(tempgainvalue10, 16000, 44100, sqrt(2)/2, 'Base_Shelf');
    audio_leftchannelfilter = filter(b10, a10, audio_leftchannelfilter);
    audio_rightchannelfilter = filter(b10, a10, audio_rightchannelfilter);
    
    a={a1,a2,a3,a4,a5,a6,a7,a8,a9,a10};
    b={b1,b2,b3,b4,b5,b6,b7,b8,b9,b10};
        
    
    audio_mod = [audio_leftchannelfilter audio_rightchannelfilter];
    
   % axes(handles.axes1)
    plot(handles.axes1,audio_mod)
    
        
    step(hap,audio_mod);
    pause(0.0001);
    
end

pause(hap.QueueDuration)  % Wait until audio plays to the end
release(hafr); % close input file, release resources
release(hap);


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

equalizer_plot(handles);

function equalizer_plot(handles)
global S Fs;
%global a b;

tempgainvalue1 = get(handles.S1, 'value');
tempgainvalue2 = get(handles.S2, 'value');
tempgainvalue3 = get(handles.S3, 'value');
tempgainvalue4 = get(handles.S4, 'value');
tempgainvalue5 = get(handles.S5, 'value');
tempgainvalue6 = get(handles.S6, 'value');
tempgainvalue7 = get(handles.S7, 'value');
tempgainvalue8 = get(handles.S8, 'value');
tempgainvalue9 = get(handles.S9, 'value');
tempgainvalue10 = get(handles.S10, 'value');
    
[b1, a1] = shelving(tempgainvalue1, 60, 44100, sqrt(2)/2, 'Base_Shelf');
[b2, a2] = shelving(tempgainvalue2, 170, 44100, sqrt(2)/2, 'Base_Shelf');
[b3, a3] = shelving(tempgainvalue3, 310, 44100, sqrt(2)/2, 'Base_Shelf');
[b4, a4] = shelving(tempgainvalue4, 600, 44100, sqrt(2)/2, 'Base_Shelf');
[b5, a5] = shelving(tempgainvalue5, 1000, 44100, sqrt(2)/2, 'Base_Shelf');
[b6, a6] = shelving(tempgainvalue6, 3000, 44100, sqrt(2)/2, 'Base_Shelf');
[b7, a7] = shelving(tempgainvalue7, 6000, 44100, sqrt(2)/2, 'Base_Shelf');
[b8, a8] = shelving(tempgainvalue8, 12000, 44100, sqrt(2)/2, 'Base_Shelf');
[b9, a9] = shelving(tempgainvalue9, 14000, 44100, sqrt(2)/2, 'Base_Shelf');
[b10, a10] = shelving(tempgainvalue10, 16000, 44100, sqrt(2)/2, 'Treble_Shelf');
a={a1,a2,a3,a4,a5,a6,a7,a8,a9,a10};
b={b1,b2,b3,b4,b5,b6,b7,b8,b9,b10};

H=0;

for i=1:10
    H=H+10^(S(i)/20)*abs(freqz(b{i},a{i},1024));
end

axes(handles.axes3)
plot(1e-3*Fs*[0:1023]/2048,20*log10(H))

xlabel('Frequency [kHz]');
ylabel('Magnitude [dB]');
title('Responce of Equilizer');
grid on;



% --- Executes on slider movement.
function S1_Callback(hObject, eventdata, handles)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global S;
S(1)=get(hObject,'value');
set(handles.S1_value,'string',num2str(S(1)));

% --- Executes during object creation, after setting all properties.
function S1_CreateFcn(hObject, eventdata, handles)

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function S2_Callback(hObject, eventdata, handles)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global S;
S(2)=get(hObject,'value');
set(handles.S2_value,'string',num2str(S(2)));

% --- Executes during object creation, after setting all properties.
function S2_CreateFcn(hObject, eventdata, handles)

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function S3_Callback(hObject, eventdata, handles)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global S;
S(3)=get(hObject,'value');
set(handles.S3_value,'string',num2str(S(3)));

% --- Executes during object creation, after setting all properties.
function S3_CreateFcn(hObject, eventdata, handles)
% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function S4_Callback(hObject, eventdata, handles)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global S;
S(4)=get(hObject,'value');
set(handles.S4_value,'string',num2str(S(4)));

% --- Executes during object creation, after setting all properties.
function S4_CreateFcn(hObject, eventdata, handles)

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function S5_Callback(hObject, eventdata, handles)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global S;
S(5)=get(hObject,'value');
set(handles.S5_value,'string',num2str(S(5)));

% --- Executes during object creation, after setting all properties.
function S5_CreateFcn(hObject, eventdata, handles)

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function S6_Callback(hObject, eventdata, handles)
% hObject    handle to S6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global S;
S(6)=get(hObject,'value');
set(handles.S6_value,'string',num2str(S(6)));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function S6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to S6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function S7_Callback(hObject, eventdata, handles)
% hObject    handle to S7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global S;
S(7)=get(hObject,'value');
set(handles.S7_value,'string',num2str(S(7)));


% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function S7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to S7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function S8_Callback(hObject, eventdata, handles)
% hObject    handle to S8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global S;
S(8)=get(hObject,'value');
set(handles.S8_value,'string',num2str(S(8)));


% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function S8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to S8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function S9_Callback(hObject, eventdata, handles)
% hObject    handle to S9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global S;
S(9)=get(hObject,'value');
set(handles.S9_value,'string',num2str(S(9)));

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

% --- Executes during object creation, after setting all properties.
function S9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to S9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function S10_Callback(hObject, eventdata, handles)
% hObject    handle to S10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global S;
S(10)=get(hObject,'value');
set(handles.S10_value,'string',num2str(S(10)));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function S10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to S10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
