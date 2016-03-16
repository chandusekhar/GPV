/*
  Copyright 2016 Applied Geographics, Inc.

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

      http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.

  GPV50_SQLServer_Upgrade.sql

  Creates the GPV v5.0 configuration tables from an existing set of GPV v4.1 tables.
  Set the prefixes for both sets of table names by changing the values in the "set @prefix41" 
  and "set @prefix50" lines below.  Make sure to run GPV50_SQLServer_AddConstraints.sql 
  using the v5.0 prefix to create the necessary constraints on the v5.0 tables.

*/

declare @prefix41 nvarchar(50)
declare @prefix50 nvarchar(50)

set @prefix41 = 'GPV41'
set @prefix50 = 'GPV50'

declare @sql nvarchar(2000)

/* copy tables */

set @sql = 'SELECT * INTO ' + @prefix50 + 'Application FROM ' + @prefix41 + 'Application'
exec(@sql)

set @sql = 'SELECT * INTO ' + @prefix50 + 'ApplicationMapTab FROM ' + @prefix41 + 'ApplicationMapTab'
exec(@sql)

set @sql = 'SELECT * INTO ' + @prefix50 + 'ApplicationMarkupCategory FROM ' + @prefix41 + 'ApplicationMarkupCategory'
exec(@sql)

set @sql = 'SELECT * INTO ' + @prefix50 + 'ApplicationPrintTemplate FROM ' + @prefix41 + 'ApplicationPrintTemplate'
exec(@sql)

set @sql = 'SELECT * INTO ' + @prefix50 + 'Connection FROM ' + @prefix41 + 'Connection'
exec(@sql)

set @sql = 'SELECT * INTO ' + @prefix50 + 'DataTab FROM ' + @prefix41 + 'DataTab'
exec(@sql)

set @sql = 'SELECT * INTO ' + @prefix50 + 'ExternalMap FROM ' + @prefix41 + 'ExternalMap'
exec(@sql)

/* delete BaseMapID from Layer */

set @sql = 'CREATE TABLE ' + @prefix50 + 'Layer (
  LayerID nvarchar(50) NOT NULL,
  LayerName nvarchar(50) NOT NULL,
  DisplayName nvarchar(50),
  MetaDataURL nvarchar(200),
  KeyField nvarchar(50),
  ZoneField nvarchar(50),
  LevelField nvarchar(50),
  MaxNumberSelected int,
  MaxSelectionArea float,
  MinNearestDistance float,
  MaxNearestDistance float,
  Active smallint DEFAULT 1
)'
exec(@sql)

set @sql = 'INSERT INTO ' + @prefix50 + 'Layer (LayerID, LayerName, DisplayName, MetaDataURL, KeyField, ZoneField, LevelField, MaxNumberSelected, MaxSelectionArea, MinNearestDistance, MaxNearestDistance, Active)
  SELECT LayerID, LayerName, DisplayName, MetaDataURL, KeyField, ZoneField, LevelField, MaxNumberSelected, MaxSelectionArea, MinNearestDistance, MaxNearestDistance, Active
  FROM ' + @prefix41 + 'Layer'
exec(@sql)

/* copy tables */

set @sql = 'SELECT * INTO ' + @prefix50 + 'LayerFunction FROM ' + @prefix41 + 'LayerFunction'
exec(@sql)

set @sql = 'SELECT * INTO ' + @prefix50 + 'LayerProximity FROM ' + @prefix41 + 'LayerProximity'
exec(@sql)

set @sql = 'SELECT * INTO ' + @prefix50 + 'Level FROM ' + @prefix41 + 'Level'
exec(@sql)

set @sql = 'SELECT * INTO ' + @prefix50 + 'MailingLabel FROM ' + @prefix41 + 'MailingLabel'
exec(@sql)

/* delete BaseMapID and ShowBaseMapInLegend from MapTab */

set @sql = 'CREATE TABLE ' + @prefix50 + 'MapTab (
  MapTabID nvarchar(50) NOT NULL,
  DisplayName nvarchar(50) NOT NULL,
  MapHost nvarchar(50) NOT NULL,
  MapService nvarchar(50) NOT NULL,
  DataFrame nvarchar(50),
  UserName nvarchar(50),
  Password nvarchar(50),
  InteractiveLegend smallint,
  Active smallint DEFAULT 1
)'
exec(@sql)

