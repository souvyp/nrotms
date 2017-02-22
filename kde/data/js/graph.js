
// Defines the column user object
function Column(name)
{
	this.name = name;
};

//数据表属性
Column.prototype.type = 'TEXT';
Column.prototype.defaultValue = null;
Column.prototype.primaryKey = false;
Column.prototype.foreignkey = false;
Column.prototype.autoIncrement = false;
Column.prototype.notNull = false;
Column.prototype.unique = false;

//字段属性
Column.prototype.parentcode = '';
Column.prototype.fieldname = '';
Column.prototype.displayname = '';
Column.prototype.level = 1;
Column.prototype.orderno = 0;
Column.prototype.defaultvalue = '';
Column.prototype.fieldsize = 0;
Column.prototype.editmask = '';
Column.prototype.validtype = '';
Column.prototype.displaywidth = 0;
Column.prototype.inherited = '';
Column.prototype.editsize = 0;
Column.prototype.fieldtype = 0;
Column.prototype.edittype = 0;
Column.prototype.linklist = '';
Column.prototype.description = '';

//选项
Column.prototype.visible = false;
Column.prototype.readonly = false;
Column.prototype.fldkeys = false;
Column.prototype.editvisible = false;
Column.prototype.filtered = false;
Column.prototype.required = false;
Column.prototype.locked = false;
Column.prototype.editgrid = false;
Column.prototype.sorted = false;
Column.prototype.perspective = false;
Column.prototype.singleline = false;
Column.prototype.paramfld = false;

Column.prototype.clone = function()
{
	return mxUtils.clone(this);
};

// Defines the table user object
function Table(name)
{
	this.name = name;
	this.code = name;
};

Table.prototype.code = '';
Table.prototype.level = 0;
Table.prototype.orderno = 0;
Table.prototype.key = '';
Table.prototype.fkey = '';
Table.prototype.pageField = '';
Table.prototype.autoTree = '';
Table.prototype.selectSQL = '';
Table.prototype.insertSQL = '';
Table.prototype.updateSQL = '';
Table.prototype.deleteSQL = '';
Table.prototype.connection = '';
Table.prototype.description = '';

var copyOperate=false;
Table.prototype.clone = function()
{
	if(copyOperate){
		var cell=mxUtils.clone(this);
		cell.code+='_copy';
		return cell;
	}
	else
		return mxUtils.clone(this);
};


var editor;

