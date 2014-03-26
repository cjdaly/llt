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

require '/home/ubuntu/llt/examples/ruby/lcd-util.rb'

IP_LINK = 'eth0'
IP_MATCH = /inet\s+([0-9]+\.[0-9]+\.[0-9]+\.[0-9]+)/

def get_ip_addr()
  raw = `ip -f inet addr | grep #{IP_LINK}`
  ip_match = IP_MATCH.match(raw)
  return nil if ip_match.nil?
  ip_addr = ip_match.captures[0]
  return ip_addr
end

ip_addr = get_ip_addr
if (ip_addr.nil?) then
  write_lcd("check ethernet", "connection")
else
  write_lcd("ssh to IP addr", ip_addr)
end

