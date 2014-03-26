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

require './lcd-util.rb'

line1 = ARGV[0] || "Hello World!"
line2 = ARGV[1]
write_lcd(line1, line2)

puts "Check the LCD for this message: #{line1} / #{line2}"
