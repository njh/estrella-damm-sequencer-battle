#!/usr/bin/env ruby

require 'rubygems'
require 'net/http'
require 'json'
require 'pp'

API_KEY='1ed71a4bb7bac0d30e3a3167c9b535ec57e60159'
THEMES=['piano', 'fart', 'guitar', 'drum', 'synth', 'organ'].shuffle


THEMES.each do |theme|
  Dir.mkdir(theme) unless Dir.exist?(theme)

  uri = URI.parse("http://www.freesound.org/apiv2/search/text/?filter=duration%3A%5B0+TO+1%5D+type%3Awav&query=#{theme}&format=json&token=#{API_KEY}")
  res = Net::HTTP.get_response(uri)
  data = JSON.parse(res.body)
  if data["count"].nil?
    pp data
    exit
  end

  pages = data["count"] / data["results"].count
  puts "#{pages} pages for theme #{theme}"


  count = 0
  while count < 10 do
    page = rand(pages)+1
    
    puts "Fetching #{theme}, page #{page}"
    uri = URI.parse("http://www.freesound.org/apiv2/search/text/?filter=duration%3A%5B0+TO+1%5D+type%3Awav&query=#{theme}&page=#{page}&format=json&token=#{API_KEY}")
    res = Net::HTTP.get_response(uri)
    data = JSON.parse(res.body)

    if data["results"].nil?
      pp data
      exit
    end

    data["results"].shuffle.each do |item|
      id = item['id']

      sleep(1.5)

      uri = URI.parse("http://www.freesound.org/apiv2/sounds/#{id}/?token=#{API_KEY}")
      res = Net::HTTP.get_response(uri)
      data = JSON.parse(res.body)
      if data['previews'].nil?
        pp data
        exit
      end
 
      system("curl -s -o '#{theme}/#{id}.mp3' #{data['previews']['preview-hq-mp3']}")
      system("mpg123 -q -w '#{theme}/#{id}.wav' '#{theme}/#{id}.mp3'")
      File.unlink("#{theme}/#{id}.mp3")
    
      system("sox '#{theme}/#{id}.wav' '#{theme}/#{id}-trimmed.wav' reverse silence 1 0.1 4% reverse")
      File.unlink("#{theme}/#{id}.wav")
    
      duration = -1
      info = `soxi '#{theme}/#{id}-trimmed.wav'`
      if info =~ /Duration\s+:\s+00:00:(\d+\.\d+)/
        duration = $1.to_f  
      end
    
      if duration > 0.4
        system("lame --resample 44100 -b 128 '#{theme}/#{id}-trimmed.wav' '#{theme}/#{id}.mp3'")
        count += 1
      end
  
      File.unlink("#{theme}/#{id}-trimmed.wav")
    end

  end

end
