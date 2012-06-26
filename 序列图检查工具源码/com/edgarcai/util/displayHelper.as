package com.edgarcai.util 
{
	import flash.display.*;
	import flash.geom.*;
	/**
	 * ...
	 * @author edgarcai
	 */
	public class displayHelper 
	{
		
		/**
		 * 切分位图为一组较小的位图
		 * 
		 * @param source
		 * @param width
		 * @param height
		 * @param toBitmap	转换为Bitmap（而非BitmapData）
		 * @return 
		 * 
		 */
		public static function separateBitmapData(source:BitmapData,width:int,height:int,toBitmap:Boolean = false):Array
		{
			var result:Array = [];
			for (var j:int = 0;j < Math.ceil(source.height / height);j++)
			{
				for (var i:int = 0;i < Math.ceil(source.width / width);i++)
				{
					
					var bitmap:BitmapData = new BitmapData(width,height,true,0);
					bitmap.copyPixels(source,new Rectangle(i*width,j*height,width,height),new Point());
					if (toBitmap)
					{
						var bp:Bitmap = new Bitmap(bitmap);
						bp.x = i * width;
						bp.y = j * height;
						result.push(bp);
					}
					else {
						var maskColor:uint = 0xFFFFFF; 
						var color:uint = 0xFF0000;  
						var maskrect:Rectangle = bitmap.getColorBoundsRect(maskColor, color, false);
						trace("maskrect:"+maskrect.width+","+maskrect.height);
						if ((maskrect.width != 0)&&(maskrect.height!=0))
						{
							result.push(bitmap)
						}
					}
				}	
			}
			return result;
		}
		
	}

}