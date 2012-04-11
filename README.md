SIMPLE MINDTALK OAUTH LIBRARY FOR FLASH, FLEX, AIR
--------------------------------------------------

Simple Library (just for get access_token) for mindtalk OAuth

Usage
-----
* Use HTML/StageWebView component to open MindTalk authorization window
* If you're using full flash then you must use JavaScript and add externalInterface to communicate with open window
* Use authorizeCheck function to determine whether authorize_token is granted
* The process to get access_token is done in class
* Access Token can be accessed from access_token property

for Flow of Authorization in MindTalk, read [this](http://developer.digaku.com/api/wiki/GettingStarted)

Flash Player 11/Adobe AIR 3.1 is required for native JSON parsing. For older version of FP/AIR you can use [as3corelib](https://github.com/mikechambers/as3corelib) by Mike Chambers

Example can be download in [here](http://dl.dropbox.com/u/3448399/MindAuth%20Example.air) its source is inside example folder