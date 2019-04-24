import pyxhook
import os
import bluetooth
import time

global s

# function that finds the MAC address of the RC car
def Find_RC():
    needed = "ESP32" #name of the car
    while True:
        nearby_devices = bluetooth.discover_devices(lookup_names = True)

        #print("found %d devices" % len(nearby_devices))
        for addr, name in nearby_devices:
             #print(" %s - %s" % (addr, name))
             if needed in name:
                 return addr

# function that connects a bluetooth socket to the RC car for transmission
def Connect_RC(Address, port):
    sock = bluetooth.BluetoothSocket(bluetooth.RFCOMM)
    while True:
        try:
            sock.connect((Address, port))
            break;
        except:
            print('Could not connect to the device')
            time.sleep(5)

    return sock

#creating key pressing event and saving it into log file
def OnKeyPress(event):
    if "KeyboardInterrupt" == event.Key:
        quit()
    print(event.Key) #show the command being sent
    s.send(event.Key) #send to the car

#Find the MAC address
ad = Find_RC()
print(ad)
#Connect to the RC car
s = Connect_RC(ad, 1)
# create a hook manager object
new_hook = pyxhook.HookManager()
new_hook.KeyDown = OnKeyPress
# set the hook
new_hook.HookKeyboard()

try:
    new_hook.start()         # start the hook
except KeyboardInterrupt:
    quit()# User cancelled from command line.
except Exception as ex:
    # Write exceptions to the log file, for analysis later.
    msg = 'Error while catching events:\n  {}'.format(ex)
    pyxhook.print_err(msg)

new_hook.close()
s.close()

#########################
#resources used for code so far
#
#https://www.geeksforgeeks.org/design-a-keylogger-in-python/
#www.bitforestinfo.com/2017/03/how-to-create-virtual-keyboard-using.html
# https://circuitdigest.com/microcontroller-projects/using-classic-bluetooth-in-esp32-and-toogle-an-led
# https://stackoverflow.com/questions/48512695/using-pybluez-to-connect-to-already-paired-bluetooth-device
#########################
