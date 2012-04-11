package org.wongtop.mindtalk
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	
	import org.osflash.signals.Signal;

	public class MindAuth
	{
		private const GET_AUTHORIZE_TOKEN_URL:String = "http://auth.mindtalk.com/authorize";
		private const GET_ACCESS_TOKEN_URL:String = "http://auth.mindtalk.com/access_token";
		
		private var _auth_consumer:MindConsumer;		
		private var _access_token:String;
		private var _auth_code:String;
		private var _client_id:String;
		
		private var _request:URLRequest;
		private var _urlLoader:URLLoader;
		private var _redirectURL:String;
		
		/**
		 *	Signal is dispatched when token is granted (dispatch 2 value: "authorize" or "access") 
		 */
		public var requestCompleted:Signal;
		
		/**
		 * MindAuth Constructor 
		 * @param clientID	your application ID
		 * @param consumer	MindConsumer instance
		 * @param redirectURL	default value is what you fill in your application setting 
		 * 
		 */
		public function MindAuth(clientID:String, consumer:MindConsumer, redirectURL:String = "oob")
		{
			requestCompleted = new Signal(String);
			_auth_consumer = consumer;
			_client_id = clientID;
			_redirectURL = redirectURL
		}
				
		public function get access_token():String
		{
			return _access_token;
		}

		public function get authorize_url():String
		{
			return(GET_AUTHORIZE_TOKEN_URL + "?client_id=" + _client_id + "&redirect_uri=" + _redirectURL);	
		}
		
		/**
		 * Check the result of getting auth_token
		 * @param url	url to check 
		 */
		public function authorizeCheck(url:String):void
		{
			var splitURL:Array = url.split("?");
			if (splitURL[0] == "http://auth.mindtalk.com/" + _redirectURL)
			{
				var splitResult:Array = splitURL[1].split("&");
				_auth_code = splitResult[0];
				requestCompleted.dispatch("authorize");
				
				getAccessToken();
			}
		}
		
		private function getAccessToken():void
		{
			_request = new URLRequest(GET_ACCESS_TOKEN_URL + "?" + _auth_code + "&client_secret=" + _auth_consumer.secret);
			_request.method = URLRequestMethod.GET;
			
			// Invoking remote service with URLLoader
			_urlLoader = new URLLoader();
			_urlLoader.addEventListener(Event.COMPLETE, getaccessToken_completeHandler);			
			_urlLoader.load(_request);
		}
		
		private function getaccessToken_completeHandler(event:Event):void
		{
			_urlLoader.removeEventListener(Event.COMPLETE, getaccessToken_completeHandler);
			
			var arrResult:Array = String(_urlLoader.data).split("&"); 
			_access_token = arrResult[0];
			requestCompleted.dispatch("access");
		}
	}
}