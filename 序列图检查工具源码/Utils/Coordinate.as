package Utils
{
	import flash.display.Graphics;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.utils.Timer;
	
	/**
	 * 直角坐标系
	 */
	public dynamic class Coordinate extends Sprite
	{
		private var isDart:Boolean = true;
		private var timer:Timer;
		private var delay:Number = 20;
		private var horizArrow:MovieClip;
		private var verticalArrow:MovieClip;
		private var fmt:TextFormat = new TextFormat("Arial", 10);
		private var fmtTimes:TextFormat = new TextFormat("Times New Roman", 12, 0xaa0000, false, true);
		
		protected var horizMark:Number = 10;
		protected var verticalMark:Number = 10;
		protected var Gridlines:Number = 0.1;
		protected var horizLabel:String = "x";
		protected var verticalLabel:String = "y";
		
		public var LightColor:Number = 0x00aa00;
		public var DarkColor:Number = 0x00aa00;
		// 常用参数
		public var Width:Number = 100;
		public var Height:Number = 100;
		public var ExtendRate:Number = 1.05;
		public var horizUnit:Number = 5;
		public var verticalUnit:Number = 5;
		public var horizRatio:Number = 1;
		public var verticalRatio:Number = 1;
		
		/**
		 * 构造器
		 * @param        markHoriz
		 * @param        markVertical
		 * @param        arrow        axis direction.
		 */
		public function Coordinate(markHoriz:int = 10, markVertical:int = 10, arrow:Boolean = true)
		{
			horizMark = markHoriz;
			verticalMark = markVertical;
			isDart = arrow;
			horizArrow = showAxis(horizLabel, 0);
			verticalArrow = showAxis(verticalLabel, 270);
			addEventListener(Event.ADDED_TO_STAGE, _init);
		}
		
		protected function _init(e:Event = null):void
		{
			DrawGrid();
		}
		
		/**
		 * 描绘坐标系统
		 * @param        h_unit        水平单位内像素
		 * @param        v_unit        垂直单位内像素
		 */
		protected function DrawGrid(h_unit:Number = 0, v_unit:Number = 0):void
		{
			if (h_unit == 0)
				h_unit = horizUnit;
			if (v_unit == 0)
				v_unit = verticalUnit;
			var i:int = Math.floor((-Width * ExtendRate / 2 - x) / h_unit);
			var j:int = Math.floor((-Height * ExtendRate / 2 - y) / v_unit);
			var t:TextField = new TextField();
			
			graphics.clear();
			while (numChildren > 0)
			{
				removeChildAt(0);
			}
			while (i <= Math.floor((Width * ExtendRate / 2 - x) / h_unit))
			{
				if (i % horizMark == 0)
				{
					t = AppendLabel(i * horizRatio + "");
					t.x = i * h_unit - t.width / 2;
					if (y < -Height / 2)
					{
						t.y = -Height / 2 - y;
					}
					else if (y > Height / 2 - t.height)
					{
						t.y = Height / 2 - t.height - y;
					}
					else
					{
						t.y = -1;
					}
					graphics.lineStyle(Gridlines, DarkColor, 0.5);
					if (i == 0)
					{
						t.text = "O";
						t.x = -t.width;
						t.setTextFormat(fmtTimes);
						graphics.lineStyle(0.5, 0, 1);
					}
					addChild(t);
				}
				else
					graphics.lineStyle(Gridlines, LightColor, 0.2);
				
				graphics.moveTo(i * h_unit, -Height * ExtendRate / 2 - y);
				graphics.lineTo(i * h_unit, Height * ExtendRate / 2 - y);
				i++;
			}
			while (j <= Math.floor((Height * ExtendRate / 2 - y) / v_unit))
			{
				if (j % verticalMark == 0)
				{
					t = AppendLabel(j * verticalRatio + "", "right");
					if (x < -Width / 2 + t.width + 2)
					{
						t.x = -Width / 2 + 2 - x;
					}
					else if (x > Width / 2 - 2)
					{
						t.x = (Width / 2 - t.width - 2) - x;
					}
					else
					{
						t.x = -t.width;
					}
					t.y = j * v_unit - t.height / 2;
					graphics.lineStyle(Gridlines, DarkColor, 0.5);
					if (j == 0)
					{
						t.text = "";
						graphics.lineStyle(0.5, 0, 1);
					}
					addChild(t);
				}
				else
					graphics.lineStyle(Gridlines, LightColor, 0.2);
				
				graphics.moveTo(-Width * ExtendRate / 2 - x, j * v_unit);
				graphics.lineTo(Width * ExtendRate / 2 - x, j * v_unit);
				j++;
			}
			if (isDart)
			{ 
				//坐标轴箭头与标示
				horizArrow.x = Width * ExtendRate / 2 - x;
				if (y < -Height / 2)
				{
					horizArrow.y = -Height / 2 - y;
				}
				else if (y > Height / 2)
				{
					horizArrow.y = Height / 2 - y;
				}
				else
				{
					horizArrow.y = 0;
				}
				if (x < -Width / 2)
				{
					verticalArrow.x = -Width / 2 - x;
				}
				else if (x > Width / 2)
				{
					verticalArrow.x = Width / 2 - x;
				}
				else
				{
					verticalArrow.x = 0;
				}
				
				verticalArrow.y = -Height * ExtendRate / 2 - y;
				addChild(horizArrow);
				addChild(verticalArrow);
			}
		}
		
		/**
		 * 显示坐标轴箭头与坐标轴标注文本
		 * @param        axisLabel        标注
		 * @param        arrowDegree        箭头角度
		 * @return        带标注的箭头剪辑
		 */
		protected function showAxis(axisLabel:String, arrowDegree:Number = 0):MovieClip
		{
			var s:Shape = new Shape();
			var shap:MovieClip = new MovieClip();
			var g:Graphics = s.graphics;
			var t:TextField = new TextField();
			
			g.beginFill(0);
			g.moveTo(0, 0);
			g.lineTo(-2, -3);
			g.lineTo(6, 0);
			g.lineTo(-2, 3);
			g.lineTo(0, 0);
			g.endFill();
			s.rotation = arrowDegree;
			shap.addChild(s);
			
			t = AppendLabel(axisLabel, "right");
			if (arrowDegree == 0 || arrowDegree == 180 || arrowDegree == -0 || arrowDegree == -180)
			{
				t.x = 7;
				t.y = -t.height / 2;
			}
			if (arrowDegree == 90 || arrowDegree == 270 || arrowDegree == -90 || arrowDegree == -270)
			{
				
				t.x = -t.width / 2;
				t.y = -t.height - 6;
			}
			t.setTextFormat(fmtTimes);
			shap.addChild(t);
			return shap;
		}
		
		protected function AppendLabel(str:String, agn:String = "center"):TextField
		{
			var t:TextField = new TextField();
			t.text = str;
			t.setTextFormat(fmt);
			t.width = t.textWidth + 5;
			t.height = t.textHeight + 3;
			t.autoSize = agn;
			t.selectable = false;
			t.antiAliasType = AntiAliasType.ADVANCED;
			return t;
		}
		
		public function Update():void
		{
			DrawGrid();
		}
		
		/**
		 * 设定内部参数
		 * @param        h_mark        水平高亮的单位
		 * @param        v_mark        垂直高亮的单位
		 * @param        grid_lines_width        网格的线条宽度
		 * @param        h_label        水平标注
		 * @param        v_label        垂直标注
		 */
		public function SetCoordinate(h_mark:Number = 10, v_mark:Number = 10, grid_lines_width:Number = 0.1, h_label:String = "x", v_label:String = "y"):void
		{
			horizMark = h_mark;
			verticalMark = v_mark;
			Gridlines = grid_lines_width;
			horizLabel = h_label;
			verticalLabel = v_label;
		}
	
	}

}