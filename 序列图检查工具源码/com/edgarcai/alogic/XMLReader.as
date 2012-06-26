package com.edgarcai.alogic 
{
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	/**
	 * ...
	 * @author edgarcai
	 */
	public class XMLReader extends EventDispatcher
	{
		static public const CFGMISSION:String = "配置文件丢失，请检查配置文件是否存在";
		static public const EVTGETXMLCOMPLETED:String = "GETXMLCOMPLETED";
		private var _data:XML;
		private var _xmlloader:URLLoader;
		private var _xmlReq:URLRequest;
		
		public function XMLReader(xmlpath:String) 
		{
			_xmlReq = new URLRequest();
			_xmlReq.url = xmlpath;
			_xmlReq.method = URLRequestMethod.GET;
			_xmlloader = new URLLoader();
			_xmlloader.addEventListener(Event.COMPLETE, readXMLComplete);
			_xmlloader.addEventListener(IOErrorEvent.IO_ERROR, xmlMission);
			_xmlloader.load(_xmlReq);
		}
		
		private function xmlMission(e:IOErrorEvent):void 
		{
			throw(new Error(CFGMISSION));
		}
		
		private function readXMLComplete(e:Event):void 
		{
			try
			{
				_data = new XML(_xmlloader.data);
			}
			catch (e:TypeError)
			{
				trace("Could not parse the XML file.");
			}
			dispatchEvent(new Event(EVTGETXMLCOMPLETED));
		}
		
		public function getIMG():String
		{
			return _data.imgSrc;
		}
		
		public function getWidth():Number
		{
			var maxWid:Number = Number(_data.maxWid);
			return maxWid;
		}
		
		public function getHeight():Number
		{
			var maxHei:Number = Number(_data.maxHei);
			return maxHei;
		}
	}

}