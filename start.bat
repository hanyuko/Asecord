@echo off
if not DEFINED IS_MINIMIZED set IS_MINIMIZED=1 && start "" /min "%~dpnx0" %* && exit
node C:\Users\Admin\AppData\Roaming\Aseprite\scripts\discord-rpc-aseprite\index.js
exit