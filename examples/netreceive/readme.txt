*
*  FUDI as3 library
*  Netreceive example
*
   This is an example of using a netreceive object in Flash.

   1) Run fudi.jar and start the Policy and FUDI Server
   2) Open netreceive_example.pd and follow the steps descriped in the patch
   3) Open netreceive.swf

* 
*  Running the FUDI bridge:
*   
   - Windows users simply double click the fudi_bridge.jar
   - Mac and Linux users must run the fudi_bridge.jar as root
     There are two ways to do this:
     
     1) Open a terminal and cd to the folder where the fudi_bridge.jar resides,
        then type:
          sudo java -jar fudi_bridge.jar &
     2) Open a terminal and type (' ' becomes '\ '):
          sudo java -jar /path/to\ the\ folder/fudi_bridge.jar &
     
     You can close the terminal window now.
     
     For an OS other than Mac and Ubuntu your root command will probably not
     be sudo.
