''
/* Source file https://github.com/MrOtherGuy/firefox-csshacks/tree/master/chrome/tabs_on_bottom.css made available under Mozilla Public License v. 2.0
See the above repository for updates as well as full license text. */

/* Modify to change window drag space width */
/*
Use tabs_on_bottom_menubar_on_top_patch.css if you
have menubar permanently enabled and want it on top
 */

/* IMPORTANT */
/*
Get window_control_placeholder_support.css
Window controls will be all wrong without it.
Additionally on Linux, you may need to get:
linux_gtk_window_control_patch.css
*/

#toolbar-menubar[autohide="true"] > .titlebar-buttonbox-container,
#TabsToolbar > .titlebar-buttonbox-container{
  position: fixed;
  display: block;
  top: 0px;
  right:0;
  height: 40px;
}
/* Mac specific. You should set that font-smoothing pref to true if you are on any platform where window controls are on left */
@supports -moz-bool-pref("layout.css.osx-font-smoothing.enabled"){
  .titlebar-buttonbox-container{ left:0; right: unset !important; }
}

:root[uidensity="compact"] #TabsToolbar > .titlebar-buttonbox-container{ height: 32px }

#toolbar-menubar[inactive] > .titlebar-buttonbox-container{ opacity: 0 }

.titlebar-buttonbox-container > .titlebar-buttonbox{ height: 100%; }

#titlebar{
  -moz-box-ordinal-group: 2;
  -moz-appearance: none !important;
  --tabs-navbar-shadow-size: 0px;
  --uc-menubar-vertical-overlap: 19px; /* for hide_tabs_with_one_tab_w_window_controls.css compatibility */
}
/* Re-order window and tab notification boxes */
#navigator-toolbox > div{ display: contents }
.global-notificationbox,
#tab-notification-deck{ -moz-box-ordinal-group: 2 }

#TabsToolbar .titlebar-spacer{ display: none; }
/* Also hide the toolbox bottom border which isn't at bottom with this setup */
#navigator-toolbox::after{ display: none !important; }

@media (-moz-gtk-csd-close-button){ .titlebar-button{ -moz-box-orient: vertical } }

/* At Activated Menubar */
:root:not([chromehidden~="menubar"], [sizemode="fullscreen"]) #toolbar-menubar:not([autohide="true"]) + #TabsToolbar > .titlebar-buttonbox-container {
  display: block !important;
}
#toolbar-menubar:not([autohide="true"]) > .titlebar-buttonbox-container {
  visibility: hidden;
}

/* These exist only for compatibility with autohide-tabstoolbar.css */
toolbox#navigator-toolbox > toolbar#nav-bar.browser-toolbar{ animation: none; }
#navigator-toolbox:hover #TabsToolbar{ animation: slidein ease-out 48ms 1 }
#TabsToolbar > .titlebar-buttonbox-container{ visibility: visible }
#navigator-toolbox:not(:-moz-lwtheme){ background-color: -moz-dialog }

/* Uncomment the following if you want bookmarks toolbar to be below tabs */
/*
#PersonalToolbar{ -moz-box-ordinal-group: 2 }
*/

.tabbrowser-tab[selected]:not(:hover):not([pinned]) .tab-label-container,
#tabbrowser-tabs:not([closebuttons="activetab"]) .tabbrowser-tab:not(:hover):not([pinned]) .tab-label-container{ margin-inline-end: 7px }
.tab-content:not([pinned])::before{
  display: -moz-box;
  content: "";
  -moz-box-flex: 1;
}

.tab-content{
  pointer-events: none
}
.tab-icon-image:not([busy]){ display: block !important; }
:where(.tab-content:hover) .tab-icon-image,
:where(.tab-content:hover) > .tab-icon-stack{
  visibility: hidden;
}
.tab-close-button{
  -moz-box-ordinal-group: 0;
  display: -moz-box !important;
  position: relative;
  margin-inline: -4px -20px !important;
  padding-inline-start: 7px !important;
  opacity: 0;
  width: unset !important;
  pointer-events: auto;
}
.tab-close-button:hover{ opacity: 1 }
.tabbrowser-tab[pinned] .tab-close-button{ display: none !important; }

:root[lwthemetextcolor="bright"] #statuspanel-label{
  background-color: rgb(50,50,52) !important;
  color: rgb(187,187,189) !important;
  border-color: grey !important;
}

/* IF FIREFOX SLOWS DOWN< REMOVE BELOW THIS */

#urlbar::before{
  z-index: 2;
  content: "";
  display: block;
  position: absolute;
  pointer-events:none;
  background-repeat: no-repeat;
  background-image: -moz-element(#statuspanel);
  background-position: left 3px;
  inset: 1px;
}

/* Using -moz-element() causes some problems after Firefox has been running several hours such as long tab switch times. For this reason the background image is removed on hover and focused states which appears to clear the state. */

/* Hide the status ovelay when urlbar is hovered */
#urlbar:hover::before,
#urlbar[focused]::before{
  visibility: hidden;
  /* Remove the image to get rid of -moz-element() related problems */
  background-image: none !important;
}

:root[uidensity="compact"] #urlbar::before{ background-position-y: 0px }
:root[uidensity="touch"] #urlbar::before{ background-position-y: 3px }

#statuspanel-label{
  height:3em;
  min-width: 1000px;
  background-color: var(--toolbar-field-background-color) !important;
  border: none !important;
  font-size: 1.15em;
  color: inherit !important;
  margin-inline: 0px !important;
  padding-top: 3px !important;
}

/* If you use a theme where urlbar is partially transparent you should edit this color to something that closely matches the perceived color of urlbar. Or perhaps use background-image - linear-gradient() can work well here. But keep the color or image opaque or otherwise you'll face an issue where urlbar text bleeds through */
#statuspanel{ background-color: var(--toolbar-bgcolor) }

#statuspanel{
  color: var(--toolbar-field-color, black);
  z-index: -1;
  max-width: 100% !important;
  padding-top: 0 !important;
}
#statuspanel[type="status"] { color: Highlight }

/* This creates opaque layer to be shown in front of "hidden" real statuspanel */
.browserStack{
  background-color: var(--tabpanel-background-color);
}

/*  OPTIONAL FEATURES  */
/* Uncomment to enable */

/* Center the statuspanel text. This might be useful with centered urlbar text */
/*
#statuspanel-label{ text-align: center }
#urlbar::before{ background-position-x: center !important; }
*/
''