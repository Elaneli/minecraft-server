local monitor = peripheral.wrap("right")
local modem = peripheral.wrap("back")

if not modem.isOpen(os.computerID()) then
  modem.open(os.computerID())
end

function toggleOn(on, reply)
  term.clear()
  term.setCursorPos(1,2)
  print(" Space : Toggle On/Off")
  print("     I : Print Computer ID")
  print("     Q : Quit")
  print("")
  monitor.clear()
  monitor.setCursorPos(2,3)
  
  if on then
    print(" Fueler is ON")
    monitor.write("IS ON")
  else
    print(" Fueler is OFF")
    monitor.write("IS OFF")
  end
      
  if not (reply == nil) then
    modem.transmit(reply, os.getComputerID(), on)
  end
  
  print("")
  rs.setOutput("top", on);
  rs.setOutput("right", on);
  rs.setOutput("bottom", on);
  rs.setOutput("left", on);
end

toggleOn(false)
local running = true
while running do

  local e = { os.pullEvent() }
  local turnOn = rs.getOutput("top")
  
  if e[1] == "modem_message" then
    if e[5] == nil or e[5] == "" then
      toggleOn(not turnOn, e[4])
    else
      turnOn = string.lower(e[5]) == "on"
      toggleOn(turnOn, e[4])
    end
    
  elseif e[1] == "key_up" then
    if e[2] == keys.space then
      toggleOn(not turnOn)
    
    elseif e[2] == keys.q then
      running = false
    
    elseif e[2] == keys.i then
      print(string.format("Computer ID: %d", os.getComputerID()))
    end
  
  elseif e[1] == "monitor_touch" then
    toggleOn(not turnOn)
  end
end
