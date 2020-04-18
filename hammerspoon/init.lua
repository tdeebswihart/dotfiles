-- ~/.hammerspoon/init.lua
hs.loadSpoon("Lunette")
spoon.Lunette:bindHotkeys()

hs.dockicon.hide()

local global = require 'global'
local keepit = require 'keepit'
local mail = require 'mail'

local sleepwake = require 'sleepwake'
local wifi = require 'wifi'
local usb = require 'usb'
local wifi = require 'wifi'

function reloadConfig(files)
    doReload = false
    for _,file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end
homewatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.alert.show("Config loaded")
