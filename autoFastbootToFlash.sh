#!/bin/bash
# this sh is for auto flash build with fastboot mode#
function check_fastboot_connect
	{
	DeviceCount=`fastboot devices | wc -l`
#	echo $DeviceCount
    if [ $DeviceCount -eq "1" ]
        then
        echo "Have one device connected fastboot"
#	break;
	else 
	exit 1
    fi
	}

function flash_command
    {
  fastboot oem format | tee flash_result_log.txt
	fastboot flash MLO BSP/MLO.raw | tee -a flash_result_log.txt
	fastboot flash uboot BSP/u-boot.img | tee -a flash_result_log.txt
	fastboot flash dtbA BSP/dtb.img | tee -a flash_result_log.txt
	fastboot flash kernelA BSP/zImage | tee -a flash_result_log.txt
	fastboot flash systemA system.img | tee -a flash_result_log.txt
	fastboot flash recoveryA recovery.img | tee -a flash_result_log.txt
	fastboot flash dtbB BSP/dtb.img | tee -a flash_result_log.txt
	fastboot flash kernelB BSP/zImage | tee -a flash_result_log.txt
	fastboot flash systemB system.img | tee -a flash_result_log.txt
	fastboot flash recoveryB recovery.img | tee -a flash_result_log.txt
	fastboot flash cache cache.img | tee -a flash_result_log.txt
	fastboot flash data data.img | tee -a flash_result_log.txt
	fastboot flash map map.img | tee -a flash_result_log.txt
	fastboot flash keyinfo keyinfo.img | tee -a flash_result_log.txt
	fastboot flash private private.img | tee -a flash_result_log.txt
	fastboot flash speech speech.img | tee -a flash_result_log.txt
	fastboot reboot
    }

function devices_list
	{
	adb devices | grep "device$" | awk '{print $1}' > device_list.txt 
	if [ -s device_list.txt ]
		then
			echo ""
		else 
			echo "No device connect adb"
			exit 1	
	fi
	}


function check_flash_build_result
	{
	if [ `cat flash_result_log.txt | grep "OKEY" | wc -l` -eq "16" ]
	  then 
	  echo "Flash build PASS"
	  else  
	  exit 1
	fi
	}

function main_function 
	{
	devices_list;
	echo "checkpoint1"
	if [ $? -eq "0" ]
	then
		while read device_id
		do 

		adb -s $device_id reboot fastboot -f
		check_fastboot_connect;
		echo "checkpoint2"
#		flash_command;
		check_flash_build_result;
		done < device_list.txt
	fi
	}


fold_name=`date +%Y%m%d%H%M`
mkdir $fold_name
cd $fold_name
main_function;
rm device_list.txt


