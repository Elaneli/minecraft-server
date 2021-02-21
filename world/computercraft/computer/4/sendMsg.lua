local tgt, msg = ...
tgt = tonumber(tgt)
local m = peripheral.wrap("back")
m.transmit(tgt, tgt, msg)

