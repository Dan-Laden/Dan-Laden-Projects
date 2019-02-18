import http.client
import sys

def fire(x,y):
       print("Firing on coordinates: ("+str(xCoord)+","+str(yCoord)+")")
       enemyServer.request("POST" , "http://localhost:8000/own_board.html?x="+str(x)+"&y="+str(y))

#Pre-game setup
print("")
print("")
print("-----------------------------------------")
print("")
#create a connection to both client and opponents server
myServer = http.client.HTTPConnection('127.0.0.1',8000)

enemyIP = sys.argv[1]
enemyPort = int(sys.argv[2])
xCoord = int(sys.argv[3])
yCoord = int(sys.argv[4])
enemyServer = http.client.HTTPConnection(enemyIP,enemyPort)

#myServer.connect()
enemyServer.connect()

#send fire command to myserver
fire(xCoord,yCoord)

#print("DEBUG: waiting on response")

fireResp = enemyServer.getresponse()
       
#print("DEBUG: after response")
#print(fireResp.status)
#print(fireResp.reason)

if(fireResp.reason =="hit=1"):     #check for hit
       print("It's a HIT!")
       print("")
       #update view of opponents board
       if(len(fireResp.reason) >= 6): #check for sunk ship
              print("It's a HIT, you have sunk a ship!")
              print("")
elif(fireResp.reason =="hit=0"):
       print("")
       print("You missed. Better luck next turn.")
       print("")
if(fireResp.status == 404):
       print("Those coordinates are out of bounds")

#Show Boards
print("----Enemy Board can be opened at:")
print("http://localhost:"+str(enemyPort)+"/opponent_board.html")
print("")
print("----Your Board can be opened at:")
print("http://localhost:9000/board.html")
    
#myServer.close()
enemyServer.close()   #close server for next fire
