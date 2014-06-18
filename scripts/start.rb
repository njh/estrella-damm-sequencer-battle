#!/usr/bin/env ruby

PORTBASE=4000
DECKS=9
SIDES=2


puts "Starting mixer..."
processes = []
processes << Process.spawn("jackminimix -a -c #{SIDES} -p #{PORTBASE}")

sleep 1

puts 

(1..SIDES).each do |s|
  (1..DECKS).each do |d|
    i = ((s-1)*DECKS)+d
    processes << Process.spawn(
      "madjack -j -q "+
      "-d /Users/humfrn01/mhd/ "+
      "-n madjack#{i} "+
      "-p #{PORTBASE+i} "+
      "-l 'minimixer:in#{s}_left' "+
      "-r 'minimixer:in#{s}_right' "
    )
    sleep 0.5
  end
end


puts "Type Ctrl-C to stop"
begin
  loop { sleep(10) }
rescue Interrupt
  puts "Shutting down"
end

processes.each do |pid|
  Process.kill("INT", pid)
end

Process.wait
