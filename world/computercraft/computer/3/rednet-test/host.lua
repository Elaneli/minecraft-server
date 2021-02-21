local m = peripheral.wrap("front")
m.open(1)
local monitor = peripheral.wrap("top")

while true do
local e, s, c, rC, msg, d = os.pullEvent("modem_message")
monitor.clear()
monitor.setCursorPos(1,1)
monitor.write(msg)
end