set @sql = 'INSERT INTO ' + @prefix50 + 'MapTab (MapTabID, DisplayName, MapHost, MapService, UserName, Password, DataFrame, InteractiveLegend, Active)
  SELECT MapTabID, DisplayName, MapHost, MapService, UserName, Password, DataFrame, InteractiveLegend, Active
  FROM ' + @prefix41 + 'MapTab'
exec(@sql)

/* copy tables */

set @sql = 'SELECT * INTO ' + @prefix50 + 'MapTabLayer FROM ' + @prefix41 + 'MapTabLayer'
exec(@sql)

/* create MapTabTileGroup table */

set @sql = 'CREATE TABLE ' + @prefix50 + 'MapTabTileGroup (
  MapTabID nvarchar(50) NOT NULL,
  TileGroupID nvarchar(50) NOT NULL,
  CheckInLegend smallint,
  Opacity smallint DEFAULT 1,
  SequenceNo smallint NOT NULL
)'
exec(@sql)

/* copy tables */

set @sql = 'SELECT * INTO ' + @prefix50 + 'Markup FROM ' + @prefix41 + 'Markup'
exec(@sql)

set @sql = 'SELECT * INTO ' + @prefix50 + 'MarkupCategory FROM ' + @prefix41 + 'MarkupCategory'
exec(@sql)

set @sql = 'SELECT * INTO ' + @prefix50 + 'MarkupGroup FROM ' + @prefix41 + 'MarkupGroup'
exec(@sql)

set @sql = 'SELECT * INTO ' + @prefix50 + 'MarkupSequence FROM ' + @prefix41 + 'MarkupSequence'
exec(@sql)

set @sql = 'SELECT * INTO ' + @prefix50 + 'PrintTemplate FROM ' + @prefix41 + 'PrintTemplate'
exec(@sql)

set @sql = 'SELECT * INTO ' + @prefix50 + 'PrintTemplateContent FROM ' + @prefix41 + 'PrintTemplateContent'
exec(@sql)

set @sql = 'SELECT * INTO ' + @prefix50 + 'Proximity FROM ' + @prefix41 + 'Proximity'
exec(@sql)

set @sql = 'SELECT * INTO ' + @prefix50 + 'Query FROM ' + @prefix41 + 'Query'
exec(@sql)

set @sql = 'SELECT * INTO ' + @prefix50 + 'SavedState FROM ' + @prefix41 + 'SavedState'
exec(@sql)

set @sql = 'SELECT * INTO ' + @prefix50 + 'Search FROM ' + @prefix41 + 'Search'
exec(@sql)

set @sql = 'SELECT * INTO ' + @prefix50 + 'SearchInputField FROM ' + @prefix41 + 'SearchInputField'
exec(@sql)

/* create Setting table */

set @sql = 'CREATE TABLE ' + @prefix50 + 'Setting (
  Setting nvarchar(50) NOT NULL,
  Value nvarchar(400),
  Required nvarchar(5) DEFAULT ''no'',
  Note nvarchar(100)
)'
exec(@sql)

/* create TileGroup table */

set @sql = 'CREATE TABLE ' + @prefix50 + 'TileGroup (
  TileGroupID nvarchar(50) NOT NULL,
  DisplayName nvarchar(50) NOT NULL,
  Active smallint DEFAULT 1
)'
exec(@sql)

/* create TileLayer table */

set @sql = 'CREATE TABLE ' + @prefix50 + 'TileLayer (
  TileLayerID nvarchar(50) NOT NULL,
  TileGroupID nvarchar(50) NOT NULL,
  URL nvarchar(400) NOT NULL,
  Attribution nvarchar(400),
  Overlay smallint DEFAULT 1,
  SequenceNo smallint NOT NULL,
  Active smallint DEFAULT 1
)'
exec(@sql)

/* copy tables */

set @sql = 'SELECT * INTO ' + @prefix50 + 'UsageTracking FROM ' + @prefix41 + 'UsageTracking'
exec(@sql)

set @sql = 'SELECT * INTO ' + @prefix50 + 'User FROM ' + @prefix41 + 'User'
exec(@sql)

set @sql = 'SELECT * INTO ' + @prefix50 + 'Zone FROM ' + @prefix41 + 'Zone'
exec(@sql)

set @sql = 'SELECT * INTO ' + @prefix50 + 'ZoneLevel FROM ' + @prefix41 + 'ZoneLevel'
exec(@sql)

