function demo_display
%DEMO_DISPLAY Demo of the display of various 2D and 3D shapes.

%--------------------------------------------------------------------------
% 2D circles
%--------------------------------------------------------------------------
% Parameters
radiuses = [20 10];
centers = [100 40; 100 80];

displayEmpty2DFigure();
displayCircles(centers, radiuses);

%--------------------------------------------------------------------------
% 2D ellipses
%--------------------------------------------------------------------------
% Parameters
radiuses = [20 10 ; 40 10];
centers = [100 40; 100 80];
orientationAngles = [deg2rad(10) deg2rad(40)];
colors = [1 0 0 ; 0 0 1];

displayEmpty2DFigure();
displayEllipses(centers, radiuses, orientationAngles, colors);

%--------------------------------------------------------------------------
% 3D spheres
%--------------------------------------------------------------------------
% Parameters
radiuses = [2 4];
centers = [1 2 3; 0 0 0];

displayEmpty3DFigure();
displaySpheres(centers, radiuses);

%--------------------------------------------------------------------------
% 3D discs
%--------------------------------------------------------------------------
displayEmpty3DFigure();
displayDiscs([0 0 0; 10 0 0], [2; 4], [v3_getRandom(); 1 0 0])

%--------------------------------------------------------------------------
% 3D ellipsoids
%--------------------------------------------------------------------------
centers = [1 2 3; 0 0 0];
covariance1 = [0.0227303 -0.10195 0.015868 ;
              -0.10195 0.460016 -0.0718848 ;
               0.015868 -0.0718848 0.0112626 ]
covariance2 = [1 0 0
               0 5 0
               0 0 1];

displayEmpty3DFigure();
displayEllipsoids(centers, [reshape(covariance1, 1, 9); ...
                            reshape(covariance2, 1, 9)])

pause, close all;