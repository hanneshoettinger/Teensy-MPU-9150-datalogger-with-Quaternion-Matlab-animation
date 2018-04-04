function draw_quaternions

% import CSV from datalogger
[name path] = uigetfile('*.CSV');
test = importdata(fullfile(path,name));
valuematrix = test.data;

quat = valuematrix(:,1:4);
% create time axis -> 200Hz sampling rate
time = linspace(0,length(quat)/200,length(quat));
ts = timeseries(quat,time);

acc = valuematrix(:,5:7);
gyro = valuematrix(:,8:10);
mag = valuematrix(:,11:13);
vec = [1 1 1];
o = [1 1 1];  %# Origin

counter = 0;

mpuquat = 1;   % 1 to use quaternion data from mpu (Gyro & Acc), 0 for AHRS (

alpha = 0.1;

% complemantary filter
for u = 1:length(time)
    if u == 1
        accf(u,1) = alpha * acc(u,1);
        accf(u,2) = alpha * acc(u,2);
        accf(u,3) = alpha * acc(u,3);
        
        gyrof(u,1) = alpha * gyro(u,1);
        gyrof(u,2) = alpha * gyro(u,2);
        gyrof(u,3) = alpha * gyro(u,3);
        
        magf(u,1) = alpha * mag(u,1);
        magf(u,2) = alpha * mag(u,2);
        magf(u,3) = alpha * mag(u,3);
        
        Gyrowinkel(u,1) = (time(2)-time(1)).*gyrof(u,1);
        Gyrowinkel(u,2) = (time(2)-time(1)).*gyrof(u,2);
        Gyrowinkel(u,3) = (time(2)-time(1)).*gyrof(u,3);
    else
        accf(u,1) = accf(u-1,1) + alpha * (acc(u,1) - accf(u-1,1));
        accf(u,2) = accf(u-1,2) + alpha * (acc(u,2) - accf(u-1,2));
        accf(u,3) = accf(u-1,3) + alpha * (acc(u,3) - accf(u-1,3));
        
        gyrof(u,1) = gyrof(u-1,1) + alpha * (gyro(u,1) - gyrof(u-1,1));
        gyrof(u,2) = gyrof(u-1,2) + alpha * (gyro(u,2) - gyrof(u-1,2));
        gyrof(u,3) = gyrof(u-1,3) + alpha * (gyro(u,3) - gyrof(u-1,3));
        
        magf(u,1) = magf(u-1,1) + alpha * (mag(u,1) - magf(u-1,1));
        magf(u,2) = magf(u-1,2) + alpha * (mag(u,2) - magf(u-1,2));
        magf(u,3) = magf(u-1,3) + alpha * (mag(u,3) - magf(u-1,3));
        
        Gyrowinkel(u,1) = Gyrowinkel(u-1,1) + (time(2)-time(1)).*gyrof(u,1);
        Gyrowinkel(u,2) = Gyrowinkel(u-1,2) + (time(2)-time(1)).*gyrof(u,2);
        Gyrowinkel(u,3) = Gyrowinkel(u-1,3) + (time(2)-time(1)).*gyrof(u,3);
    end
end

accxnorm = accf(:,1)./sqrt(accf(:,1).*accf(:,1)+accf(:,2).*accf(:,2)+accf(:,3).*accf(:,3));
accynorm = accf(:,2)./sqrt(accf(:,1).*accf(:,1)+accf(:,2).*accf(:,2)+accf(:,3).*accf(:,3));

% calculate euler angles
Pitch = asin(-accxnorm);
Roll = asin(accynorm./cos(Pitch));

sigma = atan2(sqrt(accxnorm.^2+accynorm.^2),accf(:,3));

sigma = sigma .* (180/pi);

for i = 1:length(time)
    if i == 1
        compAngleX(i) = 0.93 * ((time(2)-time(1)).*gyrof(i,1) ) + (0.07 * Roll(i)); 
        compAngleY(i) = 0.93 * ((time(2)-time(1)).*gyrof(i,2) ) + (0.07 * Pitch(i));  
    else
        compAngleX(i) = 0.93 * (compAngleX(i-1) + (time(2)-time(1)).*gyrof(i,1) ) + (0.07 * Roll(i)); 
        compAngleY(i) = 0.93 * (compAngleY(i-1) + (time(2)-time(1)).*gyrof(i,2) ) + (0.07 * Pitch(i));  
    end
end

compAngleX = compAngleX .* (pi/180);
compAngleY = compAngleY .* (pi/180);

magxcomp = magf(:,1).*cos(compAngleY(:))+magf(:,3).*sin(compAngleY(:));
magycomp = magf(:,1).*sin(compAngleX(:)).*sin(compAngleY(:))+magf(:,2).*cos(compAngleX(:))-magf(:,3).*sin(compAngleX(:)).*cos(compAngleY(:));

Heading = 180.*atan2(magycomp,magxcomp)./pi;
compAngleX = compAngleX .* (180/pi);
compAngleY = compAngleY .* (180/pi);

% Process sensor data through algorithm, Madgwick or Mahony
AHRS = MadgwickAHRS('SamplePeriod', 1/200, 'Beta', 0.1);
%AHRS = MahonyAHRS('SamplePeriod', 1/200, 'Kp', 0.5);

quaternion = zeros(length(time), 4);
for t = 1:length(time)
    AHRS.Update(gyrof(t,:) * (pi/180), accf(t,:), magf(t,:));	% gyroscope units must be radians
    %AHRS.UpdateIMU(gyrof(t,:) * (pi/180), accf(t,:));	% gyroscope units must be radians
    quaternion(t, :) = AHRS.Quaternion;
end

g = [0 .5 0];

figure(2)
%for i = 1:1:size(acc, 1)
    plot(time,accf(:,1),'r',time,accf(:,2),'g',time,accf(:,3),'b');
    ylim([min(min(accf)) max(max(accf))]);
    legend('x','y','z');
    set(gca,'Fontsize',12,'FontWeight','b');
    xlabel('Zeit [s]','FontSize',14,'FontWeight','bold')
    ylabel('Beschleunigung [g]','FontSize',14,'FontWeight','bold')
%end
figure(3)
%for i = 1:1:size(acc, 1)
    plot(time,gyrof(:,1),'r',time,gyrof(:,2),'g',time,gyrof(:,3),'b');
    ylim([min(min(gyrof)) max(max(gyrof))]);
    legend('x','y','z');
    set(gca,'Fontsize',12,'FontWeight','b');
    xlabel('Zeit [s]','FontSize',14,'FontWeight','bold')
    ylabel('Winkelgeschwindigkeit [�/s]','FontSize',14,'FontWeight','bold')
   
figure(4)
%for i = 1:1:size(acc, 1)
    plot(time,magf(:,1),'r',time,magf(:,2),'g',time,magf(:,3),'b');
    ylim([min(min(magf)) max(max(magf))]);
    legend('x','y','z');
    set(gca,'Fontsize',12,'FontWeight','b');
    xlabel('Zeit [s]','FontSize',14,'FontWeight','bold')
    ylabel('Magnetfeld [uT]','FontSize',14,'FontWeight','bold')
    
figure(5)
    plot(time,quaternion(:,1),'k',time,quaternion(:,2),'r',time,quaternion(:,3),'g',time,quaternion(:,4),'b')
    legend('w','x','y','z');
    set(gca,'Fontsize',12,'FontWeight','b');
    xlabel('Zeit [s]','FontSize',14,'FontWeight','bold')
    ylabel('Quaternions','FontSize',14,'FontWeight','bold')
 
testfig = figure;
figure(testfig); 

axis([-2 2 -2 2 -2 2]); axis equal vis3d; hold on;

mTextBox = uicontrol('style','text');
hfig1 = uicontrol('Style','text','String','x','Units','normalized','Position',[.05,0.5,.05,.03]);
set(hfig1,'ForegroundColor','r');
hfig2 = uicontrol('Style','text','String','y','Units','normalized','Position',[.05,0.47,.05,.03]);
set(hfig2,'ForegroundColor',[0 .5 0]);
hfig3 = uicontrol('Style','text','String','z','Units','normalized','Position',[.05,0.44,.05,.03]);
set(hfig3,'ForegroundColor','b');

% Put a point at the origin
plot3(0, 0, 0, 'o');
xlim([-2 2])
ylim([-2 2])
zlim([-2 2])

lineStart = [0 0 0];
lineEnd = [0 0 0];

orientationLineLength = 1;

if mpuquat == 1
    for i = 1:1:size(quat,1)
        % Orientation line in X orientation
        lineEndx(i,:) = q_rotatePoint(orientationLineLength * [1 0 0], quat(i, :));
        % Orientation line in Y orientaton
        lineEndy(i,:) = q_rotatePoint(orientationLineLength * [0 1 0], quat(i, :));
        % Orientation line in Z orientaton
        lineEndz(i,:) = q_rotatePoint(orientationLineLength * [0 0 1], quat(i, :));
    end
else
    for i = 1:1:size(quat,1)
        % Orientation line in X orientation
        lineEndx(i,:) = q_rotatePoint(orientationLineLength * [1 0 0], quaternion(i, :));
        % Orientation line in Y orientaton
        lineEndy(i,:) = q_rotatePoint(orientationLineLength * [0 1 0], quaternion(i, :));
        % Orientation line in Z orientaton
        lineEndz(i,:) = q_rotatePoint(orientationLineLength * [0 0 1], quaternion(i, :));
    end
end

t = timer('TimerFcn', @(~,~)draw(lineEndx,lineEndy,lineEndz),'StartDelay', 2, 'Period', 0.05, 'TasksToExecute', size(quat,1), ...
          'ExecutionMode', 'fixedRate');
global pos;
pos = 1;

start(t)

%delete(t)

end


% draw updated rotation
function draw(lineEndx, lineEndy, lineEndz)
%for i = 1:10:size(quat, 1)
    % clear axes
    global pos;
    cla
    %tic
  % Orientation line in X orientation
    h1 = arrow3([-lineEndx(pos,1),-lineEndx(pos,2),-lineEndx(pos,3)],[lineEndx(pos,1),lineEndx(pos,2),lineEndx(pos,3)],'-r2.5',1.5,3,1);
    
  % Orientation line in Y orientaton
    h2 = arrow3([-lineEndy(pos,1),-lineEndy(pos,2),-lineEndy(pos,3)],[lineEndy(pos,1),lineEndy(pos,2),lineEndy(pos,3)],'-e2.5',1.5,3,1);

  % Orientation line in Z orientaton
    
    h3 = arrow3([-lineEndz(pos,1),-lineEndz(pos,2),-lineEndz(pos,3)],[lineEndz(pos,1),lineEndz(pos,2),lineEndz(pos,3)],'-b2.5',1.5,3,1);
    
   %texttime = num2str(time(pos));
   %set(mTextBox,'String',texttime); 
   pos = pos+10;
   %toc
   %pause(0.03);
   
end
