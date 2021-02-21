local id = os.getComputerID()
local m = peripheral.wrap("left")
local isOpen = m.isOpen(id)
if not isOpen then
  m.open(id)
end

m.transmit(6, id)

local e = { os.pullEvent("modem_message") }
write("Pressure Chamber is turned ")
if e[5] then
  print("ON")
else
  print("OFF")
end

if not isOpen then
  m.close(id)
end
