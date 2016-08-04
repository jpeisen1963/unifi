#!/usr/bin/python
#
# ec - a.k.a. "edge_config"
#
# A hacky little script which converts the output of configure-mode's
# show command into one-liners with an optional prefix.
#
# Usage:
#    ec <optional prefix>
#
#    The "optional prefix" is usually the same as the show command,
#    replacing "set" for "show".  This way you will generate a list
#    of commands to execute to get the same settings.  For example:
#
#    USG# show interfaces ethernet eth0 dhcpv6-pd \
#     | ec set interfaces ethernet eth0 dhcpv6-pd
#    set interfaces ethernet eth0 dhcpv6-pd pd 0 interface eth1 prefix-id :0
#    set interfaces ethernet eth0 dhcpv6-pd pd 0 prefix-length 64
#    set interfaces ethernet eth0 dhcpv6-pd rapid-commit enable
#
# 
import fileinput
import sys

base_prefix = []
prefixes = []

if len(sys.argv) > 1:
  base_prefix = sys.argv[1:]
  del sys.argv[1:]

for line in fileinput.input():
  words = line.strip().split()
  if not words:
    continue
  if words[-1] == '{':
    if base_prefix and words[0] == base_prefix[-1]:
      del words[0]
    prefixes.append(' '.join(words[0:-1]))
  elif len(words) == 1 and words[0] == '}':
    if prefixes:
      del prefixes[-1]
  else:
    print '%s' % ' '.join(base_prefix + prefixes + words)