function newGraph(container,sidebar,outline,toolbar)
{
	// Checks if the browser is supported
	if (!mxClient.isBrowserSupported())
	{
		// Displays an error message if the browser is not supported.
		mxUtils.error('Browser is not supported!', 200, false);
	}
	else
	{
		// Specifies shadow opacity, color and offset
		mxConstants.SHADOW_OPACITY = 0.5;
		mxConstants.SHADOWCOLOR = '#C0C0C0';
		mxConstants.SHADOW_OFFSET_X = 5;
		mxConstants.SHADOW_OFFSET_Y = 6;
		
		// Table icon dimensions and position
		mxSwimlane.prototype.imageSize = 20;
		mxSwimlane.prototype.imageDx = 16;
		mxSwimlane.prototype.imageDy = 4;
		
		// Implements white content area for swimlane in SVG
		mxSwimlaneCreateSvg = mxSwimlane.prototype.createSvg;
		mxSwimlane.prototype.createSvg = function()
		{
			var node = mxSwimlaneCreateSvg.apply(this, arguments);
			
			this.content.setAttribute('fill', '#FFFFFF');
			
			return node;
		};
		
		// Implements full-height shadow for SVG
		mxSwimlaneReconfigure = mxSwimlane.prototype.reconfigure;
		mxSwimlane.prototype.reconfigure = function(node)
		{
			mxSwimlaneReconfigure.apply(this, arguments);
			
			if (this.dialect == mxConstants.DIALECT_SVG && this.shadowNode != null)
			{
				this.shadowNode.setAttribute('height', this.bounds.height);
			}
		};
		
		// Implements table icon position and full-height shadow for SVG repaints
		mxSwimlaneRedrawSvg = mxSwimlane.prototype.redrawSvg;
		mxSwimlane.prototype.redrawSvg = function()
		{
			mxSwimlaneRedrawSvg.apply(this, arguments);
			
			// Full-height shadow
			if (this.dialect == mxConstants.DIALECT_SVG && this.shadowNode != null)
			{
				this.shadowNode.setAttribute('height', this.bounds.height);
			}
			
			// Positions table icon
			if (this.imageNode != null)
			{
				this.imageNode.setAttribute('x', this.bounds.x + this.imageDx * this.scale);
				this.imageNode.setAttribute('y', this.bounds.y + this.imageDy * this.scale);
			}
		};

		// Implements table icon position for swimlane in VML
		mxSwimlaneRedrawVml = mxSwimlane.prototype.redrawVml;
		mxSwimlane.prototype.redrawVml = function()
		{
			mxSwimlaneRedrawVml.apply(this, arguments);
			
			// Positions table icon
			if (this.imageNode != null)
			{
				this.imageNode.style.left = Math.floor(this.imageDx * this.scale) + 'px';
				this.imageNode.style.top = Math.floor(this.imageDy * this.scale) + 'px';
			}
		};

		// Replaces the built-in shadow with a custom shadow and adds
		// white content area for swimlane in VML
		mxSwimlaneCreateVml = mxSwimlane.prototype.createVml;
		mxSwimlane.prototype.createVml = function()
		{
			this.isShadow = false;
			var node = mxSwimlaneCreateVml.apply(this, arguments);
			this.shadowNode = document.createElement('v:rect');
			
			// Position and size of shadow are static
			this.shadowNode.style.left = mxConstants.SHADOW_OFFSET_X + 'px';
			this.shadowNode.style.top = mxConstants.SHADOW_OFFSET_Y + 'px';
			this.shadowNode.style.width = '100%'
			this.shadowNode.style.height = '100%'

			// Color for shadow fill
			var fillNode = document.createElement('v:fill');
			this.updateVmlFill(fillNode, mxConstants.SHADOWCOLOR, null, null, mxConstants.SHADOW_OPACITY * 100);
			this.shadowNode.appendChild(fillNode);
			
			// Color and weight of shadow stroke
			this.shadowNode.setAttribute('strokecolor', mxConstants.SHADOWCOLOR);
			this.shadowNode.setAttribute('strokeweight', (this.strokewidth * this.scale) + 'px');
			
			// Opacity of stroke
			var strokeNode = document.createElement('v:stroke');
			strokeNode.setAttribute('opacity', (mxConstants.SHADOW_OPACITY * 100) + '%');
			this.shadowNode.appendChild(strokeNode);
			
			node.insertBefore(this.shadowNode, node.firstChild);

			// White content area of swimlane
			this.content.setAttribute('fillcolor', 'white');
			this.content.setAttribute('filled', 'true');
			
			// Sets opacity on content area fill
			if (this.opacity != null)
			{
				var contentFillNode = document.createElement('v:fill');
				contentFillNode.setAttribute('opacity', this.opacity + '%');
				this.content.appendChild(contentFillNode);
			}
			
			return node;
		};
		
		// Defines an icon for creating new connections in the connection handler.
		// This will automatically disable the highlighting of the source vertex.
		mxConnectionHandler.prototype.connectImage = new mxImage('images/connector.gif', 16, 16);

		// Prefetches all images that appear in colums
		// to avoid problems with the auto-layout
		var keyImage = new Image();
		keyImage.src = "images/key.png";
		
		var fKeyImage = new Image();
		fKeyImage.src = "images/fkey.png";
		
		var plusImage = new Image();
		plusImage.src = "images/plus.png";

		var checkImage = new Image();
		checkImage.src = "images/check.png";
		
		
		
		// Workaround for Internet Explorer ignoring certain CSS directives
		if (mxClient.IS_IE)
		{
			new mxDivResizer(container);
			new mxDivResizer(sidebar);
			new mxDivResizer(outline);
			new mxDivResizer(toolbar);
		}
		
		// Creates the graph inside the given container. The
		// editor is used to create certain functionality for the
		// graph, such as the rubberband selection, but most parts
		// of the UI are custom in this example.
		editor = new mxEditor();
		var graph = editor.graph;
		var model = graph.model;
						
		// Disables some global features
		graph.setConnectable(true);
		graph.setCellsDisconnectable(false);
		graph.setCellsCloneable(false);
		graph.swimlaneNesting = false;
		graph.dropEnabled = true;

		// Does not allow dangling edges
		graph.setAllowDanglingEdges(false);
		
		// Forces use of default edge in mxConnectionHandler
		graph.connectionHandler.factoryMethod = null;

		// Only tables are resizable
		graph.isCellResizable = function(cell)
		{
			return this.isSwimlane(cell);
		};
		
		// Only tables are movable
		graph.isCellMovable = function(cell)
		{
			return this.isSwimlane(cell);
		};

		// Sets the graph container and configures the editor
		editor.setGraphContainer(container);
		/*var config = mxUtils.load(
			'./js/src/resources/keyhandler-minimal.xml').
				getDocumentElement();
		editor.configure(config);*/

		// Enables rubberband selection
		new mxRubberband(graph);
		
		
		// Configures the automatic layout for the table columns
		editor.layoutSwimlanes = true;
		editor.createSwimlaneLayout = function ()
		{
			var layout = new mxStackLayout(this.graph, false);
			layout.fill = true;
			layout.resizeParent = true;
			
			// Overrides the function to always return true
			layout.isVertexMovable = function(cell)
			{
				return true;
			};
			
			return layout;
		};
		
		// Text label changes will go into the name field of the user object
		graph.model.valueForCellChanged = function(cell, value)
		{
			if (value.name != null)
			{
				return mxGraphModel.prototype.valueForCellChanged.apply(this, arguments);
			}
			else
			{
				var old = cell.value.name;
				cell.value.name = value;
				return old;
			}
		};
		
		// Columns are dynamically created HTML labels
		graph.isHtmlLabel = function(cell)
		{
			return !this.model.isEdge(cell);
		};
		
		graph.isColumn = function(cell)
		{
			return !this.isSwimlane(cell) &&!this.model.isEdge(cell) ;
		};
		
		graph.isTable = function(cell){
			return this.isSwimlane(cell)&&!this.model.isEdge(cell) ;	
		}
		
		// Edges are not editable
		graph.isCellEditable = function(cell)
		{
			return false;//!this.model.isEdge(cell);
		};
		
		// Returns the name field of the user object for the label
		graph.convertValueToString = function(cell)
		{
			if (cell.value != null && cell.value.name != null)
			{
				return cell.value.name;
			}

			return mxGraph.prototype.convertValueToString.apply(this, arguments); // "supercall"
		};
		
		// Returns the type as the tooltip for column cells
		graph.getTooltip = function(state)
		{
			if (this.isColumn(state.cell))
			{
				return '字段名称: '+state.cell.value.fieldname+'<br>字段类型: '+state.cell.value.type;
			}
			else if (this.model.isEdge(state.cell))
			{
				
				var source = this.model.getTerminal(state.cell, true);
				var parent = this.model.getParent(source);
				
				return parent.value.name+'.'+source.value.name;
			}
			
			return mxGraph.prototype.getTooltip.apply(this, arguments); // "supercall"
		};
		
		// Creates a dynamic HTML label for column fields
		graph.getLabel = function(cell)
		{
			if (mxUtils.isNode(cell.value))
			{
				return '';
			}
			else if (this.isHtmlLabel(cell))
			{
				var label = '';
				
				if (cell.value.primaryKey)
				{
					label += '<img title="主键" src="images/key.png" width="16" height="16" align="top">&nbsp;';
				}
				else if (cell.value.foreignkey)
				{
					label += '<img title="外键" src="images/fkey.png" width="16" height="16" align="top">&nbsp;';
				}					
				else
				{
					label += '<img src="images/spacer.gif" width="16" height="1">&nbsp;';
				}
					
				if (cell.value.autoIncrement)
				{
					label += '<img title="自动递增" src="images/plus.png" width="16" height="16" align="top">&nbsp;';
				}
				else if (cell.value.unique)
				{
					label += '<img title="唯一键" src="images/check.png" width="16" height="16" align="top">&nbsp;';
				}
				else
				{
					label += '<img src="images/spacer.gif" width="16" height="1">&nbsp;';
				}

				if(this.isColumn(cell))
					return label + cell.value.orderno+' : '+ cell.value.name;
				else
					return cell.value.orderno+' : '+ cell.value.name;
			}
			
			return mxGraph.prototype.getLabel.apply(this, arguments); // "supercall"
		};
		
		// Removes the source vertex if edges are removed
		graph.addListener(mxEvent.REMOVE_CELLS, function(sender, evt)
		{
			var cells = evt.getProperty('cells');
			
			for (var i = 0; i < cells.length; i++)
			{
				var cell = cells[i];
				
				if (this.model.isEdge(cell))
				{
					var terminal = this.model.getTerminal(cell, true);
					var parent = this.model.getParent(terminal);
					this.model.remove(terminal);
				}
			}
		});

		// Disables drag-and-drop into non-swimlanes.
		graph.isValidDropTarget = function(cell, cells, evt)
		{
			return this.isSwimlane(cell);
		};

		// Installs a popupmenu handler using local function (see below).
		graph.panningHandler.factoryMethod = function(menu, cell, evt)
		{
			createPopupMenu(editor, graph, menu, cell, evt);
		};

		// Adds all required styles to the graph (see below)
		configureStylesheet(graph);

		// Adds sidebar icon for the table object
		var tableObject = new Table('TABLENAME');
		var table = new mxCell(tableObject, new mxGeometry(0, 0, 200, 28), 'table');
		
		table.setVertex(true);
		addSidebarIcon(graph, sidebar, 	table, 'images/icons48/table.png');
		
		// Adds sidebar icon for the column object
		var columnObject = new Column('COLUMNNAME');
		var column = new mxCell(columnObject, new mxGeometry(0, 0, 0, 26));
		
		column.setVertex(true);
		column.setConnectable(false);

		addSidebarIcon(graph, sidebar, 	column, 'images/icons48/column.png');
							
		/*var firstColumn = column.clone();
		
		firstColumn.value.name = 'ID';
		firstColumn.value.type = 'INTEGER';
		firstColumn.value.primaryKey = true;
		firstColumn.value.autoIncrement = true;
		
		table.insert(firstColumn);*/
		
		// Adds child columns for new connections between tables
		graph.addEdge = function(edge, parent, source, target, index)
		{
			// Finds the primary key child of the target table
			var primaryKey = null;
			var childCount = this.model.getChildCount(target);

			for (var i=0; i < childCount; i++)
			{
				var child = this.model.getChildAt(target, i);
				
				if (child.value.primaryKey)
				{
					primaryKey = child;
					break;
				}
			}
			
			if (primaryKey == null)
			{
				mxUtils.alert('目标必须有一个主键');
				return null;
			}
			
			var foreignkey=null;
			childCount = this.model.getChildCount(source);
			
			for (var i=0; i < childCount; i++)
			{
				var child = this.model.getChildAt(source, i);
				
				if (child.value.foreignkey)
				{
					foreignkey = child;
					break;
				}
			}
			
			if (foreignkey == null)
			{
				mxUtils.alert('源必须有一个外键');
				return null;
			}
		
			this.model.beginUpdate();
			try
			{
				source = foreignkey;
				target = primaryKey;
				return mxGraph.prototype.addEdge.apply(this, arguments); // "supercall"
			}
			finally
			{
				this.model.endUpdate();
			}
			
			return null;
		};
		
		var spacer = document.createElement('div');
		spacer.className="spacer";
		spacer.innerHTML="&nbsp;";
				
		addToolbarButton(editor, toolbar, 'properties', '属性', './images/properties.gif');
		// Defines a new export action
		editor.addAction('properties', function(editor, cell)
		{
			if (cell == null)
				cell = graph.getSelectionCell();
			if (cell != null){
				if (graph.isColumn(cell))
					showProperties(graph, null,cell,false,false);
				else
					showProperties(graph, null,cell,true,false);
			}
		});

		addToolbarButton(editor, toolbar, 'delete', '删除', 'images/delete2.png');
		
		addSpacer(toolbar,spacer.cloneNode(true));
		
		addToolbarButton(editor, toolbar, 'undo', '撤销', 'images/undo.png');
		addToolbarButton(editor, toolbar, 'redo', '重做', 'images/redo.png');
		
		addSpacer(toolbar,spacer.cloneNode(true));
		
		addToolbarButton(editor, toolbar, 'show', '预览', 'images/camera.png');
		addToolbarButton(editor, toolbar, 'print', '打印', 'images/printer.png');
		
		/*addSpacer(toolbar,spacer.cloneNode(true));
		
		addToolbarButton(editor, toolbar, 'export', '保存', 'images/export1.png');
		*/
		addToolbarButton(editor, toolbar, 'collapseAll', '收起', 'images/navigate_minus.png', true);
		addToolbarButton(editor, toolbar, 'expandAll', '展开', 'images/navigate_plus.png', true);

		addSpacer(toolbar,spacer.cloneNode(true));

		addToolbarButton(editor, toolbar, 'zoomIn', '放大', 'images/zoom_in.png', true);
		addToolbarButton(editor, toolbar, 'zoomOut', '缩小', 'images/zoom_out.png', true);
		addToolbarButton(editor, toolbar, 'actualSize', '实际', 'images/view_1_1.png', true);
		addToolbarButton(editor, toolbar, 'fit', '自适应', 'images/fit_to_size.png', true);
		
						
		// Defines a reload action
		editor.addAction('reload', function(editor, cell)
		{
			loadFromFile();
		});
		// Defines a create SQK action
		editor.addAction('showSql', function(editor, cell)
		{
			var sql = createSql(graph);
			
			if (sql.length > 0)
			{
				var textarea = document.createElement('textarea');
				textarea.style.width = '400px';
				textarea.style.height = '400px';
				
				textarea.value = sql;
				showModalWindow('SQL', textarea, 410, 440);
			}
			else
			{
				mxUtils.alert('Schema is empty');
			}
		});

		editor.addAction('autoFields', function(editor, cell)
		{
			var sql = cell.value.selectSQL;
			var conn = cell.value.connection;
			if (sql.length > 0)
			{
				var nModel=graph.getModel();
				var nCell=cell;
				var nColumn = column;
				var nGraph = graph;
				function findCell(name){
					if(nCell.children)
						for(var j=0;j<nCell.children.length;j++){
							if(nCell.children[j].value.fieldname==name)
								return true;
						}
					return false;
				}
				
				onlineContent(MISC_URL,{param:'sql',sql:sql,conn:conn},"json",function(datas){
					nModel.beginUpdate();
					try{
						var data=datas.data;
						for(var i=0;i<data.length;i++){
							if(!findCell(data[i].fieldname)){
								var nn = nColumn.clone();	
								nn.value.parentcode=nCell.value.code;
								nn.value.orderno = i+1;
								nn.value.name = data[i].fieldname;
								nn.value.fieldname = nn.value.name;
								nn.value.displayname = nn.value.name;
								nn.value.type =data[i].datatype;
								nn.value.fieldtype = data[i].fieldtype;
								nn.value.displaywidth=data[i].displaywidth;
								nn.value.fieldsize=data[i].fieldsize;
								nn.value.editsize=data[i].fieldsize;
								nGraph.addCell(nn, nCell);	
							}
						}							
					}
					finally
					{
						nModel.endUpdate();
					}
				});
			}
			else
			{
				mxUtils.alert('没有设置查询语句！');
			}
		});
		// Defines a new export action
		editor.addAction('createGears', function(editor, cell)
		{
			var sql = createSql(graph);
			
			if (sql.length > 0)
			{
				loadGoogleGears();

				try
				{					
					var db = google.gears.factory.create('beta.database', '1.0');
					var name = mxUtils.prompt('Enter name of new database', 'MyDatabase');
					
					if (name != null)
					{						
						db.open(name);

						// Checks if database is empty
						var rs = db.execute('SELECT * FROM sqlite_master');
						
						if (rs.isValidRow())
						{
							if (mxUtils.confirm(name+' exists. Do you want to continue? This will replace existing tables.') == 0)
							{
								return;
							}
						}

						try
						{
							db.execute(sql);
							mxUtils.alert(name+' successfully created');
						}
						catch (e)
						{
							mxUtils.alert('SQL Error: '+e.message);
						}
					}
				}
				catch (e)
				{
					mxUtils.alert('Google Gears is not available: '+e.message);
				}
			}
			else
			{
				mxUtils.alert('Schema is empty');
			}
		});
		
	
		// Defines export XML action
		editor.addAction('export', function(editor, cell)
		{
			var textarea = document.createElement('textarea');
			textarea.style.width = '400px';
			textarea.style.height = '400px';
			var enc = new mxCodec(mxUtils.createXmlDocument());
			var node = enc.encode(editor.graph.getModel());
			textarea.value = mxUtils.getPrettyXml(node);
			showModalWindow('XML', textarea, 410, 440);
			
			/*var enc = new mxCodec(mxUtils.createXmlDocument());
			var node = enc.encode(editor.graph.getModel());
			var xml = mxUtils.getPrettyXml(node);
			onlineContent('app.cn',{"param":"post","xml":xml,"file":curNodeId},'json',function(data){
				if(data.success)alert('保存成功!');
				else alert('保存失败');
			});*/
		});
				
		// Creates the outline (navigator, overview) for moving
		// around the graph in the top, right corner of the window.
		var outln = new mxOutline(graph, outline);
		
	}
}


