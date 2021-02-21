local rsSide = "back"
local wifi = peripheral.wrap("right")
local monitor = peripheral.wrap("monitor_0")
local machineName = "Mob Spawner"

function UpdateDisplay()
  term.clear()
  monitor.clear()
  term.setCursorPos(1,2)
  monitor.setCursorPos(2,3)
  
  print(" Space : Toggle On/Off")
  print("     Q : Quit")
  print("")
  print(string.format(" Computer ID: %d", os.getComputerID()))
  write(string.format(" %s is ", machineName))

  local on = rs.getOutput(rsSide)
  if on then
    print("ON")
    monitor.write("IS ON")
  else
    print("OFF")
    monitor.write("IS OFF")
  end
  
  print("")
end

local running = true
while running do
  local e = { os.pullEvent() }
  local on = rs.getOutput(rsSide)
  
  if e[1] == "modem_message" then
    if e[5] == nil or e[5] == "" then
      rs.setOutput(rsSide, not on)
    else
      rs.setOutput(rsSide, string.lower(e[5]) == "on")
    end
    
    modem.transmit(e[4], os.getComputerID(), rs.getOutput(rsSide))
  
  elseif e[1] == "key_up" then
    if e[2] == keys.space then
      rs.setOutput(rsSide, not on)
    
    elseif e[2] == keys.q then
      running = false
    end
  
  elseif e[1] == "monitor_touch" then
    rs.setOutput(rsSide, not on)
  end
  
  UpdateDisplay()
end
