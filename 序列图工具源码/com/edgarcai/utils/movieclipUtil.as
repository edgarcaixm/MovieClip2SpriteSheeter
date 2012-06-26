package com.edgarcai.utils
{
	import flash.display.MovieClip;
	import flash.geom.Rectangle;

	public class movieclipUtil
	{
		//获得元件最大宽高
		public static function getMCMaxSize(obj:MovieClip):Object
		{
			var result:Object = new Object();
			result.width = 0;
			result.height = 0;
			
			var currWidth:Array = new Array();
			var currHeight:Array = new Array();
			for (var msetp:int=1; msetp<=obj.totalFrames; msetp++)
			{
				obj.gotoAndStop(msetp);
				var currBoud:Rectangle = obj.getBounds(obj);
				var currWid:Number = Math.ceil(currBoud.width);
				var currHei:Number = Math.ceil(currBoud.height);
				currWidth.push(currWid);
				currHeight.push(currHei);
			}
			result.width = mathUtil.maxArray(currWidth);
			result.height = mathUtil.maxArray(currHeight);
			return result;
		}
		
		//获得元件数组最大宽高
		public static function getMCArrayMaxSize(mcArray:Array):Object
		{
			var result:Object = new Object();
			result.width = 0;
			result.height = 0;
			
			var currWidth:Array = new Array();
			var currHeight:Array = new Array();
			for(var i:uint = 0;i< mcArray.length;i++)
			{
				var obj:MovieClip = mcArray[i];
				for (var msetp:int=1; msetp<=obj.totalFrames; msetp++)
				{
					obj.gotoAndStop(msetp);
					var currBoud:Rectangle = obj.getBounds(obj);
					var currWid:Number = Math.ceil(currBoud.width);
					var currHei:Number = Math.ceil(currBoud.height);
					currWidth.push(currWid);
					currHeight.push(currHei);
					trace("calc "+obj.name+" mc size:"+currWid+","+currHei);
				}
			}
			result.width = mathUtil.maxArray(currWidth);
			result.height = mathUtil.maxArray(currHeight);
			return result;
		}
	}
}