function configureStylesheet(graph)
{
	var style = new Object();
	style[mxConstants.STYLE_SHAPE] = mxConstants.SHAPE_RECTANGLE;
	style[mxConstants.STYLE_PERIMETER] = mxPerimeter.RectanglePerimeter;
	style[mxConstants.STYLE_ALIGN] = mxConstants.ALIGN_LEFT;
	style[mxConstants.STYLE_VERTICAL_ALIGN] = mxConstants.ALIGN_MIDDLE;
	style[mxConstants.STYLE_FONTCOLOR] = '#000000';
	style[mxConstants.STYLE_FONTSIZE] = '11';
	style[mxConstants.STYLE_FONTSTYLE] = 0;
	style[mxConstants.STYLE_SPACING_LEFT] = '4';
	style[mxConstants.STYLE_IMAGE_WIDTH] = '48';
	style[mxConstants.STYLE_IMAGE_HEIGHT] = '48';

	graph.getStylesheet().putDefaultVertexStyle(style);

	style = new Object();
	style[mxConstants.STYLE_SHAPE] = mxConstants.SHAPE_SWIMLANE;
	style[mxConstants.STYLE_PERIMETER] = mxPerimeter.RectanglePerimeter;
	style[mxConstants.STYLE_ALIGN] = mxConstants.ALIGN_CENTER;
	style[mxConstants.STYLE_VERTICAL_ALIGN] = mxConstants.ALIGN_TOP;
	style[mxConstants.STYLE_GRADIENTCOLOR] = '#41B9F5';
	style[mxConstants.STYLE_FILLCOLOR] = '#8CCDF5';
	style[mxConstants.STYLE_STROKECOLOR] = '#1B78C8';
	style[mxConstants.STYLE_FONTCOLOR] = '#000000';
	style[mxConstants.STYLE_STROKEWIDTH] = '2';
	style[mxConstants.STYLE_STARTSIZE] = '28';
	style[mxConstants.STYLE_VERTICAL_ALIGN] = 'middle';
	style[mxConstants.STYLE_FONTSIZE] = '12';
	style[mxConstants.STYLE_FONTSTYLE] = 1;
	style[mxConstants.STYLE_IMAGE] = 'images/icons48/table.png';
	// Looks better without opacity if shadow is enabled
	//style[mxConstants.STYLE_OPACITY] = '80';
	style[mxConstants.STYLE_SHADOW] = 1;
	graph.getStylesheet().putCellStyle('table', style);

	style = graph.stylesheet.getDefaultEdgeStyle();
	style[mxConstants.STYLE_LABEL_BACKGROUNDCOLOR] = '#FFFFFF';
	style[mxConstants.STYLE_STROKEWIDTH] = '2';
	style[mxConstants.STYLE_ROUNDED] = true;
	style[mxConstants.STYLE_EDGE] = mxEdgeStyle.EntityRelation;
};

