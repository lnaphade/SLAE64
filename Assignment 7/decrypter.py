# !/usr/bin/env python2
# File name: decrypter.py
# Author: SLAE64-14209

from Crypto.Cipher import AES

offset = 10

data = ("\xa5\x48\x6d\xf6\xe8\x14\x2a\xab\x17\xbe\x52\xfc\xa8\x32\xa9\xc2\x4b\xd6\xba\xe7\x82\x1a\xa0\x60\xf9\x64\xab\xbe\x2f\xfc\xde\xae\x98\xd8\xef\x98\x60\x58\x3f\x9c\xdb\x8f\x32\xdd\x32\x8f\x29\xce\x04\xe5\xfe\xd6\x20\x6d\x50\x20\x9b\x40\xeb\x7f\x04\x68\xc2\x2b\x98\xf1\x90\x33\xf3\xea\xe1\xff\x7e\xff\xf0\xf9\x49\x1a\x2a\x32\x21\x85\x21\xe7\x2c\xb3\x7f\xf8\x86\x99\x8b\x70\xb8\x99\x0e\xdf")

cipher = AES.new('MY_PASSWORD12345', AES.MODE_CBC, '1234567890123456')

h = cipher.decrypt(data)
decoded = ""
for x in bytearray(h):
	decoded += '\\x'
	enc = '%02x' % (x & 0xff)
	decoded += enc	
	
print decoded[0:-offset*4]