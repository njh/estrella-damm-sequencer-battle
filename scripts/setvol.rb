#!/usr/bin/env ruby

system("oscsend localhost 4000 /mixer/channel/set_gain if 1 0")
system("oscsend localhost 4000 /mixer/channel/set_gain if 2 0")
