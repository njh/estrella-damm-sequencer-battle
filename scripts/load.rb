#!/usr/bin/env ruby

PORTBASE=4001
DECKS=19

FILES=[
 'piano/68437__pinkyfinger__piano-a.mp3',
 'piano/68438__pinkyfinger__piano-b.mp3',
 'piano/68441__pinkyfinger__piano-c.mp3',
 'piano/68442__pinkyfinger__piano-d.mp3',
 'piano/68443__pinkyfinger__piano-e.mp3',
 'piano/68445__pinkyfinger__piano-f.mp3',
 'piano/68446__pinkyfinger__piano-f.mp3',
 'piano/68447__pinkyfinger__piano-g.mp3',
 'piano/68448__pinkyfinger__piano-g.mp3',
 'random/ambassador.mp3',
 'random/beep.mp3',
 'random/buzz-133962.mp3',
 'random/cat-meow.mp3',
 'random/cricket-56844.mp3',
 'random/laser-234137.mp3',
 'random/namblam.mp3',
 'random/space-buzz.mp3',
 'random/horse-117252.mp3',
 'random/toot-193287.mp3',
 'random/snyare-135340.mp3',
 'random/synth-135216.mp3',
 'random/tonk-230425.mp3',
 'random/tonk-230436.mp3',
 'random/highhat.mp3',
]

FILES[0,DECKS].each_with_index do |filename,index|
  system("oscsend localhost #{PORTBASE+index} /deck/load s #{filename}")
end

