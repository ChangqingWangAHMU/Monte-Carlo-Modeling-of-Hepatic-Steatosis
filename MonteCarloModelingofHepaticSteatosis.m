 function varargout = MonteCarloModelingofHepaticSteatosis(varargin)
% MONTECARLOMODELINGOFHEPATICSTEATOSIS MATLAB code for MonteCarloModelingofHepaticSteatosis.fig
%      MONTECARLOMODELINGOFHEPATICSTEATOSIS, by itself, creates a new MONTECARLOMODELINGOFHEPATICSTEATOSIS or raises the existing
%      singleton*.
%
%      H = MONTECARLOMODELINGOFHEPATICSTEATOSIS returns the handle to a new MONTECARLOMODELINGOFHEPATICSTEATOSIS or the handle to
%      the existing singleton*.
% 
%      MONTECARLOMODELINGOFHEPATICSTEATOSIS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MONTECARLOMODELINGOFHEPATICSTEATOSIS.M with the given input arguments.
%
%      MONTECARLOMODELINGOFHEPATICSTEATOSIS('Property','Value',...) creates a new MONTECARLOMODELINGOFHEPATICSTEATOSIS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MonteCarloModelingofHepaticSteatosis_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MonteCarloModelingofHepaticSteatosis_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES
% Edit the above text to modify the response to Help MonteCarloModelingofHepaticSteatosis
% Last Modified by GUIDE v2.5 29-Mar-2023 16:28:48
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MonteCarloModelingofHepaticSteatosis_OpeningFcn, ...
                   'gui_OutputFcn',  @MonteCarloModelingofHepaticSteatosis_OutputFcn, ...
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

% --- Executes just before MonteCarloModelingofHepaticSteatosis is made visible.
function MonteCarloModelingofHepaticSteatosis_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MonteCarloModelingofHepaticSteatosis (see VARARGIN)
% Choose default command line output for MonteCarloModelingofHepaticSteatosis
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = MonteCarloModelingofHepaticSteatosis_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Get default command line output from handles structure
varargout{1} = handles.output;
javaFrame = get(gcf,'JavaFrame');
set(javaFrame,'Maximized',1);

