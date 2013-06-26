### This script is use to restart the FMS server after rebooting the server.

# Change Directory
  cd /ebs/adobe/fms/
  
# Stop FMS-manager 
  sudo ./fmsmgr server fms stop

# Stop FMS-admin server
  sudo ./fmsmgr adminserver stop

# Start FMS-manasger server
  sudo ./fmsmgr server fms start

# Start FMS-admin server
  sudo ./adminserver start
