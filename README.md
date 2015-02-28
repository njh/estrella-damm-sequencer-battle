Estrella Damm Sequencer Battle
==============================

The cans of Estrella Damm are connected to two Arduino Uno's, that are
wired up as capitative sensors. When a can is touched, it sends serial
messages to a Raspberry Pi. The raspberry Pi then converts those serial
messages into MQTT messages and sends them to a local broker.

On a separate laptop, we are running Node-RED - a browser-based flow
editor that allows us to glue together the various inputs and outputs of
the project. When a message is received from the cans, it converts it
into an OSC message, which is sent to a MadJACK (an OSC-enabled MP3
player). Audio is played out using the jack Audio Connection Kit, via an
OSC-controled mixer.

A script was written in ruby that uses the FreeSound API to found random
sound effects shorter than one second. We then use sox, to check that
the sound levels were suitable and trim silence from the beginning and
end.

Finally, the whole thing is orchestrated using a a LEAP motion
controller, which controls a JACK mixer, again using OSC.