set @sql = 'SELECT * INTO ' + @prefix50 + 'ZoneLevelCombo FROM ' + @prefix41 + 'ZoneLevelCombo'
exec(@sql)


/*  GPVSetting content */

set @sql = 'INSERT INTO ' + @prefix50 + 'Setting (Setting, Value, Note) values (''AllowShowApps'', ''no'', ''yes or no'')'; exec(@sql)
set @sql = 'INSERT INTO ' + @prefix50 + 'Setting (Setting, Value, Required, Note) values (''AdminEmail'', null, ''YES'', ''email address'')'; exec(@sql)

set @sql = 'INSERT INTO ' + @prefix50 + 'Setting (Setting, Value, Note) values (''DefaultApplication'', null, ''ApplicationID'')'; exec(@sql)
set @sql = 'INSERT INTO ' + @prefix50 + 'Setting (Setting, Value, Required, Note) values (''FullExtent'', null, ''YES'', ''min X, minY, max X, max Y in MeasureProjection coordinates'')'; exec(@sql)
set @sql = 'INSERT INTO ' + @prefix50 + 'Setting (Setting, Value, Note) values (''ZoomLevels'', ''19'', ''number > 0'')'; exec(@sql)
set @sql = 'INSERT INTO ' + @prefix50 + 'Setting (Setting, Value, Note) values (''ShowScaleBar'', ''no'', ''yes or no'')'; exec(@sql)

set @sql = 'INSERT INTO ' + @prefix50 + 'Setting (Setting, Value, Note) values (''MapProjection'', null, ''Proj4 string, defaults to Web Mercator'')'; exec(@sql)
set @sql = 'INSERT INTO ' + @prefix50 + 'Setting (Setting, Value, Note) values (''MeasureProjection'', null, ''Proj4 string, defaults to MapProjection'')'; exec(@sql)
set @sql = 'INSERT INTO ' + @prefix50 + 'Setting (Setting, Value, Note) values (''MeasureUnits'', ''both'', ''feet, meters or both'')'; exec(@sql)

set @sql = 'INSERT INTO ' + @prefix50 + 'Setting (Setting, Value, Note) values (''ActiveColor'', ''Yellow'', ''HTML color spec'')'; exec(@sql)
set @sql = 'INSERT INTO ' + @prefix50 + 'Setting (Setting, Value, Note) values (''ActiveOpacity'', ''0.5'', ''0.0 = transparent -> 1.0 = opaque'')'; exec(@sql)
set @sql = 'INSERT INTO ' + @prefix50 + 'Setting (Setting, Value, Note) values (''ActivePolygonMode'', ''fill'', ''fill or outline'')'; exec(@sql)
set @sql = 'INSERT INTO ' + @prefix50 + 'Setting (Setting, Value, Note) values (''ActivePenWidth'', ''9'', ''pixels'')'; exec(@sql)
set @sql = 'INSERT INTO ' + @prefix50 + 'Setting (Setting, Value, Note) values (''ActiveDotSize'', ''13'', ''pixels'')'; exec(@sql)

set @sql = 'INSERT INTO ' + @prefix50 + 'Setting (Setting, Value, Note) values (''TargetColor'', ''Orange'', ''HTML color spec'')'; exec(@sql)
set @sql = 'INSERT INTO ' + @prefix50 + 'Setting (Setting, Value, Note) values (''TargetOpacity'', ''0.5'', ''0.0 = transparent -> 1.0 = opaque'')'; exec(@sql)
set @sql = 'INSERT INTO ' + @prefix50 + 'Setting (Setting, Value, Note) values (''TargetPolygonMode'', ''fill'', ''fill or outline'')'; exec(@sql)
set @sql = 'INSERT INTO ' + @prefix50 + 'Setting (Setting, Value, Note) values (''TargetPenWidth'', ''9'', ''pixels'')'; exec(@sql)
set @sql = 'INSERT INTO ' + @prefix50 + 'Setting (Setting, Value, Note) values (''TargetDotSize'', ''13'', ''pixels'')'; exec(@sql)

