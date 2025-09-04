function varargout = FutureHourlyMeteorologicalData(varargin)
% FUTUREHOURLYMETEOROLOGICANDATA MATLAB code for FutureHourlyMeteorologicanData.fig
%      FUTUREHOURLYMETEOROLOGICANDATA, by itself, creates a new FUTUREHOURLYMETEOROLOGICANDATA or raises the existing
%      singleton*.
%
%      H = FUTUREHOURLYMETEOROLOGICANDATA returns the handle to a new FUTUREHOURLYMETEOROLOGICANDATA or the handle to
%      the existing singleton*.
%
%      FUTUREHOURLYMETEOROLOGICANDATA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FUTUREHOURLYMETEOROLOGICANDATA.M with the given input arguments.
%
%      FUTUREHOURLYMETEOROLOGICANDATA('Property','Value',...) creates a new FUTUREHOURLYMETEOROLOGICANDATA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before FutureHourlyMeteorologicanData_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to FutureHourlyMeteorologicanData_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help FutureHourlyMeteorologicanData

% Last Modified by GUIDE v2.5 14-Oct-2015 19:40:20

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @FutureHourlyMeteorologicalData_OpeningFcn, ...
                   'gui_OutputFcn',  @FutureHourlyMeteorologicalData_OutputFcn, ...
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


% --- Executes just before FutureHourlyMeteorologicanData is made visible.
function FutureHourlyMeteorologicalData_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to FutureHourlyMeteorologicanData (see VARARGIN)

% Choose default command line output for FutureHourlyMeteorologicanData
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes FutureHourlyMeteorologicanData wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = FutureHourlyMeteorologicalData_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in DXN.
function DXN_Callback(hObject, eventdata, handles)
 [filename pathname]= uigetfile({'*.txt;'},'Select a File');
% hObject    handle to DXN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in wlyc.
function wlyc_Callback(hObject, eventdata, handles)
 [filename pathname]= uigetfile({'*.txt;'},'Select a File');