function addSidebarIcon(graph, sidebar, prototype, image)
{
	// Function that is executed when the image is dropped on
	// the graph. The cell argument points to the cell under
	// the mousepointer if there is one.
	var funct = function(graph, evt, cell)
	{
		graph.stopEditing(false);

		var pt = graph.getPointForEvent(evt);
		
		var parent = graph.getDefaultParent();
		var model = graph.getModel();		
		var isTable = graph.isSwimlane(prototype);		
		
		if (!isTable)
		{
			var offset = mxUtils.getOffset(graph.container);

			parent = graph.getSwimlaneAt(evt.clientX-offset.x, evt.clientY-offset.y);
			var pstate = graph.getView().getState(parent);
			
			if (parent == null ||
				pstate == null)
			{
				mxUtils.alert('拖动目标必须是数据集');
				return;
			}
			
			pt.x -= pstate.x;
			pt.y -= pstate.y;
		}

		var v1 = model.cloneCell(prototype);
		v1.geometry.x = pt.x;
		v1.geometry.y = pt.y;
		showProperties(graph,parent,v1,isTable,true);
	}
	
	// Creates the image which is used as the sidebar icon (drag source)
	var img = document.createElement('img');
	img.setAttribute('src', image);
	img.style.width = '48px';
	img.style.height = '48px';
	img.title = '拖动到绘图区创建一个新对象';
	sidebar.appendChild(img);
						
	// Creates the image which is used as the drag icon (preview)
	var dragImage = img.cloneNode(true);
	var ds = mxUtils.makeDraggable(img, graph, funct, dragImage);

	// Adds highlight of target tables for columns
	ds.highlightDropTargets = true;
	ds.getDropTarget = function(graph, x, y)
	{
		if (graph.isSwimlane(prototype))
		{
			return null;
		}
		else
		{
			var cell = graph.getCellAt(x, y);
			
			if (graph.isSwimlane(cell))
			{
				return cell;
			}
			else
			{
				var parent = graph.getModel().getParent(cell);
				
				if (graph.isSwimlane(parent))
				{
					return parent;
				}
			}
		}
	};
};