set @sql = 'INSERT INTO ' + @prefix50 + 'Setting (Setting, Value, Note) values (''SelectionColor'', ''Blue'', ''HTML color spec'')'; exec(@sql)
set @sql = 'INSERT INTO ' + @prefix50 + 'Setting (Setting, Value, Note) values (''SelectionOpacity'', ''0.5'', ''0.0 = transparent -> 1.0 = opaque'')'; exec(@sql)
set @sql = 'INSERT INTO ' + @prefix50 + 'Setting (Setting, Value, Note) values (''SelectionPolygonMode'', ''fill'', ''fill or outline'')'; exec(@sql)
set @sql = 'INSERT INTO ' + @prefix50 + 'Setting (Setting, Value, Note) values (''SelectionPenWidth'', ''9'', ''pixels'')'; exec(@sql)
set @sql = 'INSERT INTO ' + @prefix50 + 'Setting (Setting, Value, Note) values (''SelectionDotSize'', ''13'', ''pixels'')'; exec(@sql)

set @sql = 'INSERT INTO ' + @prefix50 + 'Setting (Setting, Value, Note) values (''FilteredColor'', ''#A0A0A0'', ''HTML color spec'')'; exec(@sql)
set @sql = 'INSERT INTO ' + @prefix50 + 'Setting (Setting, Value, Note) values (''FilteredOpacity'', ''0.5'', ''0.0 = transparent -> 1.0 = opaque'')'; exec(@sql)
set @sql = 'INSERT INTO ' + @prefix50 + 'Setting (Setting, Value, Note) values (''FilteredPolygonMode'', ''fill'', ''fill or outline'')'; exec(@sql)
set @sql = 'INSERT INTO ' + @prefix50 + 'Setting (Setting, Value, Note) values (''FilteredPenWidth'', ''9'', ''pixels'')'; exec(@sql)
set @sql = 'INSERT INTO ' + @prefix50 + 'Setting (Setting, Value, Note) values (''FilteredDotSize'', ''13'', ''pixels'')'; exec(@sql)

set @sql = 'INSERT INTO ' + @prefix50 + 'Setting (Setting, Value, Note) values (''BufferColor'', ''#A0A0FF'', ''HTML color spec'')'; exec(@sql)
set @sql = 'INSERT INTO ' + @prefix50 + 'Setting (Setting, Value, Note) values (''BufferOpacity'', ''0.2'', ''0.0 = transparent -> 1.0 = opaque'')'; exec(@sql)
set @sql = 'INSERT INTO ' + @prefix50 + 'Setting (Setting, Value, Note) values (''BufferOutlineColor'', ''#8080DD'', ''HTML color spec'')'; exec(@sql)
set @sql = 'INSERT INTO ' + @prefix50 + 'Setting (Setting, Value, Note) values (''BufferOutlineOpacity'', ''0'', ''0.0 = transparent -> 1.0 = opaque'')'; exec(@sql)
set @sql = 'INSERT INTO ' + @prefix50 + 'Setting (Setting, Value, Note) values (''BufferOutlinePenWidth'', ''0'', ''pixels'')'; exec(@sql)

set @sql = 'INSERT INTO ' + @prefix50 + 'Setting (Setting, Value, Note) values (''SwatchTileWidth'', ''20'', ''pixels'')'; exec(@sql)
set @sql = 'INSERT INTO ' + @prefix50 + 'Setting (Setting, Value, Note) values (''SwatchTileHeight'', ''20'', ''pixels'')'; exec(@sql)
set @sql = 'INSERT INTO ' + @prefix50 + 'Setting (Setting, Value, Note) values (''LegendExpanded'', ''yes'', ''yes or no'')'; exec(@sql)
set @sql = 'INSERT INTO ' + @prefix50 + 'Setting (Setting, Value, Note) values (''PreserveOnActionChange'', ''selection'', ''target or selection'')'; exec(@sql)
set @sql = 'INSERT INTO ' + @prefix50 + 'Setting (Setting, Value, Note) values (''CustomStyleSheet'', null, ''URL'')'; exec(@sql)
set @sql = 'INSERT INTO ' + @prefix50 + 'Setting (Setting, Value, Note) values (''ExportFormat'', ''xls'', ''csv (comma-separated value) or xls (Excel)'')'; exec(@sql)

set @sql = 'INSERT INTO ' + @prefix50 + 'Setting (Setting, Value, Note) values (''MarkupTimeout'', ''14'', ''days'')'; exec(@sql)
set @sql = 'INSERT INTO ' + @prefix50 + 'Setting (Setting, Value, Note) values (''ServerImageCacheTimeout'', ''60'', ''seconds'')'; exec(@sql)
set @sql = 'INSERT INTO ' + @prefix50 + 'Setting (Setting, Value, Note) values (''BrowserImageCacheTimeout'', ''60'', ''seconds'')'; exec(@sql)