% hObject    handle to wlyc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in wldbt.
function wldbt_Callback(hObject, eventdata, handles)
run yucezhushidbt
% hObject    handle to wldbt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in zsgsr.
function zsgsr_Callback(hObject, eventdata, handles)
run yucezhushifushe
% hObject    handle to zsgsr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on button press in zsss.
function zsss_Callback(hObject, eventdata, handles)
run zhushihanshiliang
run futuress
% hObject    handle to zsss (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in zsrh.
function zsrh_Callback(hObject, eventdata, handles)
run futurerh
% hObject    handle to zsrh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in huizong.
function huizong_Callback(hObject, eventdata, handles)
run zongshuju
% hObject    handle to huizong (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

未来逐时干球温度预测
function yucezhushidbt(data1,data2)
%把原有逐时数据文件输入
 data1=load('E:\论文\预测未来逐时天气\预测未来逐时天气\BasicHourlyData.txt');
% %把月预测变化数据文件输入
 data2=load('E:\论文\预测未来逐时天气\预测未来逐时天气\FutureMonthlyData.txt');
%逐时干球温度:dbt0
%逐时最大干球温度：dbtmx
%逐时最小干球温度：dbtmi
%逐时太阳总辐射：gsr0
%逐时含湿量：s0
tzh=data1(:,1);
year1=data1(:,2);
month=data1(:,3);
day=data1(:,4);
dbt0=data1(:,6);%干球温度%
gsr0=data1(:,10);%太阳总辐射%
dif0=data1(:,11);%太阳散射
dir0=data1(:,12);%太阳直射
% dbt0=dbt0.*0.1;
% gsr0=gsr0*1000000/3600;
% dif0=dif0*1000000/3600;
% dir0=dir0*1000000/3600;
dbt0m=[];
gsr0m=[];
%求出已有数据的每月均值
for k=1:1:12
    if k==1
        meanl=mean(dbt0(1:length(find(month<=k))));
        mean2=mean(gsr0(1:length(find(month<=k))));
    else
        meanl=mean(dbt0(length(find(month<=k-1))+1:length(find(month<=k))));
        mean2=mean(gsr0(length(find(month<=k-1))+1:length(find(month<=k))));
    end
    dbt0m=[dbt0m meanl];
    gsr0m=[gsr0m mean2];
end
%在逐时干球温度中找出最大最小干球温度并求月均值
mean_max=[];
mean_min=[];
for k=1:1:12
    n(k)=length(find(month<=k));
    if k==1
        a=[];
        b=[];
        for i=1:1:length(find(month==k))/24
            if i==1
                max1=max(dbt0(1:24));
                min1=min(dbt0(1:24));
            else
                max1=max(dbt0((i-1)*24+1:i*24));
                min1=min(dbt0((i-1)*24+1:i*24));
            end
            a=[a max1];
            b=[b min1];
        end
        c=mean(a);
        d=mean(b);
        mean_max=[mean_max c];
        mean_min=[mean_min d];
    elseif k>=2
        a=[];
        b=[];
        for i=1:1:length(find(month==k))/24
            if i==1
                max1=max(dbt0(n(k-1)+1:n(k-1)+i*24));
                min1=min(dbt0(n(k-1)+1:n(k-1)+i*24));
            else
                max1=max(dbt0(n(k-1)+(i-1)*24+1:n(k-1)+i*24));
                min1=min(dbt0(n(k-1)+(i-1)*24+1:n(k-1)+i*24));
            end
            a=[a max1];
            b=[b min1];
        end
        c=mean(a);
        d=mean(b);
        mean_max=[mean_max c];
        mean_min=[mean_min d];
    end
end
%最大干球温度月均值预测变化：TMX
%最小干球温度月均值预测变化：TIN
%太阳总辐射：RSDS
%含湿量：HUSS
%平均干球温度月均值预测值：TAS
year=data2(:,1);
month1=data2(:,2);
TAS=data2(:,3);
TMX=data2(:,4)-mean_max'-273.15;
TIN=data2(:,5)-mean_min'-273.15;
HUSS=data2(:,6);
RSDS1=data2(:,7);
tas1=TAS-273.15;
L=length(TAS);
F=length(dbt0);
gsr0m=gsr0m';
RSDS=RSDS1-gsr0m;
for i=1:1:L
    adbt(i)=(TMX(i)-TIN(i))/(mean_max(i)-mean_min(i));%干球温度缩放因子
    agsr(i)=1+(RSDS(i)/gsr0m(i));                     %太阳总辐射、直射、散射缩放因子
    tas=tas1'-dbt0m;                                  %干球月均值的变化量
end
%位移加伸缩进行预测逐时值生成
for j=1:24*31
    dbt(j)=dbt0(j)+tas(1)+adbt(1)*(dbt0(j)-dbt0m(1));
    gsr(j)=agsr(1)*gsr0(j);
    dif(j)=agsr(1)*dif0(j);
    dir(j)=agsr(1)*dir0(j);
end

for j=(24*31+1):(24*(31+28))
    dbt(j)=dbt0(j)+tas(2)+adbt(2)*(dbt0(j)-dbt0m(2));
    gsr(j)=agsr(2)*gsr0(j);
    dif(j)=agsr(2)*dif0(j);
    dir(j)=agsr(2)*dir0(j);
end
for j=(24*(31+28)+1):(24*(31+28+31))
    dbt(j)=dbt0(j)+tas(3)+adbt(3)*(dbt0(j)-dbt0m(3));
    gsr(j)=agsr(3)*gsr0(j);
    dif(j)=agsr(3)*dif0(j);
    dir(j)=agsr(3)*dir0(j);
end
for j=(24*(31+28+31)+1):(24*(31+28+31+30))
    dbt(j)=dbt0(j)+tas(4)+adbt(4)*(dbt0(j)-dbt0m(4));
    gsr(j)=agsr(4)*gsr0(j);
    dif(j)=agsr(4)*dif0(j);
    dir(j)=agsr(4)*dir0(j);
end
for j=(24*(31+28+31+30)+1):(24*(31+28+31+30+31))
    dbt(j)=dbt0(j)+tas(5)+adbt(5)*(dbt0(j)-dbt0m(5));
    gsr(j)=agsr(5)*gsr0(j);
    dif(j)=agsr(5)*dif0(j);
    dir(j)=agsr(5)*dir0(j);
end
for j=(24*(31+28+31+30+31)+1):(24*(31+28+31+30+31+30))
    dbt(j)=dbt0(j)+tas(6)+adbt(6)*(dbt0(j)-dbt0m(6));
    gsr(j)=agsr(6)*gsr0(j);
    dif(j)=agsr(6)*dif0(j);
    dir(j)=agsr(6)*dir0(j);
end
for j=(24*(31+28+31+30+31+30)+1):(24*(31+28+31+30+31+30+31))
    dbt(j)=dbt0(j)+tas(7)+adbt(7)*(dbt0(j)-dbt0m(7));
    gsr(j)=agsr(7)*gsr0(j);
    dif(j)=agsr(7)*dif0(j);
    dir(j)=agsr(7)*dir0(j);
end
for j=(24*(31+28+31+30+31+30+31)+1):(24*(31+28+31+30+31+30+31+31))
    dbt(j)=dbt0(j)+tas(8)+adbt(8)*(dbt0(j)-dbt0m(8));
    gsr(j)=agsr(8)*gsr0(j);
    dif(j)=agsr(8)*dif0(j);
    dir(j)=agsr(8)*dir0(j);
end
for j=(24*(31+28+31+30+31+30+31+31)+1):(24*(31+28+31+30+31+30+31+31+30))
    dbt(j)=dbt0(j)+tas(9)+adbt(9)*(dbt0(j)-dbt0m(9));
    gsr(j)=agsr(9)*gsr0(j);
    dif(j)=agsr(9)*dif0(j);
    dir(j)=agsr(9)*dir0(j);
end
for j=(24*(31+28+31+30+31+30+31+31+30)+1):(24*(31+28+31+30+31+30+31+31+30+31))
    dbt(j)=dbt0(j)+tas(10)+adbt(10)*(dbt0(j)-dbt0m(10));
    gsr(j)=agsr(10)*gsr0(j);
    dif(j)=agsr(10)*dif0(j);
    dir(j)=agsr(10)*dir0(j);
end
for j=(24*(31+28+31+30+31+30+31+31+30+31)+1):(24*(31+28+31+30+31+30+31+31+30+31+30))
    dbt(j)=dbt0(j)+tas(11)+adbt(11)*(dbt0(j)-dbt0m(11));
    gsr(j)=agsr(11)*gsr0(j);
    dif(j)=agsr(11)*dif0(j);
    dir(j)=agsr(11)*dir0(j);
end
for j=(24*(31+28+31+30+31+30+31+31+30+31+30)+1):(24*(31+28+31+30+31+30+31+31+30+31+30+31))
    dbt(j)=dbt0(j)+tas(12)+adbt(12)*(dbt0(j)-dbt0m(12));
    gsr(j)=agsr(12)*gsr0(j);
    dif(j)=agsr(12)*dif0(j);
    dir(j)=agsr(12)*dir0(j);
end
k=1;
%转化成24时输出
for i=1:1:F
    xxx(i)=k;
    k=k+1;
    if k==25
        k=1;
    end
end
%24时，竖着输出fid是文件file的ID %6.1f 6代表小数点前有六位数，1代表小数点后有1位数，f代表自由格式输出
% wt是write的简写
xxx=xxx';
dbt=dbt';
gsr=gsr';
dif=dif';
dir=dir';
fid=fopen('E:\论文\预测未来逐时天气\预测未来逐时天气\FutureHourlydbt.txt','wt');
for i=1:1:F
fprintf(fid, '%3.0f %3.0f %3.0f %3.0f %3.0f %6.1f\n',tzh(i),year1(i),month(i),day(i),xxx(i),dbt(i));
end
fclose(fid);

未来逐时辐射预测
function yucezhushifushe(data1,data2)
%把原有逐时数据文件输入
data1=load('E:\论文\预测未来逐时天气\预测未来逐时天气\BasicHourlyData.txt');
%把月预测变化数据文件输入
data2=load('E:\论文\预测未来逐时天气\预测未来逐时天气\FutureMonthlyData.txt');
%逐时干球温度:dbt0
%逐时最大干球温度：dbtmx
%逐时最小干球温度：dbtmi
%逐时太阳总辐射：gsr0
%逐时含湿量：s0
tzh=data1(:,1);
year1=data1(:,2);
month=data1(:,3);
day=data1(:,4);
dbt0=data1(:,6);%干球温度%
gsr0=data1(:,10);%太阳总辐射%
dif0=data1(:,11);%太阳散射
dir0=data1(:,12);%太阳直射
% dbt0=dbt0.*0.1;
% gsr0=gsr0*1000000/3600;
% dif0=dif0*1000000/3600;
% dir0=dir0*1000000/3600;
dbt0m=[];
gsr0m=[];
%求出已有数据的每月均值
for k=1:1:12
    if k==1
        meanl=mean(dbt0(1:length(find(month<=k))));
        mean2=mean(gsr0(1:length(find(month<=k))));
    else
        meanl=mean(dbt0(length(find(month<=k-1))+1:length(find(month<=k))));
        mean2=mean(gsr0(length(find(month<=k-1))+1:length(find(month<=k))));
    end
    dbt0m=[dbt0m meanl];
    gsr0m=[gsr0m mean2];
end
%在逐时干球温度中找出最大最小干球温度并求月均值
mean_max=[];
mean_min=[];
for k=1:1:12
    n(k)=length(find(month<=k));
    if k==1
        a=[];
        b=[];
        for i=1:1:length(find(month==k))/24
            if i==1
                max1=max(dbt0(1:24));
                min1=min(dbt0(1:24));
            else
                max1=max(dbt0((i-1)*24+1:i*24));
                min1=min(dbt0((i-1)*24+1:i*24));
            end
            a=[a max1];
            b=[b min1];
        end
        c=mean(a);
        d=mean(b);
        mean_max=[mean_max c];
        mean_min=[mean_min d];
    elseif k>=2
        a=[];
        b=[];
        for i=1:1:length(find(month==k))/24
            if i==1
                max1=max(dbt0(n(k-1)+1:n(k-1)+i*24));
                min1=min(dbt0(n(k-1)+1:n(k-1)+i*24));
            else
                max1=max(dbt0(n(k-1)+(i-1)*24+1:n(k-1)+i*24));
                min1=min(dbt0(n(k-1)+(i-1)*24+1:n(k-1)+i*24));
            end
            a=[a max1];
            b=[b min1];
        end
        c=mean(a);
        d=mean(b);
        mean_max=[mean_max c];
        mean_min=[mean_min d];
    end
end
%最大干球温度月均值预测变化：TMX
%最小干球温度月均值预测变化：TIN
%太阳总辐射：RSDS
%含湿量：HUSS
%平均干球温度月均值预测值：TAS
year=data2(:,1);
month1=data2(:,2);
TAS=data2(:,3);
TMX=data2(:,4)-mean_max'-273.15;
TIN=data2(:,5)-mean_min'-273.15;
HUSS=data2(:,6);
RSDS1=data2(:,7);
tas1=TAS-273.15;
L=length(TAS);
F=length(dbt0);
gsr0m=gsr0m';
RSDS=RSDS1-gsr0m;
for i=1:1:L
    adbt(i)=(TMX(i)-TIN(i))/(mean_max(i)-mean_min(i));%干球温度缩放因子
    agsr(i)=1+(RSDS(i)/gsr0m(i));                     %太阳总辐射、直射、散射缩放因子
    tas=tas1'-dbt0m;                                  %干球月均值的变化量
end
%位移加伸缩进行预测逐时值生成
for j=1:24*31
    dbt(j)=dbt0(j)+tas(1)+adbt(1)*(dbt0(j)-dbt0m(1));
    gsr(j)=agsr(1)*gsr0(j);
    dif(j)=agsr(1)*dif0(j);
    dir(j)=agsr(1)*dir0(j);
end

for j=(24*31+1):(24*(31+28))
    dbt(j)=dbt0(j)+tas(2)+adbt(2)*(dbt0(j)-dbt0m(2));
    gsr(j)=agsr(2)*gsr0(j);
    dif(j)=agsr(2)*dif0(j);
    dir(j)=agsr(2)*dir0(j);
end
for j=(24*(31+28)+1):(24*(31+28+31))
    dbt(j)=dbt0(j)+tas(3)+adbt(3)*(dbt0(j)-dbt0m(3));
    gsr(j)=agsr(3)*gsr0(j);
    dif(j)=agsr(3)*dif0(j);
    dir(j)=agsr(3)*dir0(j);
end
for j=(24*(31+28+31)+1):(24*(31+28+31+30))
    dbt(j)=dbt0(j)+tas(4)+adbt(4)*(dbt0(j)-dbt0m(4));
    gsr(j)=agsr(4)*gsr0(j);
    dif(j)=agsr(4)*dif0(j);
    dir(j)=agsr(4)*dir0(j);
end
for j=(24*(31+28+31+30)+1):(24*(31+28+31+30+31))
    dbt(j)=dbt0(j)+tas(5)+adbt(5)*(dbt0(j)-dbt0m(5));
    gsr(j)=agsr(5)*gsr0(j);
    dif(j)=agsr(5)*dif0(j);
    dir(j)=agsr(5)*dir0(j);
end
for j=(24*(31+28+31+30+31)+1):(24*(31+28+31+30+31+30))
    dbt(j)=dbt0(j)+tas(6)+adbt(6)*(dbt0(j)-dbt0m(6));
    gsr(j)=agsr(6)*gsr0(j);
    dif(j)=agsr(6)*dif0(j);
    dir(j)=agsr(6)*dir0(j);
end
for j=(24*(31+28+31+30+31+30)+1):(24*(31+28+31+30+31+30+31))
    dbt(j)=dbt0(j)+tas(7)+adbt(7)*(dbt0(j)-dbt0m(7));
    gsr(j)=agsr(7)*gsr0(j);
    dif(j)=agsr(7)*dif0(j);
    dir(j)=agsr(7)*dir0(j);
end
for j=(24*(31+28+31+30+31+30+31)+1):(24*(31+28+31+30+31+30+31+31))
    dbt(j)=dbt0(j)+tas(8)+adbt(8)*(dbt0(j)-dbt0m(8));
    gsr(j)=agsr(8)*gsr0(j);
    dif(j)=agsr(8)*dif0(j);
    dir(j)=agsr(8)*dir0(j);
end
for j=(24*(31+28+31+30+31+30+31+31)+1):(24*(31+28+31+30+31+30+31+31+30))
    dbt(j)=dbt0(j)+tas(9)+adbt(9)*(dbt0(j)-dbt0m(9));
    gsr(j)=agsr(9)*gsr0(j);
    dif(j)=agsr(9)*dif0(j);
    dir(j)=agsr(9)*dir0(j);
end
for j=(24*(31+28+31+30+31+30+31+31+30)+1):(24*(31+28+31+30+31+30+31+31+30+31))
    dbt(j)=dbt0(j)+tas(10)+adbt(10)*(dbt0(j)-dbt0m(10));
    gsr(j)=agsr(10)*gsr0(j);
    dif(j)=agsr(10)*dif0(j);
    dir(j)=agsr(10)*dir0(j);
end
for j=(24*(31+28+31+30+31+30+31+31+30+31)+1):(24*(31+28+31+30+31+30+31+31+30+31+30))
    dbt(j)=dbt0(j)+tas(11)+adbt(11)*(dbt0(j)-dbt0m(11));
    gsr(j)=agsr(11)*gsr0(j);
    dif(j)=agsr(11)*dif0(j);
    dir(j)=agsr(11)*dir0(j);
end
for j=(24*(31+28+31+30+31+30+31+31+30+31+30)+1):(24*(31+28+31+30+31+30+31+31+30+31+30+31))
    dbt(j)=dbt0(j)+tas(12)+adbt(12)*(dbt0(j)-dbt0m(12));
    gsr(j)=agsr(12)*gsr0(j);
    dif(j)=agsr(12)*dif0(j);
    dir(j)=agsr(12)*dir0(j);
end
k=1;
%转化成24时输出
for i=1:1:F
    xxx(i)=k;
    k=k+1;
    if k==25
        k=1;
    end
end
%24时，竖着输出fid是文件file的ID %6.1f 6代表小数点前有六位数，1代表小数点后有1位数，f代表自由格式输出
% wt是write的简写
xxx=xxx';
dbt=dbt';
gsr=gsr';
dif=dif';
dir=dir';
fid=fopen('E:\论文\预测未来逐时天气\预测未来逐时天气\FutureHourlygsrdifdir.txt','wt');
for i=1:1:F
fprintf(fid, '%3.0f %3.0f %3.0f %3.0f %3.0f %6.1f %6.1f %6.1f\n',tzh(i),year1(i),month(i),day(i),xxx(i),gsr(i),dif(i),dir(i));
end
fclose(fid);

此为逐时含湿量的求法
function zhushihanshiliang(useless)
useless=load('E:\论文\预测未来逐时天气\预测未来逐时天气\BasicHourlyData.txt');
t=useless(:,6);
p=useless(:,9);
h=useless(:,8);
%p为大气压力，单位为0.1百Pa，应标准化为Pa
% p=0.1.*100.*p;
%气温的单位为0.1摄氏度   %，标准化为国际温度单位
% t=0.1*t;
T=t+273.15;
%h相对湿度，单位%
h=h/100;
%输入系数相
c1=-5674.5359;
c2=6.3925247;
c3=-0.9677843e-2
c4=0.62215701e-6;
c5=0.20747825e-8;
c6=-0.9484024e-12;
c7=4.1635019;
c8=-5800.2206;
c9=1.3914993;
c10=-0.04860239;
c11=0.41764768e-4;
c12=-0.14452093e-7;
c13=6.5459673;
L=length(T);
for i=1:L
    if (T(i)-273.15<0)
        Pws(i)=exp(c1/T(i)+c2+c3*T(i)+c4*T(i)^2+c5*T(i)^3+c6*T(i)^4+c7*log(T(i)));
    else
        Pws(i)=exp(c8/T(i)+c9+c10*T(i)+c11*T(i)^2+c12*T(i)^3+c13*log(T(i)));
    end
    
%Pws 逐时饱和水汽压  
%Pv(i)=611.2*exp((18.678-t(i)/234.5)*t(i)/(t(i)+257.14));
    Pw(i)=Pws(i).*h(i);
%Pws逐时饱和水汽压 乘以 h逐时相对湿度是 Pw逐时水汽压
    Ws(i)=0.62198*Pw(i)./(p(i)-Pw(i));
%Ws逐时含湿量
end
Pws;
Ws=Ws';
Pw=Pw';
useless2=[useless(:,1) useless(:,2) useless(:,3) useless(:,4) useless(:,5) useless(:,9) Ws ];
a=useless2;
fid=fopen('E:\论文\预测未来逐时天气\预测未来逐时天气\zhushihanshiliang.txt','wt');
[m,n]=size(a);
for i=1:m
    for j=1:n
        if j==n
            fprintf(fid,'%g\n',a(i,j));
        else
            fprintf(fid,'%g\t',a(i,j));
        end
    end
end
fclose(fid);

未来逐时含湿量
function futuress(data1,data2,data3)
%求解含湿量尺度因子
data1=load('E:\论文\预测未来逐时天气\预测未来逐时天气\zhushihanshiliang.txt');
data2=load('E:\论文\预测未来逐时天气\预测未来逐时天气\FutureMonthlyData.txt');
data3=load('E:\论文\预测未来逐时天气\预测未来逐时天气\FutureHourlydbt.txt');
month=data1(:,3);
day=data1(:,4);
p=data1(:,6);
s0=data1(:,7);
HUSS1=data2(:,6);
dbt=data3(:,6);%逐时预测干球温度，计算未来气候变化下的逐时饱和水汽压
% p=0.1.*100.*p;%p为大气压力，单位为0.1百Pa，应标准化为Pa
F=length(s0);
s0m=[];
for k=1:1:12
    if k==1
        meanl=mean(s0(1:length(find(month<=k))));
    else
        meanl=mean(s0(length(find(month<=k-1))+1:length(find(month<=k))));
    end
    s0m=[s0m meanl];
end
s0m=s0m';%预测含湿量月均值

L=length(HUSS1);
for i=1:1:L
     as(i)=HUSS1(i)./s0m(i);%as(i)=1+(HUSS(i)/100);
end
%求出一年预测逐时含湿量
for j=1:24*31
    s(j)=as(1)*s0(j);
end
for j=(24*31+1):(24*(31+28))
    s(j)=as(2)*s0(j);
end
for j=(24*(31+28)+1):(24*(31+28+31))
    s(j)=as(3)*s0(j);
end
for j=(24*(31+28+31)+1):(24*(31+28+31+30))
    s(j)=as(4)*s0(j);
end
for j=(24*(31+28+31+30)+1):(24*(31+28+31+30+31))
    s(j)=as(5)*s0(j);
end
for j=(24*(31+28+31+30+31)+1):(24*(31+28+31+30+31+30))
    s(j)=as(6)*s0(j);
end
for j=(24*(31+28+31+30+31+30)+1):(24*(31+28+31+30+31+30+31))
    s(j)=as(7)*s0(j);
end
for j=(24*(31+28+31+30+31+30+31)+1):(24*(31+28+31+30+31+30+31+31))
    s(j)=as(8)*s0(j);
end
未来逐时相对湿度 
function futurerh(data1,data2,data3)
%求解含湿量尺度因子
clear
clc
data1=load('E:\论文\预测未来逐时天气\预测未来逐时天气\zhushihanshiliang.txt');
data2=load('E:\论文\预测未来逐时天气\预测未来逐时天气\FutureMonthlyData.txt');
data3=load('E:\论文\预测未来逐时天气\预测未来逐时天气\FutureHourlydbt.txt');
month=data1(:,3);
day=data1(:,4);
p=data1(:,6);
s0=data1(:,7);
HUSS1=data2(:,6);
dbt=data3(:,6);%逐时预测干球温度，计算未来气候变化下的逐时饱和水汽压
% p=0.1.*100.*p;%p为大气压力，单位为0.1百Pa，应标准化为Pa
F=length(s0);
s0m=[];
for k=1:1:12
    if k==1
        meanl=mean(s0(1:length(find(month<=k))));
    else
        meanl=mean(s0(length(find(month<=k-1))+1:length(find(month<=k))));
    end
    s0m=[s0m meanl];
end
s0m=s0m';%预测含湿量月均值

L=length(HUSS1);
for i=1:1:L
     as(i)=HUSS1(i)./s0m(i);%as(i)=1+(HUSS(i)/100);
end
%求出一年预测逐时含湿量
for j=1:24*31
    s(j)=as(1)*s0(j);
end
for j=(24*31+1):(24*(31+28))
    s(j)=as(2)*s0(j);
end
for j=(24*(31+28)+1):(24*(31+28+31))
    s(j)=as(3)*s0(j);
end
for j=(24*(31+28+31)+1):(24*(31+28+31+30))
    s(j)=as(4)*s0(j);
end
for j=(24*(31+28+31+30)+1):(24*(31+28+31+30+31))
    s(j)=as(5)*s0(j);
end
for j=(24*(31+28+31+30+31)+1):(24*(31+28+31+30+31+30))
    s(j)=as(6)*s0(j);
end
for j=(24*(31+28+31+30+31+30)+1):(24*(31+28+31+30+31+30+31))
    s(j)=as(7)*s0(j);
end
for j=(24*(31+28+31+30+31+30+31)+1):(24*(31+28+31+30+31+30+31+31))
    s(j)=as(8)*s0(j);
end
for j=(24*(31+28+31+30+31+30+31+31)+1):(24*(31+28+31+30+31+30+31+31+30))
    s(j)=as(9)*s0(j);
end
for j=(24*(31+28+31+30+31+30+31+31+30)+1):(24*(31+28+31+30+31+30+31+31+30+31))
    s(j)=as(10)*s0(j);
end
for j=(24*(31+28+31+30+31+30+31+31+30+31)+1):(24*(31+28+31+30+31+30+31+31+30+31+30))
    s(j)=as(11)*s0(j);
end
for j=(24*(31+28+31+30+31+30+31+31+30+31+30)+1):(24*(31+28+31+30+31+30+31+31+30+31+30+31))
    s(j)=as(12)*s0(j);
end
%转化成24时输出
%s=s'*10000;
%以下为计算逐时饱和水汽压
%气温的单位为0.1摄氏度   %，标准化为国际温度单位
%t=0.1*t;
T=dbt+273.15;
%输入系数相
c1=-5674.5359;
c2=6.3925247;
c3=-0.9677843e-2;
c4=0.62215701e-6;
c5=0.20747825e-8;
c6=-0.9484024e-12;
c7=4.1635019;
c8=-5800.2206;
c9=1.3914993;
c10=-0.04860239;
c11=0.41764768e-4;
c12=-0.14452093e-7;
c13=6.5459673;
L=length(T);
for i=1:L
    if (T(i)-273.15<0)
        Pws(i)=exp(c1/T(i)+c2+c3*T(i)+c4*T(i)^2+c5*T(i)^3+c6*T(i)^4+c7*log(T(i)));
    else
        Pws(i)=exp(c8/T(i)+c9+c10*T(i)+c11*T(i)^2+c12*T(i)^3+c13*log(T(i)));
    end
end
Pws=Pws';
%求解逐时水汽压
%p=10*p;大气压的单位是？？
%%%%%饱和压力
%Pv(i)=611.2*exp((18.678-t(i)/234.5)*t(i)/(t(i)+257.14));
%% Pw(i)=Pqb(i).*h(i);
%%%%%饱和压力乘以相对湿度是水蒸气压力
%%Ws(i)=0.62198*Pw(i)./(p(i)-Pw(i));
%%%%%%含湿量
%Pw=(s.*p)./(0.62198+s);
Pw=(s'.*p)./(0.62198+s');
%求解相对湿度
h=Pw./Pws;
L=length(h);
for i=1:L
    if (h(i)>1)
        h(i)=1;
    end
end
h=h*100;
k=1;
%转化成24时输出
for i=1:1:F
    xxx(i)=k;
    k=k+1;
    if k==25
        k=1;
    end
end
%24时，竖着输出fid是文件file的ID %6.1f 6代表小数点前有六位数，1代表小数点后有1位数，f代表自由格式输出
% wt是write的简写
xxx=xxx';
s=s';
% h=h';
fid=fopen('E:\论文\预测未来逐时天气\预测未来逐时天气\FutureHourlyRH.txt','wt');
for i=1:1:F
    fprintf(fid, '%3.0f %6.1f\n',xxx(i),h(i));
end
fclose(fid);
汇总数据
function zongshuju(data4,data5)
data4=load('E:\论文\预测未来逐时天气\预测未来逐时天气\FutureHourlydbt.txt');
data5=load('E:\论文\预测未来逐时天气\预测未来逐时天气\FutureHourlygsrdifdir.txt');
data6=load('E:\论文\预测未来逐时天气\预测未来逐时天气\FutureHourlys.txt');
data7=load('E:\论文\预测未来逐时天气\预测未来逐时天气\FutureHourlyRH.txt');
dbt=data4(:,6);  
dbt=dbt';
dbt=reshape(dbt,24,365);
dbt=dbt';
gsr=data5(:,6);
gsr=gsr';
gsr=reshape(gsr,24,365);
gsr=gsr';
dir=data5(:,7);
dir=dir';
dir=reshape(dir,24,365);
dir=dir';
dif=data5(:,8);
dif=dif';
dif=reshape(dif,24,365);
dif=dif';
rhm=data7(:,2);
rhm=rhm';
rhm=reshape(rhm,24,365);
rhm=rhm';
ss=data6(:,2);
ss=ss';
ss=reshape(ss,24,365);
ss=ss';
%气压：qiya 三次样条插值
%干球温度：ganqiuwendu 三次样条插值
%相对湿度：xiangduishidu 直线插值
%风向：fengxiang 直线插值
%风速：fengsu 直线插值
%总云量：zongyunliang 直线插值
for i=1:1:365
    j=(i-1)*24+1;
    year(i)=data4(j,2);
    month(i)=data4(j,3);
    day(i)=data4(j,4);
    taizhanhao(i)=data4(j,1);
end
year=year';
month=month';
day=day';
taizhanhao=taizhanhao';
% 24时，横着输出 fid是文件file的ID %6.1f 6代表小数点前有六位数，1代表小数点后有1位数，f代表自由格式输出
% wt是write的简写
fid=fopen('E:\论文\预测未来逐时天气\预测未来逐时天气\zongshuju.txt','wt');

for i=1:1:365
    fprintf(fid,'%3.0f %3.0f %3.0f %3.0f dbt %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f\n',year(i),month(i),day(i),taizhanhao(i),dbt(i,:));
end
for i=1:1:365
    fprintf(fid,'%3.0f %3.0f %3.0f %3.0f rhm %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f\n',year(i),month(i),day(i),taizhanhao(i),rhm(i,:));
end
for i=1:1:365
    fprintf(fid,'%3.0f %3.0f %3.0f %3.0f ss %6.6f %6.6f %6.6f %6.6f %6.6f %6.6f %6.6f %6.6f %6.6f %6.6f %6.6f %6.6f %6.6f %6.6f %6.6f %6.6f %6.6f %6.6f %6.6f %6.6f %6.6f %6.6f %6.6f %6.6f\n',year(i),month(i),day(i),taizhanhao(i),ss(i,:));
end
for i=1:1:365
    fprintf(fid,'%3.0f %3.0f %3.0f %3.0f gsr %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f\n',year(i),month(i),day(i),taizhanhao(i),gsr(i,:));
end
for i=1:1:365
    fprintf(fid,'%3.0f %3.0f %3.0f %3.0f dir %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f\n',year(i),month(i),day(i),taizhanhao(i),dir(i,:));
end
for i=1:1:365
    fprintf(fid,'%3.0f %3.0f %3.0f %3.0f dif %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f\n',year(i),month(i),day(i),taizhanhao(i),dif(i,:));
end
fclose(fid);
