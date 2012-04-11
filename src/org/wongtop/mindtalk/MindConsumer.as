package org.wongtop.mindtalk
{
	public class MindConsumer
	{
		private var _key:String;
		private var _secret:String;
		
		public function MindConsumer(consumerKey:String, consumerSecret:String)
		{
			_key = consumerKey;
			_secret = consumerSecret;
		}

		public function get secret():String
		{
			return _secret;
		}

		public function set secret(value:String):void
		{
			_secret = value;
		}

		public function get key():String
		{
			return _key;
		}

		public function set key(value:String):void
		{
			_key = value;
		}

	}
}