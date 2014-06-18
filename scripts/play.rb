#!/usr/bin/env ruby

PORTBASE=4001

(0..18).each do |index|
  system("oscsend localhost #{PORTBASE+index} /deck/play")
  sleep 0.1
end
