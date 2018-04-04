function currentViewpoint(action)
%CURRENTVIEWPOINT Save/restore camera parameters in current figure.
%   CURRENTVIEWPOINT(ACTION) saves or restores camera parameters and axis
%   limits in current figure. It can serve to set similar appearance to
%   several figures.
%
%   ACTION can be 'save' or 'restore'.

%   Author: Damien Teney

persistent camproj_saved campos_saved camtarget_saved camva_saved camup_saved;
persistent xlim_saved ylim_saved zlim_saved;
persistent somethingSaved;

switch lower(action)
  case 'save'
    % Camera parameters
    camproj_saved   = camproj();
    campos_saved    = campos();
    camtarget_saved = camtarget();
    camva_saved     = camva();
    camup_saved     = camup();

    % Axis limits
    xlim_saved      = xlim();
    ylim_saved      = ylim();
    zlim_saved      = zlim();

  case 'restore'
    if isempty(camproj_saved)
      error('No parameters saved !')
    end

    % Camera parameters
    camproj  (camproj_saved  );
    campos   (campos_saved   );
    camtarget(camtarget_saved);
    camva    (camva_saved    );
    camup    (camup_saved    );

    % Axis limits
    xlim     (xlim_saved     );
    ylim     (ylim_saved     );
    zlim     (zlim_saved     );

  otherwise
    error('Unknown action.')
end
