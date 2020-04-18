local module = {}

local evtAdd = "added"
local evtRemove = "removed"
local fiion = "FiiO USB DAC-E17"
local bluen = "Blue Snowball "

function usbDeviceCallback(data)
   -- TODO set audio output to the FiiO DAC
   -- TODO set audio input to the blue snowball
   pn = data["productName"]
   evt = data["eventType"]
   if pn == blue then
     if evt == evtAdd then
       hs.findDeviceByName(blue):setDefaultInputDevice()
     end
   elseif pn == fiio then
     if evt == evtAdd then
       hs.findDeviceByName(fiio):setDefaultOutputDevice()
     end
   end

end

module.watcher = hs.usb.watcher.new(usbDeviceCallback)
module.watcher:start()

return module
