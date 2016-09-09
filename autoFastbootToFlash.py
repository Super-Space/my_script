#!/usr/bin/env python

import subprocess as sp
import os
import sys
import time
#import serial

def flash_build():
	flash_command = (
		'fastboot oem format',
		'fastboot flash MLO BSP/MLO.raw',
		'fastboot flash uboot BSP/u-boot.img',
		'fastboot flash dtbA BSP/dtb.img',
		'fastboot flash kernelA BSP/zImage',
		'fastboot flash systemA system.img',
		'fastboot flash recoveryA recovery.img',
		'fastboot flash dtbB BSP/dtb.img',
		'fastboot flash kernelB BSP/zImage',
		'fastboot flash systemB system.img',
		'fastboot flash recoveryB recovery.img',
		'fastboot flash cache cache.img',
		'fastboot flash data data.img',
		'fastboot flash map map.img',
		'fastboot flash keyinfo keyinfo.img',
		'fastboot flash private private.img',
		'fastboot flash speech speech.img',
		'fastboot reboot'
	)
	sp.Popen('fastboot devices',shell=True)
	#sp.Popen('adb reboot fastboot -f', shell=True)
	time.sleep(20)
	i = 0
	length=len(flash_command)
	while(i<length):
		print (flash_command[i])
		flash_cmd=flash_command[i]
		sp.Popen(flash_cmd,shell=True)
		#print(i)
		i = i+1


def open_one_file(FileName):
	f = open(FileName)
	for line in f:
		print line





if __name__ == '__main__':
	#flash_build()
	#sp.Popen ('adb wait-for-devices',shell=True)
	#sp.call ('adb devices',shell=True)
	os.system("ls")