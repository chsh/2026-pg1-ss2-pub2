#!/usr/bin/env ruby
# frozen_string_literal: true

# clock_chime.rb
#   このプログラムは〜〜〜をするものである。
#   終了は Ctrl-C。
#
#   使い方:

INTERVAL = 60
CHIME_EVERY = 3

CLOCK_FACES = %w[🕛 🕐 🕑 🕒 🕓 🕔 🕕 🕖 🕗 🕘 🕙 🕚].freeze

def next_tick(now = Time.now)
  epoch = now.to_i
  Time.at(epoch - (epoch % INTERVAL) + INTERVAL)
end

def sleep_until(target)
  loop do
    remaining = target - Time.now
    break if remaining <= 0

    sleep([remaining, 30].min)
  end
end

def show_time(time)
  puts "#{CLOCK_FACES[time.hour % 12]}  #{time.strftime('%H:%M')}"
end

def chime?(time)
  (time.min % CHIME_EVERY).zero?
end

def chime(time)
  puts "🔔  #{time.strftime('%H:%M')}"
end

puts "⏰ 起動 #{Time.now.strftime('%H:%M:%S')}（#{INTERVAL / 60}分ごと / チャイムは#{CHIME_EVERY}分ごと / Ctrl-C で終了）"

begin
  loop do
    target = next_tick
    sleep_until(target)
    show_time(target)
    chime(target) if chime?(target)
  end
rescue Interrupt
  puts "\n👋 終了 #{Time.now.strftime('%H:%M:%S')}"
end
