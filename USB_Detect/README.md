## USB detect

### When detect usb plugins, open application.

### And you need to the write apple script to monitor the action.

'''
nvim ~/Library/LaunchAgents/com.usb.detect.plist
'''

### After go into this file, you can set some basic idea, For now is connect it to /Project/ShellScript/USB_Script/usb_script 

### Once the plist is created, you need to load it into launchd:

'''
launchctl load ~/Library/LaunchAgents/com.usb.detect.plist
'''

### To restart after changes:

'''
launchctl unload ~/Library/LaunchAgents/com.usb.detect.plist
launchctl load ~/Library/LaunchAgents/com.usb.detect.plist
'''