% --- Executes on button press in save.
function save_Callback(hObject, eventdata, handles)
% hObject    handle to save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Target_FF
global r
global size_sphere
global N_sphere
global Section_2Dradiu
global Randomsection
data_3D=[r,size_sphere'];
ht_3D={'ID','X','Y','Z','Radius (¦Ìm)'};
ID_3D=[1:N_sphere]';
xlswrite(['3D_Coordinate&Size_FF' num2str(Target_FF) '%.xlsx'],ht_3D,1,'A1');
xlswrite(['3D_Coordinate&Size_FF' num2str(Target_FF) '%.xlsx'],ID_3D,1,'A2');
xlswrite(['3D_Coordinate&Size_FF' num2str(Target_FF) '%.xlsx'],data_3D,1,'B2');
ht_2D={'ID','X',' Y','Radius (¦Ìm)'};
ID_2D=[1:length(Section_2Dradiu)]';
xlswrite(['2D_Coordinate&Size_FF' num2str(Target_FF) '%_location' num2str(Randomsection) '¦Ìm.xlsx'],ht_2D,1,'A1');
xlswrite(['2D_Coordinate&Size_FF' num2str(Target_FF) '%_location' num2str(Randomsection) '¦Ìm.xlsx'],ID_2D,1,'A2');
xlswrite(['2D_Coordinate&Size_FF' num2str(Target_FF) '%_location' num2str(Randomsection) '¦Ìm.xlsx'],Section_2Dradiu,1,'B2');
new_f_handle=figure('visible','on');
new_axes=copyobj(handles.axes1,new_f_handle);
set(new_axes,'units','default','position','default');
savefig(new_f_handle, ['3DModel_FF' num2str(Target_FF) '%.fig']);
delete(new_f_handle);
new_f_handle=figure('visible','on');
new_axes=copyobj(handles.axes2,new_f_handle); 
set(new_axes,'units','default','position',[0.158 0.158 0.8 0.8]);
savefig(new_f_handle, ['2DSection_FF' num2str(Target_FF) '%_location' num2str(Randomsection) '¦Ìm.fig']);
delete(new_f_handle);

% --- Executes on button press in MonteCarloModelingofHepaticSteatosis.
function model_Callback(hObject, eventdata, handles)
% hObject    handle to MonteCarloModelingofHepaticSteatosis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Target_FF
Target_FF=(str2num(get(handles.TargetFF,'String')));
global liversize
liversize=800;
global FD_CO_R_NN_Volume
global size_sphere
global r
global distance_nn_ee
global size_fat
global N_sphere
beta_size=exp(0.3631*log(Target_FF/100)+0.6599);gamma_size=exp(-0.6674*log(beta_size)+2.0189);
beta_nnd=exp(-0.2172*log(Target_FF/100)-0.5203); gamma_nnd=exp(-0.6061*log(beta_nnd)+2.7762);
beta_RA=exp(0.5119*log(Target_FF/100)+3.2968);gamma_RA=exp(0.3305*log(Target_FF/100)+0.8593);
Current_FF=0;u=0;
N_sphere=(str2num(get(handles.N_sphere,'String')));
while Current_FF<(Target_FF/100)
    N_sphere=N_sphere+10;
    rng(1,'v5uniform');x_cdf_sd=rand(1,N_sphere);
    size_sphere=zeros(1,N_sphere);
    for i=1:N_sphere
        size_sphere(1,i)=fzero(@(x) gamcdf(x,gamma_size,beta_size)-x_cdf_sd(1,i),0);
    end
    Current_FF=4/3*pi*sum(size_sphere.^3)/800^3;
end
RA_fd=RA_GDF(N_sphere,u,gamma_RA,beta_RA);    
Size_FDs=[];
aa=[0,cumsum(RA_fd,2)];
distance_nn=gamrnd(gamma_nnd,beta_nnd,N_sphere,1);
for numbers=1:125
   Size_FDs{numbers}=size_sphere(aa(numbers)+1:aa(numbers+1))';
   nnd_fat{numbers}=distance_nn(aa(numbers)+1:aa(numbers+1));
end
[H,W,L]=meshgrid(0:160:640,0:160:640,0:160:640);
FD_CO_R_NN_Volume=[];Def_R_NN=[];
for num=1:length(H(:))
    FD_CO_R_NN_CUBE=[];Defeated=[];
    if ~isempty(Size_FDs{num})
        [FD_CO_R_NN_CUBE,FD_CO_R_NN_CUBE(:,4),FD_CO_R_NN_CUBE(:,5),Defeated]=FatDistribution_CNN(Size_FDs{num},nnd_fat{num},H(num),L(num),W(num),liversize/5);
        FD_CO_R_NN_Volume=[FD_CO_R_NN_Volume;FD_CO_R_NN_CUBE];Def_R_NN=[Def_R_NN;Defeated];
    end
end
if isempty(Def_R_NN)
    r=FD_CO_R_NN_Volume(:,1:3);size_fat=FD_CO_R_NN_Volume(:,4);distance_nn_ee=FD_CO_R_NN_Volume(:,5);
else
    [r,size_fat,distance_nn_ee]=Defeated_FatDistribution_CNN(Def_R_NN(:,1),Def_R_NN(:,2),liversize,FD_CO_R_NN_Volume(:,1:3),FD_CO_R_NN_Volume(:,4),FD_CO_R_NN_Volume(:,5));
    FD_CO_R_NN_Volume=[];
    FD_CO_R_NN_Volume(:,1:3)=r;FD_CO_R_NN_Volume(:,4)=size_fat;FD_CO_R_NN_Volume(:,5)=distance_nn_ee;
end
axes(handles.axes1);cla(handles.axes1);
% for number=1:length(distance_nn_ee)
%    [x,y,z]=ellipsoid(r(number,1),r(number,2),r(number,3),size_fat(number),size_fat(number),size_fat(number));
%     surf(x,y,z,'edgecolor',[0.52941 0.80784 0.92157],'facecolor',[0.52941 0.80784 0.92157],'linestyle','none','facealpha',0.2);
%     alpha(0.1);
%     drawnow;
x=r(:,1);
y=r(:,2);
z=r(:,3);
plot3(x,y,z,'.','color',[0.52941 0.80784 0.92157],'linestyle','none');
view([-37.5,30])
    hold on;
    axis equal 
    axis([0 800 0 800 0 800]);
    box on
% end
box on;grid on;axis equal;axis([0 800 0 800 0 800]);set(gca,'Xtick',(0:160:800),'Ytick',(0:160:800),'Ztick',(0:160:800));
set(gca,'FontSize',16,'FontName','Times New Roman')
Current_FF=Current_FF*100;
set(handles.CurrentFF,'String','');
set(handles.CurrentFF,'String',Current_FF);
set(handles.N_sphere,'String','');
set(handles.N_sphere,'String',N_sphere);

% --- Executes on button press in clear.
function clear_Callback(hObject, eventdata, handles)
% hObject    handle to clear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.CurrentFF,'String','0');set(handles.N_sphere,'String','0');set(handles.TargetFF,'String','0');set(handles.location,'String','');
axes(handles.axes1);
cla reset
set(handles.axes1,'xtick',[]);
set(handles.axes1,'ytick',[]);
set( gca, 'XColor', 'w' ); set( gca, 'YColor', 'w' );
axes(handles.axes2);
cla reset
set(handles.axes2,'xtick',[]);
set(handles.axes2,'ytick',[]);
set( gca, 'XColor', 'w' ); set( gca, 'YColor', 'w' );
clear all;clc;

