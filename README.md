# Asecord - Discord Rich Presence for Aseprite ( v1.0.2 )
A discord rich presence for Aseprite!cool and ez to use. 😎

<img src='https://i.imgur.com/16YZ06v.png'/>

<h3><b><img src='https://media.discordapp.net/attachments/1058387963609874474/1170214350603169852/vietnam-twitter.png?width=22&height=22'/> Fact:</b> thằng lon này biết code Lua đó, có vấn đề gì ko 🥱</h3>
<img src='https://i.imgur.com/KxN0oM9.png'/>

## Requirements
- NodeJS 16^ - [Download](https://nodejs.org/en) | *( Recommend: [`LTS 18.20`](https://nodejs.org/en/blog/release/v18.12.0) or `LTS 21.1` )*.
- NPM - Included with NodeJS.
- Windows Build Tools - check Setup part.

## Setup
- Pull the repository files, or download the repository ZIP and extract the files.
<img src='https://i.imgur.com/ZxlGDGV.png' width=306/>

- Open Aseprite then click **File > Scripts > Open Scripts Folder**.
<img src='https://i.imgur.com/Fotwx7Q.png' width=290/>

- Move all files and folders to the **Scripts** folder and rescan Scripts folder.
<img src='https://i.imgur.com/rtoFZ8h.png'/>  <img src='https://i.imgur.com/H2sE72z.png'/>

- After that, open the Discord RPC script and click `Install` button.<br>
<img src='https://i.imgur.com/yB5E8Qw.png'/>  <img src='https://i.imgur.com/0Jymnhu.png'/>

## How to use?
- This is dialog of Asecord@1.0.2, below it are some instructions for use
<img src='https://i.imgur.com/31j1Wz8.png' width=340/>

### Variables
- `{empty}` - this will be replaced with an empty space.
- `{file_name}` - this will be replaced with file's name.
- `{file_type}` - this will be replaced with file's fomat.
- *Will be updated more in v1.0.3*

### Buttons
- `START` - run discord rich presence.
- `INSTALL` - this will install all necessary packages.
- `SAVE` - this will save all rpc data to the config file.
- `RESET` - this will reset all rpc configuration.

## Supported File Extensions
- `ASE`/`ASEPRITE`,
- `JPG`,
- `PNG`,
- `GIF`,
- Other extensions will be shown as _image_.

## Note
- Please note that **only** the currently open **file name and extension** will be shown on the presence.
- If you see an `Error: RPC_CONNECTION_TIMEOUT` error, close the presence window, and open it again after 5 minutes.
- If you receive the message `Aseprite is not open`, just tap in Aseprite icon to display it on the screen.
- When installing package, if you see this error that means you have installed **window-build-tools** on your Desktop.
<img src='https://i.imgur.com/a9xakZG.png' width=240/>

## License
- This repository has been licensed by the [MIT license](https://github.com/hanyuko/Asecord/blob/main/LICENSE). ⚖
