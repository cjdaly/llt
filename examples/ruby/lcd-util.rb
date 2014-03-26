####
# Copyright (c) 2014 Chris J Daly (github user cjdaly)
# All rights reserved. This program and the accompanying materials
# are made available under the terms of the Eclipse Public License v1.0
# which accompanies this distribution, and is available at
# http://www.eclipse.org/legal/epl-v10.html
#
# Contributors:
#   cjdaly - initial API and implementation
####

# see Sparkfun serial lcd documentation for more details:
# https://www.sparkfun.com/datasheets/LCD/SerLCD_V2_5.PDF
# https://www.sparkfun.com/tutorials/246

#### WARNING:
# the 0x7c commands seem to cause the LCD to stop
# responding (until a reboot).
#
LCD_CMD = "\x7c"
LCD_CMD_BACKLIGHT = [
  "\x80", "\x81", "\x82", "\x83", "\x84", "\x85", "\x86", "\x87",
  "\x88", "\x89", "\x8a", "\x8b", "\x8c", "\x8d", "\x8e", "\x8f",
  "\x90", "\x91", "\x92", "\x93", "\x94", "\x95", "\x96", "\x97",
  "\x98", "\x99", "\x9a", "\x9b", "\x9c", "\x9d"
]
LCD_CMD_BACKLIGHT_MAX = LCD_CMD_BACKLIGHT.length - 1
####

#### 0xfe extended commands
LCD_EXT = "\xfe"
LCD_EXT_CLS = "\x01"
LCD_EXT_NL = "\xc0"
LCD_EXT_DISPLAY_ON = "\x0c"
LCD_EXT_DISPLAY_OFF = "\x08"
####

LCD_UART = "/dev/ttyO1"

def write_lcd(line1, line2 = "")
  line1 = "" if line1.nil?
  line2 = "" if line2.nil?
  File.open(LCD_UART, "w") do |file|
    file.write("#{LCD_EXT}#{LCD_EXT_CLS}")
    file.write(truncate(line1))
    file.write("#{LCD_EXT}#{LCD_EXT_NL}")
    file.write(truncate(line2))
  end
end

def clear_lcd()
  File.open(LCD_UART, "w") do |file|
    file.write("#{LCD_EXT}#{LCD_EXT_CLS}")
  end
end

def truncate(text, length = 16)
  if (text.length >= length) then
    end_position = length - 1
    text = text[0..end_position]
  else
    text = text.ljust(length)
  end
  return text
end

def set_visible(visible=true)
  File.open(LCD_UART, "w") do |file|
    if (visible) then
      file.write("#{LCD_EXT}#{LCD_EXT_DISPLAY_ON}")
    else
      file.write("#{LCD_EXT}#{LCD_EXT_DISPLAY_OFF}")
    end
  end
end

def set_backlight(brightness = LCD_CMD_BACKLIGHT_MAX)
  brightness = 0 if brightness < 0
  brightness = LCD_CMD_BACKLIGHT_MAX if brightness >= LCD_CMD_BACKLIGHT_MAX
  puts "brightness: #{brightness}"
  File.open(LCD_UART, "w") do |file|
    file.write("#{LCD_CMD}#{LCD_CMD_BACKLIGHT[brightness]}")
  end
end
