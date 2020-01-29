local module = {}

local evtAdd = "added"
local evtRemove = "removed"

function usbDeviceCallback(data)
   -- TODO set audio output to the FiiO DAC
   -- TODO set audio input to the blue snowball
   pn = data["productName"]
   evt = data["eventType"]
end

module.watcher = hs.usb.watcher.new(usbDeviceCallback)
module.watcher:start()

return module
