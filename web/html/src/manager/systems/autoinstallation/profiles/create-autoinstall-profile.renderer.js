import React from 'react';
import SpaRenderer from "core/spa/spa-renderer";
import CreateAutoinstallProfile from "./create-autoinstall-profile";

window.pageRenderers = window.pageRenderers || {};
window.pageRenderers.autoinstallation = window.pageRenderers.autoinstallation || {};
window.pageRenderers.autoinstallation.createAutoinstallProfile = window.pageRenderers.autoinstallation.createAutoinstallProfile || {};
window.pageRenderers.autoinstallation.createAutoinstallProfile.renderer = (id) => {

  SpaRenderer.renderNavigationReact(
    <CreateAutoinstallProfile />,
    document.getElementById(id),
  );
};