function showModalWindow(title, content, width, height,okF,DeleteF)
{	
	var win;
	if(typeof(content)=="string")
		win=document.getElementById(content);
	else{
		win=document.createElement('div');
		$(win).html(content);
	}
	$(win).show();
	var buttons=[];
	if(DeleteF!=null){
		buttons.push({
			text:'删除',
			disabled:DeleteF==null,
			iconCls:'icon-delete',
			handler:function(){
				DeleteF();
				if(typeof(content)=="string")
					$(win).dialog('close');
				else
					$(win).dialog('destroy');
			}
		})
	}
	buttons.push({
			text:'确定',
			iconCls:'icon-ok',
			handler:function(){
				if(typeof(content)=="string"){
					
					if(!$('#form'+content).form('validate')){
						alert('内容没有填写完整!');
						return;
					};			
				}
				if(okF&&okF()){
					if(typeof(content)=="string")
						$(win).dialog('close');
					else
						$(win).dialog('destroy');
				}
			}
		},{
			text:'取消',
			iconCls:'icon-cancel',
			handler:function(){
				if(typeof(content)=="string")
					$(win).dialog('close');
				else
					$(win).dialog('destroy');
			}
		});
	$(win).dialog({
		width: width,
		height: height,
		collapsible:true,
		//minimizable:true,
		//maximizable:true,
		//resizable:true,
		title:title,
		modal:true,
		buttons:buttons
	});
	$(win).dialog('open');
};
// Function to create the entries in the popupmenu
function createPopupMenu(editor, graph, menu, cell, evt)
{
	if (cell != null)
	{		
		menu.addItem('属性', './images/properties.gif', function()
		{
			editor.execute('properties', cell);
		});
	
		menu.addSeparator();
		menu.addItem('置前', '', function()
		{
			editor.execute('toFront', cell);
		});
		menu.addItem('置后', '', function()
		{
			editor.execute('toBack', cell);
		});
		menu.addSeparator();
		menu.addItem('删除', 'images/delete2.png', function()
		{
			editor.execute('delete', cell);
		});
		
		

	}	
	if (cell!=null&&graph.isTable(cell)){
		menu.addItem('剪切', './images/cut.png', function()
		{
			editor.execute('cut');
		});
		menu.addItem('拷贝', './images/copy.png', function()
		{
			copyOperate=true;
			editor.execute('copy');
			copyOperate=false;
		});	
		menu.addSeparator();

		menu.addItem('新增操作', 'images/export1.png', function()
		{
			showOperation(graph,cell,-1);
		});		
	}
	
	if(cell==null)
		menu.addItem('粘贴', './images/paste.png', function()
		{
			editor.execute('paste');
		});	
		
	/*menu.addItem('撤销', 'images/undo.png', function()
	{
		editor.execute('undo', cell);
	});
	
	menu.addItem('重做', 'images/redo.png', function()
	{
		editor.execute('redo', cell);
	});
	
	menu.addSeparator();
	
	menu.addItem('重新加载', 'images/export1.png', function()
	{
		editor.execute('reload', cell);
	});	
	
	menu.addItem('Show SQL', 'images/export1.png', function()
	{
		test(editor,cell);
		
		editor.execute('showSql', cell);

	});	*/
	
	if (cell!=null&&graph.isTable(cell)){
		menu.addSeparator();
		
		menu.addItem('自动生成字段', './images/auto.png', function()
		{
			editor.execute('autoFields', cell);
		});
		
		menu.addItem('显示XML', './images/table.png', function()
		{
			//$('windows').open('demo/datagrid.html');
			editor.execute('export');
		});
	}
};

function checkTableCode(graph,cell,code){
	var parent = graph.getDefaultParent();	
	var model=graph.model;
	var childCount = model.getChildCount(parent);
	for (var i=0; i < childCount; i++){
		var child = model.getChildAt(parent, i);
		if(graph.isTable(child)){
			if(child!=cell&&child.value){
				if(child.value.code==code)
					return false;
			}
		}
	}
	return true;
}

function checkFieldName(graph,parent,cell,fieldname){
	var model=graph.model;
	var childCount = model.getChildCount(parent);
	for (var i=0; i < childCount; i++){
		var child = model.getChildAt(parent, i);
		if(graph.isColumn(child)){
			if(child!=cell&&child.value){
				if(child.value.fieldname==fieldname)
					return false;
			}
		}
	}
	return true;
}

