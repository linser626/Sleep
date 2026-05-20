const { app, BrowserWindow, Tray, Menu, ipcMain } = require('electron')
const path = require('path')

let mainWindow
let tray = null

function createWindow() {
  mainWindow = new BrowserWindow({
    width: 1000,
    height: 700,
    minWidth: 800,
    minHeight: 600,
    title: '微信',
    icon: path.join(__dirname, 'public', 'favicon.ico'),
    webPreferences: {
      nodeIntegration: true,
      contextIsolation: false
    }
  })

  mainWindow.loadURL('http://localhost:5173')

  mainWindow.on('closed', function () {
    mainWindow = null
  })

  mainWindow.on('minimize', function (event) {
    event.preventDefault()
    mainWindow.hide()
  })

  mainWindow.on('close', function (event) {
    if (!app.isQuiting) {
      event.preventDefault()
      mainWindow.hide()
    }
    return false
  })
}

function createTray() {
  tray = new Tray(path.join(__dirname, 'public', 'favicon.ico'))
  const contextMenu = Menu.buildFromTemplate([
    {
      label: '显示',
      click: function () {
        mainWindow.show()
      }
    },
    {
      label: '退出',
      click: function () {
        app.isQuiting = true
        app.quit()
      }
    }
  ])
  tray.setToolTip('微信')
  tray.setContextMenu(contextMenu)

  tray.on('click', function () {
    mainWindow.show()
  })
}

app.whenReady().then(() => {
  createWindow()
  createTray()

  app.on('activate', function () {
    if (BrowserWindow.getAllWindows().length === 0) createWindow()
  })
})

app.on('window-all-closed', function () {
  if (process.platform !== 'darwin') app.quit()
})

ipcMain.on('show-window', () => {
  mainWindow.show()
})