const wi = require('@arcsine/win-info') // 0.1.2
const fs = require('fs')
const fp = require('find-process') // 1.4.3
const readline = require('readline')
const exec = require('child_process').execFile
const DiscordRPC = require('discord-rpc')
const config = require('./config.json')

// DiscordRPC.register(config.clientId)
const rpc = new DiscordRPC.Client({ transport: 'ipc' })
const startTimestamp = new Date()

// Screen checker
const rl = readline.createInterface({ input: process.stdin, output: process.stdout })

async function UpdatePresence() {
  fs.readFile('config.txt', 'utf8', async(err, data) => {
    if (err) return console.error(err)

    const apps = await fp('name', 'Aseprite')
    let App, Window
  
    for (let i = 0; i < apps.length; i++) {
      if (['Aseprite.exe'].includes(apps[i].name)) {
        App = apps[i]
      }
    }
  
    // Main Database
    let dlgData = data.split(';')

    // Image Presence config
    var Presence = {
      largeImageKey: 'icon',
      smallImageKey: 'asecord-bg',
      largeImageText: 'Aseprite Idling',
      smallImageText: dlgData[5]
    }
        
    if (App) {
      try { 
        Window = wi.getByPidSync(App.pid)
      } catch {
        console.log('Aseprite is not open.')
        return
      }
    }

    if (Window) {
      var Idle = false
      // Convert string to boolean
      const StrToBool = {
        'true': true,
        'false': false
      }
      var fileType

      if (Window.title.includes(' - ')) {
        Window.filename = Window.title.split(' - ')[0]
        Presence.smallImageKey = 'aseprite_file'

        // split and slice the file's format
        let str = Window.filename
        let arr = str.split('.')
        let lastValue = arr[arr.length - 1]
        fileType = '.' + lastValue

        // Case
        switch (lastValue) {
          case 'ase':
            Presence.largeImageKey = 'ase'
            Presence.largeImageText = '.ase'
          break
          case 'aseprite':
            Presence.largeImageKey = 'ase'
            Presence.largeImageText = '.aseprite'
          break
          case 'png':
            Presence.largeImageKey = 'png'
            Presence.largeImageText = '.png'
          break
          case 'jpg':
            Presence.largeImageKey = 'jpg'
            Presence.largeImageText = '.jpg'
          break
          case 'gif':
            Presence.largeImageKey = 'https://i.imgur.com/NiqWMhC.gif'
            Presence.largeImageText = '.gif'
          break
          default:
            Presence.largeImageKey = 'img';
            Presence.largeImageText = 'Image'
          break
        }
      } else {
        // Idling
        Idle = true
        Presence.largeImageKey = 'icon'
        Presence.largeImageText = 'Aseprite Idling'
      }

      // Detail section config
      const Detail = Window && Window.filename ?
        dlgData[1].replaceAll('{empty}', '\u200b')
        .replaceAll('{file_name}', Window.filename)
        .replaceAll('{file_type}', fileType)
      : dlgData[0]

      // State section config
      const State = Window && Window.filename ?
        dlgData[2].replaceAll('{empty}', '\u200b')
        .replaceAll('{file_name}', Window.filename)
        .replaceAll('{file_type}', Presence.largeImageText)
      : dlgData[3]

      // Handle
      if (!rpc) return
      else {
        // Set rich presence
        rpc.setActivity({
          details: StrToBool[dlgData[8]] ? undefined : Detail,
          state: StrToBool[dlgData[9]] ? undefined : State,
          startTimestamp: StrToBool[dlgData[10]] ? null : startTimestamp,
          largeImageKey: Presence.largeImageKey,
          largeImageText: Idle ? dlgData[4] : dlgData[6]
          .replaceAll('{file_name}', Window.filename)
          .replaceAll('{file_type}', Presence.largeImageText),
          smallImageKey: Presence.smallImageKey,
          smallImageText: Idle ? dlgData[5] : dlgData[7],
          instance: true,
        }, App.pid || null)
      }
    }
  })
}

// Main Function
function StartPresence() {
  UpdatePresence()
  
  rpc.on('ready', () => {
    UpdatePresence()
    // activity will reset every 3 seconds
    console.log('Connected to Discord.')
    setInterval(() => {
      UpdatePresence()
    }, 3000)
  })

  console.log('Connecting...')
  rpc.login({ 
    clientId: config.clientId
  }).catch((err) => { console.log(err) })

  exec(`${config.path}`)
}

if (config.path == '') {
  rl.question('Please enter your Aseprite.exe path: ', function(path) {
    rl.close()
    config.path = path

    fs.writeFile('./config.json', JSON.stringify(config, null, 4), function writeJSON(err) {
      // if (err) return console.log(err)
      StartPresence()
    })
  })
} else {
  StartPresence()
}

// Error Handling
process.on('unhandledRejection', (reason, p) => {
  console.log(reason, p)
})
process.on('uncaughtException', (err, origin) => {
  console.log(err, origin)
})