function putPropertys(graph,parent,cell,isTable,isNew){
	
	if(!parent&&graph.isTable(cell.parent))parent=cell.parent;
	
	if (isTable){
		if(!checkTableCode(graph,cell,$(":input[name='fcode']").val())){
			alert('数据集编码<'+$(":input[name='fcode']").val()+'>已经存在!');
			return false;
		}
	}else{ 
		if(!checkFieldName(graph,parent,cell,$(":input[name='dfieldname']").val())){
			alert('字段名称<'+$(":input[name='dfieldname']").val()+'>已经存在!');
			return false;
		}
	}
	var model = graph.getModel();
	model.beginUpdate();
	try
	{	
		var clone = cell.value;
		if(!isNew){
			clone = cell.value.clone();
		}
		
		if (isTable)
		{
			var oldCode=clone.code;
			clone.code = $(":input[name='fcode']").val();
			clone.name = $(":input[name='fname']").val();
			clone.level = $(":input[name='flevel']").val();
			clone.orderno = $(":input[name='forderno']").val();
			/*clone.key = $(":input[name='fkeytab']").val();
			clone.fkey = $(":input[name='fkey']").val();*/
			clone.pageField = $(":input[name='fpagefield']").val();
			clone.autoTree = $(":input[name='fautotree']").val();
			clone.selectSQL = $(":input[name='fSelectSQL']").val();
			clone.insertSQL = $(":input[name='fInsertSQL']").val();
			clone.updateSQL = $(":input[name='fUpdateSQL']").val();
			clone.deleteSQL = $(":input[name='fDeleteSQL']").val();	
			clone.connection = $(":input[name='fConnection']").val();
			clone.description = $(":input[name='fDescription']").val();	
			
			var childCount = model.getChildCount(cell);
			
			for (var i=0; i < childCount; i++){
				var child = model.getChildAt(cell, i);
				child.value.parentcode=clone.code;
			}
						
			var g=graph.getDefaultParent();
			childCount = model.getChildCount(g);
			for (var i=0; i < childCount; i++)
			{
				var child = model.getChildAt(g, i);
				if (mxUtils.isNode(child.value)){
					if(child.value.nodeName.toLowerCase()=='opimg'){
						if(child.value.getAttribute('parentcode')==oldCode){
							child.setAttribute('parentcode',clone.code);
						}
					}
				}
			}			
		}
		else{
			clone.fieldname=$(":input[name='dfieldname']").val();
			clone.displayname=$(":input[name='ddisplayname']").val();
			clone.level=$(":input[name='dlevel']").val();
			clone.orderno=$(":input[name='dorderno']").val();
			clone.defaultvalue=$(":input[name='ddefaultvalue']").val();
			clone.fieldsize=$(":input[name='dfieldsize']").val();
			clone.editmask=$(":input[name='deditmask']").val();
			clone.validtype=$(":input[name='dvalidtype']").val();
			clone.displaywidth=$(":input[name='ddisplaywidth']").val();
			clone.inherited=$(":input[name='dinherited']").val();
			clone.editsize=$(":input[name='deditsize']").val();		
			clone.fieldtype=$(":input[name='dfieldtype']").val();
			clone.edittype=$(":input[name='dedittype']").val();		
			clone.linklist=$(":input[name='dlinklist']").val();
			clone.description=$(":input[name='ddescription']").val();		
			clone.visible=$(":input[name='dvisible']")[0].checked;
			clone.readonly=$(":input[name='dreadonly']")[0].checked;
			clone.fldkeys=$(":input[name='dkeys']")[0].checked;
			clone.editvisible=$(":input[name='deditvisible']")[0].checked;	
			clone.filtered=$(":input[name='dfiltered']")[0].checked;
			clone.required=$(":input[name='drequired']")[0].checked;
			clone.locked=$(":input[name='dlocked']")[0].checked;
			clone.foreignkey=$(":input[name='dforeignkey']")[0].checked;
			clone.editgrid=$(":input[name='deditgrid']")[0].checked;
			clone.sorted=$(":input[name='dsorted']")[0].checked;
			clone.perspective=$(":input[name='dperspective']")[0].checked;
			clone.singleline=$(":input[name='dsingleline']")[0].checked;
			clone.paramfld=$(":input[name='dparamfld']")[0].checked;
			clone.name=clone.displayname;
			clone.type=$(":input[name='dfieldtype']").find("option:selected").text();
			clone.primaryKey=clone.fldkeys;
			clone.autoIncrement=clone.fieldtype==7;
			clone.unique=clone.fieldtype==6;
			if (isNew){
				clone.parentcode=parent.value.code;
			}
		}
		model.setValue(cell, clone);
		if(isNew){
			graph.addCell(cell, parent);	
			if (isTable){			
				cell.geometry.alternateBounds = new mxRectangle(0, 0, cell.geometry.width, cell.geometry.height);
			}
		}
	}
	finally
	{
		model.endUpdate();
	}
	
	graph.setSelectionCell(cell);
	return true;
}