function CurrentFF_Callback(hObject, eventdata, handles)
% hObject    handle to CurrentFF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of CurrentFF as text
%        str2double(get(hObject,'String')) returns contents of CurrentFF as a double
% --- Executes during object creation, after setting all properties.

function CurrentFF_CreateFcn(hObject, eventdata, handles)
% hObject    handle to currentff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in section.
function section_Callback(hObject, eventdata, handles)
% hObject    handle to section (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global liversize
global Target_FF
global FD_CO_R_NN_Volume
global Section_2Dradiu
global Randomsection
FF_Section=0; thick=5;
while abs(FF_Section-Target_FF)>0.5
    Randomsection=5*liversize*rand(1);
    FD_boundary(:,1)=FD_CO_R_NN_Volume(:,3)+FD_CO_R_NN_Volume(:,4);
    FD_boundary(:,2)=FD_CO_R_NN_Volume(:,3)-FD_CO_R_NN_Volume(:,4);
    Intersection_both=[];
    Intersection_both=FD_CO_R_NN_Volume(find(FD_boundary(:,2)<Randomsection&(Randomsection+thick)<FD_boundary(:,1)),:);
    %% 
    Intersection_Radiu_both=[];Section_FD_both=[];Intersection_top=[];Intersection_Radiu_top=[];Section_FD_top=[];
    Intersection_low=[];Intersection_Radiu_low=[];Section_FD_low=[];Section_Radiu=[];
    if(find(FD_boundary(:,2)<Randomsection&(Randomsection+5)<FD_boundary(:,1))==0)
        Intersection_both=ones(1,3)*nan;
    else
        Section_Radiu(:,1)=sqrt(Intersection_both(:,4).^2-(abs(Intersection_both(:,3)-Randomsection)).^2);
        Section_Radiu(:,2)=sqrt(Intersection_both(:,4).^2-(abs(Intersection_both(:,3)-(Randomsection+thick))).^2);
        Intersection_Radiu_both=max(Section_Radiu(:,2),[],2);
    end
    Section_FD_both=[Intersection_both(:,1:2),Intersection_Radiu_both];
    Intersection_top=FD_CO_R_NN_Volume(find(FD_boundary(:,2)<Randomsection+thick&Randomsection<FD_boundary(:,2)&FD_boundary(:,1)>Randomsection+thick),:);
    if(find(FD_boundary(:,2)<Randomsection+thick&Randomsection<FD_boundary(:,2)&FD_boundary(:,1)>Randomsection+thick)==0)
        Intersection_top=ones(1,3)*nan;
    else
        Intersection_Radiu_top=sqrt(Intersection_top(:,4).^2-(abs(Intersection_top(:,3)-(Randomsection+thick))).^2);
    end
    Section_FD_top=[Intersection_top(:,1:2),Intersection_Radiu_top];
    Intersection_low=FD_CO_R_NN_Volume(find(FD_boundary(:,1)<Randomsection+thick&Randomsection<FD_boundary(:,1)&FD_boundary(:,2)<Randomsection),:);
    if(find(FD_boundary(:,1)<Randomsection+thick&Randomsection<FD_boundary(:,1)&FD_boundary(:,2)<Randomsection)==0)
        Intersection_low=ones(1,3)*nan;
    else
        Intersection_Radiu_low=sqrt(Intersection_low(:,4).^2-(abs(Intersection_low(:,3)-Randomsection)).^2);
    end
    counts_2DNND=[];centers_2DNND=[];Section_FD_low=[Intersection_low(:,1:2),Intersection_Radiu_low]; Section_FD=[Section_FD_both;Section_FD_top;Section_FD_low];     
    Section_2Dradiu=Section_FD;
    FF_Section=100*sum(pi*Section_2Dradiu(:,3).^2)/800^2;
end
axes(handles.axes2); cla(handles.axes2);cla reset
set( gca, 'XColor', 'k '); set( gca, 'YColor', 'k' );
for z=1:length(Section_2Dradiu)
    hold on;rectangle('Position',[Section_2Dradiu(z,1)-Section_2Dradiu(z,3),Section_2Dradiu(z,2)-Section_2Dradiu(z,3),2*Section_2Dradiu(z,3),2*Section_2Dradiu(z,3)],...
        'Curvature', [1 1],'edgecolor',[0.52941 0.80784 0.92157],'facecolor',[0.52941 0.80784 0.92157]);
end
set(gca,'box','on');
box on;grid on;axis equal;axis([0 800 0 800]);set(gca,'Xtick',(0:160:800),'Ytick',(0:160:800));grid on;
set(gca,'FontSize',16,'FontName','Times New Roman')
set(handles.location,'String','');
set(handles.location,'String',Randomsection);

function N_sphere_Callback(hObject, eventdata, handles)
% hObject    handle to N_sphere (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of N_sphere as text
%        str2double(get(hObject,'String')) returns contents of N_sphere as a double
global Target_FF
Target_FF=(str2num(get(handles.TargetFF,'String')));
global N_sphere
beta_size=exp(0.3631*log(Target_FF/100)+0.6599);gamma_size=exp(-0.6674*log(beta_size)+2.0189);
beta_nnd=exp(-0.2172*log(Target_FF/100)-0.5203); gamma_nnd=exp(-0.6061*log(beta_nnd)+2.7762);
beta_RA=exp(0.5119*log(Target_FF/100)+3.2968);gamma_RA=exp(0.3305*log(Target_FF/100)+0.8593);
Current_FF=0;u=0;
N_sphere=(str2num(get(handles.N_sphere,'String')));
Current_FF<(Target_FF/100);
    N_sphere=N_sphere+10;
    rng(1,'v5uniform');x_cdf_sd=rand(1,N_sphere);
    size_sphere=zeros(1,N_sphere);
    for i=1:N_sphere
        size_sphere(1,i)=fzero(@(x) gamcdf(x,gamma_size,beta_size)-x_cdf_sd(1,i),0);
    end
Current_FF=4/3*pi*sum(size_sphere.^3)/800^3;
Current_FF=Current_FF*100;
set(handles.CurrentFF,'String','');
set(handles.CurrentFF,'String',Current_FF);
clear;

% --- Executes during object creation, after setting all properties.
function N_sphere_CreateFcn(hObject, eventdata, handles)
% hObject    handle to N_sphere (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function TargetFF_Callback(hObject, eventdata, handles)
% hObject    handle to CurrentFF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of CurrentFF as text
%        str2double(get(hObject,'String')) returns contents of CurrentFF as a double
global Target_FF
Target_FF=(str2num(get(handles.TargetFF,'String')));

% --- Executes during object creation, after setting all properties.
function TargetFF_CreateFcn(hObject, eventdata, handles)
% hObject    handle to targetff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function location_Callback(hObject, eventdata, handles)
% hObject    handle to location (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of location as text
%        str2double(get(hObject,'String')) returns contents of location as a double

% --- Executes during object creation, after setting all properties.
function location_CreateFcn(hObject, eventdata, handles)
% hObject    handle to location (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function amount_fat=RA_GDF(N_sphere,u,upsilon_ca,beta_ca)
%The amount of fat droplets per cube
%input:N_sphere--number of N_sphere;
%      u--location parameter in GDF;
%      upsilon_ca--shape parameter in GDF;
%      beta_ca--scale parameter in GDF
%output:amount_fat--amount of fat droplets per cube
rng(3,'v5uniform');x_cdf_ca=rand(1,125);
amount_fat=zeros(1,125);
for i=1:125
    amount_fat(1,i)=fzero(@(x) gamcdf(x-u,upsilon_ca,beta_ca)-x_cdf_ca(1,i),0);
end
% figure;hist(amount_fat,10);xlabel('Number of fat droplets');ylabel('Frequency');title('Regional Anisotropy');
amount_fat=round(amount_fat/sum(amount_fat)*N_sphere);
amount_fat(end)=amount_fat(end)+(N_sphere-sum(amount_fat(:)));
if amount_fat(end)<0
    amount_fat(find(amount_fat==max(amount_fat)))=amount_fat(find(amount_fat==max(amount_fat)))+amount_fat(end);
    amount_fat(end)=0;
end

function [CO_FD,Size_fd,NND_cc,Defeated_FD]=FatDistribution_CNN(Size_fd,NND_cc,H,L,W,liversize)
%Fat droplets were placed in a nonoverlapping manner within the subregion
%input : Size_fd--The size of fat droplets;
%        NND_cc--The distance from the surface of fat droplets;
%        L,W,H,--Coordinates(x,y,z) of the subregion origin;
%        liversize--Size of the subregion.
%output : CO_FD--The coordinates of fat droplets in the subregion;
%         Size_fd--The size of fat droplets in the subregion;
%         NND_cc--The distance from the surface of fat droplets;
%         Defeated_FD--Fat drops that has not been reasonably placed
Defeated_FD=[];defeated_num=[];
% Size_fd =sort (Size_fd,'descend');
Vertex_Cubic=[W L H];
while 1
    CO_FD(1,:)=(Vertex_Cubic+liversize*rand(1,3)); % L=x, W=y, H=z
    if ~ismember(0,CO_FD(1,:)-Size_fd(1)>Vertex_Cubic & CO_FD(1,:)+Size_fd(1)<Vertex_Cubic+liversize)
        break;
    end
end
for FD_num=2:length(Size_fd)
    temp=0;
    if Size_fd(FD_num)+Size_fd(FD_num-1)>NND_cc(FD_num)
       NND_cc(FD_num)=Size_fd(FD_num)+Size_fd(FD_num-1)+1e-10;
    end
    while temp<500
        collision_index=[];
        temp=temp+1;
        phi=pi*rand(1);theta=2*pi*rand(1);
        CO_FD(FD_num,:)= CO_FD(FD_num-1,:) + NND_cc(FD_num)* [sin(phi)*cos(theta) sin(phi)*sin(theta) cos(phi)];
        if ~ismember(0,CO_FD(FD_num,:)-Size_fd(FD_num)>Vertex_Cubic & CO_FD(FD_num,:)+Size_fd(FD_num)<Vertex_Cubic+liversize)
            collision_index=find(Size_fd(FD_num)*ones(FD_num-1,1) + Size_fd(1:FD_num-1)-sqrt(sum((repmat(CO_FD(FD_num,:),FD_num-1,1)-CO_FD(1:FD_num-1,:)).^2,2))>1e-10,1);
            if isempty(collision_index) % Collision detection
                break;
            end
        end        
    end
    while temp>=500 % For collisions unresolved after 500 attempts, the reference sphere was regenerated to avoid a deadlock
        temp=temp+1;
        collision_index1=[];
        CO_FD(FD_num,:)=Vertex_Cubic+liversize*rand(1,3); % L=x, W=y, H=z
        if ~ismember(0,CO_FD(FD_num,:)-Size_fd(FD_num)>Vertex_Cubic & CO_FD(FD_num,:)+Size_fd(FD_num)<Vertex_Cubic+liversize)
          collision_index1=find(Size_fd(FD_num)*ones(FD_num-1,1) + Size_fd(1:FD_num-1)-sqrt(sum((repmat(CO_FD(FD_num,:),FD_num-1,1)-CO_FD(1:FD_num-1,:)).^2,2))>1e-10,1);
          if isempty(collision_index1)
              break;
          end
        end
        if temp==1500 % For generated reference sphere falued after 500 attempts, skip the current fat droplets to avoid a deadlock;
            defeated_num=[defeated_num;FD_num]; % Retain the serial number of the fat droplets that has been skipped
            break;
        end
    end
end
    if ~isempty(defeated_num)
        Defeated_FD(:,1)=Size_fd(defeated_num);Defeated_FD(:,2)=NND_cc(defeated_num);% Retain the size and spherical distance of the fat droplets that has been skipped
        CO_FD(defeated_num,:)=[];Size_fd(defeated_num)=[];NND_cc(defeated_num)=[];
    end

function [CO_SEC,Size_fd,NND_cc]=Defeated_FatDistribution_CNN(Size_fd,NND_cc,liversize,CO_SEC,Size_SEC,NND_SEC)
%Fat droplets that has not been reasonably placed were placed in a nonoverlapping manner within the model;
%input : Size_fd--The size of fat droplets that has not been reasonably placed;
%        NND_cc--The distance from the surface of fat droplets that has not been reasonably placed;
%        liversize--Size of the virtual model.
%        CO_SEC--The coordinates of fat droplets that has been reasonably placed;
%        Size_SEC--The size of fat droplets that has been reasonably placed;
%        NND_SEC--The distance from the surface of fat droplets that has been reasonably placed;
%output : CO_SEC--The coordinates of fat droplets in the model;
%         Size_fd--The size of fat droplets in the model;
%         NND_cc--The distance from the surface of fat droplets in the model; 
    Sc_num=length(Size_SEC);
    Size_fd=[Size_SEC;Size_fd];
    while 1
        CO_SEC(Sc_num+1,:)=liversize*rand(1,3);
        if ~ismember(0,CO_SEC(Sc_num+1,:)-Size_fd(Sc_num+1)>0 & CO_SEC(Sc_num+1,:)+Size_fd(Sc_num+1)<0+liversize)
            collision_index = find(Size_fd(Sc_num+1)*ones(Sc_num,1)+Size_SEC-sqrt(sum((repmat(CO_SEC(Sc_num+1,:),Sc_num,1)- CO_SEC(1:Sc_num,:)).^2))>1e-10,1);
            if isempty(collision_index)
                break;
            end
        end
    end
    for FD_num=2:length(NND_cc)
        temp=0;
        if Size_fd(Sc_num+FD_num)+Size_fd(Sc_num+FD_num-1)>NND_cc(FD_num)
            NND_cc(FD_num)=Size_fd(Sc_num+FD_num)+Size_fd(Sc_num+FD_num-1)+1e-10;
        end
        while temp<500
            collision_index1=[];
            temp=temp+1;
            phi=pi*rand(1);theta=2*pi*rand(1);
            CO_SEC(Sc_num+FD_num,:)= CO_SEC(Sc_num+FD_num-1,:) + NND_cc(FD_num)* [sin(phi)*cos(theta) sin(phi)*sin(theta) cos(phi)];
            if ~ismember(0,CO_SEC(Sc_num+FD_num,:)-Size_fd(FD_num)>0 & CO_SEC(Sc_num+FD_num,:)+Size_fd(FD_num)<0+liversize)
                collision_index1=find(Size_fd(Sc_num+FD_num)*ones(Sc_num+FD_num-1,1)-Size_fd(1:Sc_num+FD_num-1)-...
                sqrt(sum((repmat(CO_SEC(Sc_num+FD_num,:),Sc_num+FD_num-1,1)-CO_SEC(1:Sc_num+FD_num-1,:)).^2))>1e-10,1);
                if isempty(collision_index1)
                    break;
                end
            end
        end
        while temp>=500
            temp=temp+1;
            collision_index2=[];
            CO_SEC(FD_num,:)=0+liversize*rand(1,3);
            if ~ismember(0,CO_SEC(Sc_num+FD_num,:)-Size_fd(FD_num)>0 & CO_SEC(Sc_num+FD_num,:)+Size_fd(FD_num)<0+liversize)
                collision_index2=find(Size_fd(Sc_num+FD_num)*ones(Sc_num+FD_num-1,1)-Size_fd(1:Sc_num+FD_num-1)-...
                sqrt(sum((repmat(CO_SEC(Sc_num+FD_num,:),Sc_num+FD_num-1,1)-CO_SEC(1:Sc_num+FD_num-1,:)).^2))>1e-10,1);
                if isempty(collision_index2)
                    break;
                end
            end
        end
    end
    NND_cc=[NND_SEC;NND_cc];