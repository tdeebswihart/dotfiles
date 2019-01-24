-- ~/.hammerspoon/init.lua
hs.loadSpoon("Lunette")
spoon.Lunette:bindHotkeys()

hs.dockicon.hide()

local global = require 'global'
local keepit = require 'keepit'
local mail = require 'mail'