function showProperties(graph, parent,cell,isTable,isNew)
{
	var DeleteF;
	if(!isNew)DeleteF=function(){
		editor.execute('delete', cell);
	}
	if(isTable){
		$(":input[name='fcode']").val(cell.value.code);
		$(":input[name='fname']").val(cell.value.name);
		$("#flevel").numberbox('setValue', cell.value.level);
		$("#forderno").numberbox('setValue', cell.value.orderno);
		$(":input[name='fpagefield']").val(cell.value.pageField);
		$(":input[name='fautotree']").val(cell.value.autoTree);
		$(":input[name='fSelectSQL']").val(cell.value.selectSQL);
		$(":input[name='fInsertSQL']").val(cell.value.insertSQL);
		$(":input[name='fUpdateSQL']").val(cell.value.updateSQL);
		$(":input[name='fDeleteSQL']").val(cell.value.deleteSQL);	
		$(":input[name='fConnection']").val(cell.value.connection);
		$(":input[name='fDescription']").val(cell.value.description);					
		showModalWindow("数据集",'Dataset',450,500,function(){return putPropertys(graph,parent,cell,isTable,isNew)},DeleteF);
	}
	else{
		$(":input[name='dfieldname']").val(cell.value.fieldname);
		$(":input[name='ddisplayname']").val(cell.value.displayname);
		$("#dlevel").numberbox('setValue', cell.value.level);
		$("#dorderno").numberbox('setValue', cell.value.orderno);
		$("#dfieldsize").numberbox('setValue', cell.value.fieldsize);
		$("#ddisplaywidth").numberbox('setValue', cell.value.displaywidth);
		$("#deditsize").numberbox('setValue', cell.value.editsize);
		
		$(":input[name='ddefaultvalue']").val(cell.value.defaultvalue);
		$(":input[name='deditmask']").val(cell.value.editmask);
		$(":input[name='dvalidtype']").val(cell.value.validtype);
		$(":input[name='dinherited']").val(cell.value.inherited);
		$(":input[name='dfieldtype']").val(cell.value.fieldtype);
		$(":input[name='dedittype']").val(cell.value.edittype);		
		$(":input[name='dlinklist']").val(cell.value.linklist);
		$(":input[name='ddescription']").val(cell.value.description);		
		$(":input[name='dvisible']").attr("checked",cell.value.visible);
		$(":input[name='dreadonly']").attr("checked",cell.value.readonly);	
		$(":input[name='dkeys']").attr("checked",cell.value.fldkeys);
		$(":input[name='deditvisible']").attr("checked",cell.value.editvisible);	
		$(":input[name='dfiltered']").attr("checked",cell.value.filtered);
		$(":input[name='drequired']").attr("checked",cell.value.required);	
		$(":input[name='dlocked']").attr("checked",cell.value.locked);
		$(":input[name='dforeignkey']").attr("checked",cell.value.foreignkey);
		$(":input[name='deditgrid']").attr("checked",cell.value.editgrid);	
		$(":input[name='dsorted']").attr("checked",cell.value.sorted);	
		$(":input[name='dperspective']").attr("checked",cell.value.perspective);
		$(":input[name='dparamfld']").attr("checked",cell.value.paramfld);
		$(":input[name='dsingleline']").attr("checked",cell.value.singleline);			
		showModalWindow("字段",'Field',450,520,function(){return putPropertys(graph,parent,cell,isTable,isNew)},DeleteF);	
	}
};

var operationImg=[];


function checkOperation(graph,cell,cellImg,code){
	var parent = graph.getDefaultParent();
	var model=graph.model;	
	var childCount = model.getChildCount(parent);
	for (var i=0; i < childCount; i++)
	{
		var child = model.getChildAt(parent, i);
		if (mxUtils.isNode(child.value)){
			if(child.value.nodeName.toLowerCase()=='opimg'){
				if(child.value.getAttribute('parentcode')==cell.value.code){
					if(child!=cellImg&&child.value.getAttribute('code')==code)
						return false;
				}
			}
		}
	}
	return true;
}


function showOperation(graph,cell,inx){				
	var DeleteF;
	var opImg;
	var cellImg;
	if(inx>=0){
		opImg=operationImg[inx].opimg;	
		cellImg=operationImg[inx].v;		
		$(":input[name='ocode']").val(opImg.getAttribute('code'));
		$(":input[name='oname']").val(opImg.getAttribute('name'));		
		$("#olevel").numberbox('setValue', opImg.getAttribute('level'));
		$("#oorderno").numberbox('setValue', opImg.getAttribute('orderno'));
		//$(":input[name='oimg']").val(opImg.getAttribute('img'));
		$(":input[name='ocssIcon']").val(opImg.getAttribute('cssIcon'));
		//$('#ocssIcon').searchbox('setValue',opImg.getAttribute('cssIcon'));
		
		$("#oimg").attr('src',opImg.getAttribute('img'));
		$(":input[name='oshorkey']").val(opImg.getAttribute('shorkey'));
		$(":input[name='ooperatetype']").val(opImg.getAttribute('operatetype'));
		$(":input[name='onote']").val(opImg.getAttribute('note'));
		$(":input[name='oinit']").val(opImg.getAttribute('init'));
		$(":input[name='odescription']").val(opImg.getAttribute('description'));
		DeleteF=function(){
			graph.removeCells([operationImg[inx].v]);
			operationImg.RemoveIndex(inx);
			graph.refresh();
		}
	}
	else 
		$("#formOperation")[0].reset();
	showModalWindow("操作",'Operation',460,480,function(){
		if(!checkOperation(graph,cell,cellImg,$(":input[name='ocode']").val())){
			alert('操作编码<'+$(":input[name='ocode']").val()+'>已经存在!');
			return false;
		}
		
		if(inx<0){
			var doc = mxUtils.createXmlDocument();
			opImg = doc.createElement('opImg');
		}else{
			opImg = operationImg[inx].opimg;
		}
		opImg.setAttribute('parentcode',cell.value.code);
		opImg.setAttribute('code',$(":input[name='ocode']").val());
		opImg.setAttribute('level',$("#olevel").val());
		opImg.setAttribute('orderno',$("#oorderno").val());
		opImg.setAttribute('name',$(":input[name='oname']").val());
		opImg.setAttribute('img',$("#oimg").attr("src"));
		opImg.setAttribute('cssIcon',$(":input[name='ocssIcon']").val());
		//var imgcss=$('#ocssIcon').searchbox('getValue');
		//opImg.setAttribute('cssIcon',imgcss);
		
		//opImg.setAttribute('cssIcon',$(":input[name='ocssIcon']").val());
		opImg.setAttribute('shorkey',$(":input[name='oshorkey']").val());
		opImg.setAttribute('operatetype',$(":input[name='ooperatetype']").val());
		opImg.setAttribute('note',$(":input[name='onote']").val());
		opImg.setAttribute('init',$(":input[name='oinit']").val());
		opImg.setAttribute('description',$(":input[name='odescription']").val());
		
		if(inx<0){
			var img=new mxImage($("#oimg").attr("src"), 16, 16);
			
			img.opimg=opImg;
			img.code=cell.value.code;
			img.v=graph.insertVertex(graph.getDefaultParent(), null, opImg, 0, 0, 0, 0);
			operationImg.push(img);	
		}
		else{
			var img=operationImg[inx];
			img.src=$("#oimg").attr("src");
		}
			
		graph.refresh();
		editor.execute('selectNone');
		return true;
	},DeleteF);
}

