package com.edgarcai.alogic 
{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.net.*;
	import flash.system.*;
	
	/**
	 * ...
	 * @author edgarcai
	 */
	public class ResLoader extends EventDispatcher 
	{
		static public const EVTGETRESFINISH:String="event_getresfinsish";
		private var _loader:Loader;
		private var _req:URLRequest;
		private var _data:BitmapData;
		
		public function ResLoader(respath:String) 
		{
			_req = new URLRequest(respath);
			trace("respath:"+respath);
			var lc:LoaderContext = new LoaderContext(false, ApplicationDomain.currentDomain);
			_loader = new Loader();
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, getResCompleted);
			_loader.load(_req, lc);
			
		}
		
		private function getResCompleted(e:Event):void 
		{
			var result:DisplayObject = _loader.content;
			var rect:Rectangle = result.getRect(result);
			var m:Matrix = new Matrix();
			m.translate( -rect.x, -rect.y);
			_data  = new BitmapData(rect.width, rect.height, true, 0);
			_data.draw(result, m);
			dispatchEvent(new Event(EVTGETRESFINISH));
		}
		
		public function getData():BitmapData
		{
			return _data;
		}
	}

}