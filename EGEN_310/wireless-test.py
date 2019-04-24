import bluetooth
import time


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
    s = bluetooth.BluetoothSocket(bluetooth.RFCOMM)
    while True:
        try:
            s.connect((Address, port))
            break;
        except:
            print('Could not connect to the device')
            time.sleep(5)

    return s

#############################################################

ad = Find_RC()
print(ad)
s = Connect_RC(ad, 1)



while True:
    i = input()
    try:
        s.send(i) #Send command
    except: #reconnect if fails
        s = Connect_RC(ad, 1)
    time.sleep(1)


s.close()
quit()

#########################
#resources used for code so far
#
# https://circuitdigest.com/microcontroller-projects/using-classic-bluetooth-in-esp32-and-toogle-an-led
# https://stackoverflow.com/questions/48512695/using-pybluez-to-connect-to-already-paired-bluetooth-device
#########################