function createSql(graph)
{
	var sql = [];
	var parent = graph.getDefaultParent();
	var childCount = graph.model.getChildCount(parent);

	for (var i=0; i<childCount; i++)
	{
		var child = graph.model.getChildAt(parent, i);
		
		if (!graph.model.isEdge(child))
		{
			sql.push('CREATE TABLE IF NOT EXISTS '+child.value.name+' (');
			
			var columnCount = graph.model.getChildCount(child);

			if (columnCount > 0)
			{
				for (var j=0; j<columnCount; j++)
				{
					var column = graph.model.getChildAt(child, j).value;
					
					sql.push('\n    '+column.name+' '+column.type);
					
					if (column.notNull)
					{
						sql.push(' NOT NULL');
					}
											
					if (column.primaryKey)
					{
						sql.push(' PRIMARY KEY');
					}
					
					if (column.autoIncrement)
					{
						sql.push(' AUTOINCREMENT');
					}
					
					if (column.unique)
					{
						sql.push(' UNIQUE');
					}

					if (column.defaultValue != null)
					{
						sql.push(' DEFAULT '+column.defaultValue);
					}
					
					sql.push(',');
				}
				
				sql.splice(sql.length-1, 1);
				sql.push('\n);');
			}
			
			sql.push('\n');
		}
	}

	return sql.join('');
};

function addSpacer(toolbar,button){
	toolbar.insertBefore(button,document.getElementById("viewMenu"));
}

function addToolbarButton(editor, toolbar, action, label, image, isTransparent)
{
	if(isTransparent){
		$("#mmView :contains('"+label+"')").click(function(){
			editor.execute(action);
		});
	}
	else
	{
		var button	= document.createElement('a');
		button.className="easyui-linkbutton l-btn l-btn-plain";
		button.href="javascript:void();";
		button.innerHTML='<span class="l-btn-left"><span class="l-btn-text" style="padding-left:20px;background:url(\''+image+'\') no-repeat;">'+label+'</span></span>';
		toolbar.insertBefore(button,document.getElementById("viewMenu"));
		mxEvent.addListener(button, 'click', function(evt)
		{
			editor.execute(action);
		});
	}
};

function loadFromFile()
{
	var node = $('.easyui-tree').tree('getSelected');
	var xml=node.attributes.graph;
	if(xml=="")
		xml='<mxGraphModel><root><mxCell id="0"/><mxCell id="1" parent="0"/></root></mxGraphModel>';
	var xmlDocument = mxUtils.parseXml(xml);
	if(xmlDocument.documentElement != null && xmlDocument.documentElement.nodeName == 'mxGraphModel'){
		/*for(var i=0;i<operationImg.length;i++)
		{
			operationImg[i].destroy();
		}*/
		operationImg=[];
		
		var decoder = new mxCodec(xmlDocument);
		var node = xmlDocument.documentElement;	
		var graph = editor.graph;
		var model=graph.getModel();
		decoder.decode(node, model);	
		var parent = graph.getDefaultParent();	
		var childCount = model.getChildCount(parent);
		for (var i=0; i < childCount; i++)
		{
			var child = model.getChildAt(parent, i);
			if (mxUtils.isNode(child.value)){
				if(child.value.nodeName.toLowerCase()=='opimg'){
					var img=new mxImage(child.value.getAttribute('img'), 16, 16);					
					img.title=child.value.getAttribute('name');
					img.opimg=child.value;
					img.code=child.value.getAttribute('parentcode');
					img.v=child;
					operationImg.push(img);	
				}
			}
		}
		graph.refresh();
	}
};

// Overridden to add an additional control to the state at creation time
mxCellRendererCreateControl = mxCellRenderer.prototype.createControl;
mxCellRenderer.prototype.createControl = function(state)
{
	mxCellRendererCreateControl.apply(this, arguments);
	
	var graph = state.view.graph;
	if (graph.getModel().isVertex(state.cell)&&graph.isColumn&&!graph.isColumn(state.cell))
	{
		if (state.Controls == null&&operationImg.length>0)
		{
			state.Controls=[];
			for(var i=0;i<operationImg.length;i++){
				if(state.cell.value.code==operationImg[i].code&&operationImg[i].hide!=="1")	{	
					
					var b = new mxRectangle(0, 0, operationImg[i].width, operationImg[i].height);
					var con=new mxImageShape(b, operationImg[i].src,null,i);
					con.dialect = graph.dialect;
					con.preserveImageAspect = false;
					state.Controls.push(con);
					this.initControl(state, con, false, function (evt)
					{
						if (graph.isEnabled())
						{
							showOperation(graph,state.cell,$(this).attr("stroke"));
							//.parentNode.childNodes[0].getAttribute("stroke"));
						}
					});
				}
			}
		}
	}
	else if (state.Controls != null)
	{
		for(var i=0;i<state.Controls.length;i++)
		{
			state.Controls[i].destroy();
			state.Controls[i] = null;
		}
		state.Controls = null;
	}
};

// Helper function to compute the bounds of the control
var getControlBounds = function(state,inx)
{	
	if (state.Controls[inx] != null)
	{
		var oldScale = state.Controls[inx].scale;
		var w = state.Controls[inx].bounds.width / oldScale;
		var h = state.Controls[inx].bounds.height / oldScale;
		var s = state.view.scale;			

		return new mxRectangle(state.x -5 + 20 * inx,state.y - h *s - 5 , w * s, h * s);
	}
	
	return null;
};

// Overridden to update the scale and bounds of the control
mxCellRendererRedrawControl = mxCellRenderer.prototype.redrawControl;
mxCellRenderer.prototype.redrawControl = function(state)
{
	mxCellRendererRedrawControl.apply(this, arguments);
	
	if (state.Controls != null)
	{
		var s = state.view.scale;
		for(var i=0;i<state.Controls.length;i++){
			var bounds = getControlBounds(state,i);
			if (state.Controls[i].scale != s || !state.Controls[i].bounds.equals(bounds))
			{				
				state.Controls[i].bounds = bounds;
				state.Controls[i].scale = s;	
				state.Controls[i].redraw();	
			}
		}
	}
};

// Overridden to remove the control if the state is destroyed
mxCellRendererDestroy = mxCellRenderer.prototype.destroy;
mxCellRenderer.prototype.destroy = function(state)
{
	mxCellRendererDestroy.apply(this, arguments);
	if (state.Controls != null)
	{
		for(var i=0;i<state.Controls.length;i++)
		{
			state.Controls[i].destroy();
			state.Controls[i] = null;
		}
		state.Controls = null;
	}
};
