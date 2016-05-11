opsworks-meteor-deploy Cookbook
===============================

This repository includes 4 cookbooks for deploying and starting a meteor application that has been compiled into a node application on Amazon Web Services Opsworks in a scalable manner.  (Based on AWS Opsworks Chef 11, but given the inclusion of a nodejs cookbook, Chef 12 on AWS Opsworks would work as well.)


###Based on deploying a meteor app after running [`meteor build`](https://www.meteor.com/isobuild).  


1. The first cookbook installs node v0.10.45 follwing [this guide](# Following https://github.com/nodesource/distributions#debinstall).  This is necessary with Meteor 1.3.* because the latest version of Meteor needs node v0.10.41 or greater (but not greater v0.10.4x).  Opsworks with Cheff 11 only supports node v0.10.40 as of May 2016, so the node script is needed to upgrade to node v0.10.45.
  1. This cookbook should be called as `node-v0_10_45` in AWS Opsworks under the Setup series of Chef recipes for the Node.js layer.
2. The second cookbook installs [foreverjs](https://github.com/foreverjs/forever), the npm module that can start a node application as a daemon.
  1. This cookbook should be called as `foreverjs` in AWS Opsworks under the Setup series of Chef recipes for the Node.js layer.
3. The third cookbook installs [phantomjs](http://phantomjs.org/), ~~this dependency is useful for certain Meteor functionality such as using [spiderable](https://atmospherejs.com/meteor/spiderable) for SEO.~~ Spiderable does not work well as of May 2016.  Phantomjs is still helpful for rendering the meteor app for SEO.  The Meteor Development Group now recommends using [prerender.io](https://prerender.io/) for SEO.
  1. This cookbook should be called as `phantomjs` in AWS Opsworks under the Setup series of Chef recipes for the Node.js layer.
4. The fourth cookbook, meteor-deploy, runs the two commands necessary to start the node application. 
  1. Commands executed (similar to the `meteor build` instructions)
    1. `(cd programs/server && npm install)`
    2. `PORT=port ROOT_URL=root_url MONGO_URL=mongo_url MAIL_URL=mail_url forever start main.js`
  2. This cookbook should be called as `meteor-deploy` in the Deploy series of Chef recipes for the Node.js layer. 
  3. Make sure to replace the directory variable `YOUR_APP_NAME` with your application's name. 
  4. Place this JSON in the Custom JSON area of the Stack Settings Configuration management
  ```
  {
    "deploy" : {
      "YOUR_APP_NAME" : {
        "PORT" : "port",
        "ROOT_URL" : "root_url",
        "MONGO_URL" : "mongo_url",
        "MAIL_URL" : "mail_url",
        [optional] "DISABLE_WEBSOCKETS" : 0 or 1
      }
    }
  }
  ```
5. The fifth cookbook, meteor-undeploy, runs the command necessary to stop the meteor application from running with `forever stopall`.
  1. This cookbook should be called as `meteor-undeploy` in the Undeploy series of Chef recipes for the Node.js layer. 

      
###### Note 1: You need to build the application for the proper architecture i.e. if you run the command on an OS X machine, but plan to deploy to a linux server, you need to specify the architecture with `--architecture`.


###### Note 2: The `meteor build` output README specifies exporting the ROOT_URL, MONGO_URL, and MAIL_URL variable then running `node main.js`.  This does not work well with Opsworks because Chef recipies wait for the specified command to finish, so foreverjs helps the cookbook to finish executing rather than stall, and specifiying these variables in the start command is simpler than exporting them into the shell environment.

###### Note 3: The undeploy cookbook does not run properly unless the developer explicity runs it in the Opsworks Deploy Apps commands.  It should run automatically when deploying a new version of the application, but for some reason it does not finish running `forever stopall`; therefore `Undeploy` needs to be explicity run before running `Deploy`.



The MIT License (MIT)

Copyright (c) 2016 Alex J Meyers

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
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
