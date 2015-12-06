opsworks-meteor-deploy Cookbook
===============================

This repository includes 2 cookbooks for deploying and starting a meteor application that has been compiled into a node application on Amazon Web Services Opsworks in a scalable manner.


###Based on deploying a meteor app after running [`meteor build`](https://www.meteor.com/isobuild).  


1. The first cookbook installs [foreverjs](https://github.com/foreverjs/forever), the npm module that can start a node application as a daemon.
	1. This cookbook should be called as `foreverjs` in AWS Opsworks under the Configure series of Chef recipes for the Node.js layer.
2. The second cookbook, meteor-deploy, runs the two commands necessary to start the node application. 
	1. Commands executed (similar to the `meteor build` instructions)
		1. `(cd programs/server && npm install)`
		2. `PORT=port ROOT_URL=root_url MONGO_URL=mongo_url MAIL_URL=mail_url forever start main.js`
	2. This cookbook should be called as `meteor-deploy` in the Deploy series of Chef recipes for the Node.js layer. 
	3. Make sure to replace the directory variable `YOUR_APP_NAME` with your application's name. 
	4. Place this JSON in the Custom JSON area of the Stack Settings Configuration management
	```
	{
	  "deploy" : {
	    "app_name" : {
	      "PORT" : "port",
	      "ROOT_URL" : "root_url",
	      "MONGO_URL" : "mongo_url",
	      "MAIL_URL" : "mail_url"
	    }
	  }
	}
	```
		  
###### Note 1: You need to build the application for the proper architecture i.e. if you run the command on an OS X machine, but plan to deploy to a linux server, you need to specify the architecture with `--architecture`.


###### Note 2: The `meteor build` output README specifies exporting the ROOT_URL, MONGO_URL, and MAIL_URL variable then running `node main.js`.  This does not work well with Opsworks because Chef recipies wait for the specified command to finish, so foreverjs helps the cookbook to finish executing rather than stall, and specifiying these variables in the start command is simpler than exporting them into the shell environment.



The MIT License (MIT)

Copyright (c) 2015 Alex J Meyers

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
