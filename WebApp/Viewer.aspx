﻿<%-- 
  Copyright 2012 Applied Geographics, Inc.

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

      http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
--%>

<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Viewer.aspx.cs" Inherits="Viewer" EnableViewState="false" EnableSessionState="true" EnableEventValidation="false" %>
<%@ Register TagPrefix="uc1" TagName="Footer" Src="Footer.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Header" Src="Header.ascx" %>
<%@ Register TagPrefix="uc1" TagName="SearchPanel" Src="SearchPanel.ascx" %>
<%@ Register TagPrefix="uc1" TagName="SelectionPanel" Src="SelectionPanel.ascx" %>
<%@ Register TagPrefix="uc1" TagName="LegendPanel" Src="LegendPanel.ascx" %>
<%@ Register TagPrefix="uc1" TagName="LocationPanel" Src="LocationPanel.ascx" %>
<%@ Register TagPrefix="uc1" TagName="MarkupPanel" Src="MarkupPanel.ascx" %>

<!DOCTYPE html>

<html>
<head id="head" runat="server">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>AppGeo GPV</title>
  <script type="text/javascript"> if (typeof(JSON) == "undefined") { location.href = "Incompatible.htm"; } </script></head>
<body>
  <div id="pnlBody" class="container-fluid">
    <div id="pnlHeader" class="Panel">
      <span id="cmdMenu" class="CommandLink" title="Show/hide the menu"><span class="glyphicon glyphicon-menu-hamburger" style="font-size: 22px;"></span></span>
      <uc1:Header ID="Header1" runat="server" />
      <a id="cmdHelp" runat="server" class="CommandLink" title="Show the help pages" href="Help.aspx" target="help"><span class="glyphicon glyphicon-question-sign" style="font-size: 22px;"></span></a>
    </div>
    <div id="pnlContent" runat="server" class="Panel">
      <div id="pnlFunctionSizer" runat="server" class="Panel">
        <div id="pnlFunctionTabs" class="TabPanel Panel">
          <span class="FunctionLabel">Map Theme </span>
          <select id="ddlMapTheme" style="margin-top: 12px">
            <asp:PlaceHolder id="plhMapThemes" runat="server"></asp:PlaceHolder>
          </select><br />
            <span id="labLevel" class="FunctionLabel" runat="server" style="display: none">Level </span>
            <select id="ddlLevel" runat="server" class="Input" style="width: 70px; display: none"></select>
          <ul class="TabScroll Menu">
            <li id="tabSearch" runat="server" class="MenuItem Normal" style="display: none">Search</li>
            <li id="tabSelection" runat="server" class="MenuItem Normal" style="display: none">Selection</li>
            <li id="tabLegend" runat="server" class="MenuItem Normal" style="display: none">Legend</li>
            <li id="tabLocation" runat="server" class="MenuItem Normal" style="display: none">Location</li>
            <li id="tabMarkup" runat="server" class="MenuItem Normal" style="display: none">Markup</li>
            <li id="tabShare" runat="server" class="MenuItem Normal">Share</li>
          </ul>
           <div id="pnlAttribution" class="Panel">
            <span id="spnVersion" runat="server" class="VersionText"></span>&nbsp;&nbsp;
            <a class="VersionText" href="http://www.appgeo.com" target="AppGeo">AppGeo</a>
          </div>
        </div>
        <div id="pnlFunction" class="Panel">
          <%-- Fuction tab name with < to click to return to main menu --%>
          <div id="pnlSearch" runat="server" class="FunctionPanel Panel" style="display: none">
            <uc1:SearchPanel ID="ucSearchPanel" runat="server" />
          </div>
          <div id="pnlSelection" runat="server" class="FunctionPanel Panel" style="display: none">
            <uc1:SelectionPanel ID="ucSelectionPanel" runat="server" />
          </div>
          <div id="pnlLegend" runat="server" class="FunctionPanel Panel" style="display: none">
            <uc1:LegendPanel ID="ucLegendPanel" runat="server" />
          </div>
          <div id="pnlLocation" runat="server" class="FunctionPanel Panel" style="display: none">
            <uc1:LocationPanel ID="ucLocationPanel" runat="server" />
          </div>
          <div id="pnlMarkup" runat="server" class="FunctionPanel Panel" style="display: none">
            <uc1:MarkupPanel ID="ucMarkupPanel" runat="server" />
          </div>
          <div id="pnlShare" runat="server" class="FunctionPanel Panel" style="display: none">
            <div class="FunctionHeader"><span class="glyphicon glyphicon-menu-left FunctionExit" aria-hidden="true"></span>Share</div>
            <div id="pnlShareContent" class="Panel">
              <button id="cmdForPrint" class="share-type" title="Printable Map"><i class="fa fa-print"></i> Print</button>
              <button id="cmdForEmail" class="share-type" title="Email This Page"><i class="fa fa-envelope-o"></i> Email</button>
              <button id="cmdForExport" class="share-type" title="Export Map Extent"><i class="fa fa-external-link"></i> Export</button>
              <button id="cmdForDownload" class="share-type" title="Download Map"><i class="fa fa-download"></i> Download</button>
              <div id="pnlPrint" class="share">
                <form id="form1" runat="server">
                  <div class="FunctionLabel">Create Printable PDF Map</div><br />
                  <label for="ddlPrintTemplate">Format</label>
                  <asp:DropDownList id="ddlPrintTemplate" runat="server" Width="216px" AutoPostBack="true" />
		              <button id="cmdCreate" runat="server" Enabled="false" style="left: 139px; top: 48px">Create</button>
                </form>
              </div>
              <div id="pnlEmail" class="share">
                <div class="FunctionLabel">Email a Map</div><br />
                <label for="tboEmail">Email Address</label>
                <input id="tboEmail" />
                <button id="cmdEmail">Send</button>
              </div>
              <div id="pnlExport" class="share">
              <div class="FunctionLabel">Export Map Extent</div><br />
              <select id="ddlExternalMap" runat="server" class="Input" style="width: 200px"></select>
                <button id="cmdExternalMap">Go</button>
              </div>
              <div id="pnlDownload" class="share">
                <div class="FunctionLabel">Download a Map</div><br />
                <label for="ddlSaveMap">Save as</label>
                <select id="ddlSaveMap" runat="server" class="Input" style="width: 90px">
                  <option value="image">as Image</option>
                  <option value="kml">as KML</option>
                </select>
                <button id="cmdSaveMap">Save</button>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div id="pnlMapSizer" runat="server" class="Panel">
        <div id="pnlMap" class="MainPanel Panel">
            <div id="cmdFullView" class="Button" title="Full View"><span class="glyphicon glyphicon-globe"></span></div>
          <div id="pnlMapTools" class="Panel">
            <div id="optPan" runat="server" class="Button MapTool Selected" title="Pan"><span class="glyphicon glyphicon-hand-up"></span></div>
            <div id="optIdentify" runat="server" class="Button MapTool" title="Identify"><span class="glyphicon glyphicon-info-sign"></span></div>
            <div ID="optSelect" runat="server" class="Button MapTool" title="Select Features"></div>
          </div>
          <div id="pnlMarkupTools" class="Panel" >
            <div id="optDrawPoint" runat="server" class="Button MapTool Disabled MarkupTool" title="Draw Point"></div>
            <div id="optDrawLine" runat="server" class="Button MapTool Disabled MarkupTool" title="Draw Line"></div>
            <div id="optDrawPolygon" runat="server" class="Button MapTool Disabled MarkupTool" title="Draw Polygon"></div>
            <div id="optDrawCircle" runat="server" class="Button MapTool Disabled MarkupTool" title="Draw Circle"></div>
            <div id="optDrawCoordinates" runat="server" class="Button MapTool Disabled MarkupTool" title="Draw Coordinates"></div>
            <div id="optDrawLength" runat="server" class="Button MapTool Disabled MarkupTool" title="Draw Measured Length"></div>
            <div id="optDrawArea" runat="server" class="Button MapTool Disabled MarkupTool" title="Draw Measured Area"></div>
            <div id="optDeleteMarkup" runat="server" class="Button MapTool Disabled MarkupTool" title="Delete Markup"></div>
            <div id="optColorPicker" runat="server" class="Button MapTool Disabled MarkupTool" title="Pick Color"></div>
            <div id="optPaintBucket" runat="server" class="Button MapTool Disabled MarkupTool" title="Fill With Color"></div>
            <div id="cmdMarkupColor" class="Button Disabled Color MarkupTool" background-color: #808080" title="Markup Color"></div><br />

            <div id="optDrawText" runat="server" class="Button MapTool Disabled MarkupTool" title="Draw Text"></div>
            <div  class="MarkupTool">Text</div>
            <input type="text" id="tboMarkupText" class="Input MarkupTool" style="width: 169px; cursor: default" disabled="disabled" />
            <input type="checkbox" id="chkTextGlow" class="MarkupTool" />
            <div class="MarkupTool" >Glow</div>
            <div id="cmdTextGlowColor" class="Button Disabled Color MarkupTool" background-color: #808080" title="Text Glow Color"></div>
          </div>
          <div id="mapMain" runat="server" class="Panel">
            <div id="mapTip" style="display: none"></div>
          </div>
        </div>
      </div>
    </div>
    <div id="pnlFooter" class="Panel"><uc1:Footer ID="Footer1" runat="server" /></div>
    <form id="frmSaveMap" method="post" action="Services/MapImage.ashx">
      <input type="hidden" name="m" />
      <input type="hidden" name="state" />
      <input type="hidden" name="width" />
      <input type="hidden" name="height" />
    </form>
    <form id="frmPrint" method="post" action="PrintableMap.aspx" target="print">
      <input type="hidden" name="state" />
      <input type="hidden" name="width" />
    </form>
  </div>
</body>
</html>
