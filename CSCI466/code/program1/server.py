#server.py



from http.server import BaseHTTPRequestHandler, HTTPServer
from urllib.parse import urlparse
import urllib
import urllib.parse as urlparse
import sys

c = b = r = s = d = httpCode = 200
shipSunk = hit = False
responce = 'dog'

#Create custom HTTPRequestHandler class
class battleshipHandler(BaseHTTPRequestHandler):
  def do_GET(self):

    
      fileName = sys.argv[2]
      board = open(fileName, 'r')
      rows = board.readlines()
      board.close()
      
      self.send_response(200)
      self.send_header("Content-type", "text/html")
      self.end_headers()

      self.wfile.write("<html><head><title>Board</title></head><body>".encode('utf-8'))
      for i in range(0,9):
        toWrite = "<p>"+rows[i]+"</p>"
        self.wfile.write(toWrite.encode('utf-8'))

      self.wfile.write("</body></html>".encode('utf-8'))

      #print("DEBGUG: end of GET")
      return

  #handle POST command
  def do_POST(self):
    #parsing the url from client's POST command
    #print("parsing " + self.path)
    toParse = urlparse.urlparse(self.path) #url to parse

    temp = urlparse.parse_qs(toParse.query) #parsing the query
    x = temp['x']
    y = temp['y']
    x = list(map(int,x))
    y = list(map(int,y))
    xCoord = x[0]
    yCoord = y[0]
    #xCoord and yCoord are now holding the query int values for x and y

    fileName = sys.argv[2]
    global c, b, r, s, d, shipSunk, hit, httpCode, response
    responce = 'FAILURE'
    #opens a file for read
    board = open(fileName, "r")
    #an array of all the lines in said file
    rows = board.readlines()

    board.close

    try:
        checkRow = rows[yCoord-1] #add the number to skip the html

        space = checkRow[xCoord-1] #for coords 1-10 x


        #Checks for a hit
        hit = False
        if space != '_' and space != 'O' and space != 'X':
            if space == 'C':
                c += 1
            elif space == 'B':
                b += 1
            elif space == 'R':
                r += 1
            elif space == 'S':
                s += 1
            elif space == 'D':
                d += 1
            #register as a hit
            space = 'X'
            hit = True
            http = 200
        else:
            if space == '_':
                space = 'O'
                http = 200
            else:
                httpCode = 410


        #Checking to see if a shit has been sunked
        if c == 5:
            c += 1
            shipSunk = True
        if b == 4:
            b += 1
            shipSunk = True
        if s == 3:
            s += 1
            shipSunk = True
        if r == 3:
            r += 1
            shipSunk = True
        if d == 2:
            d += 1
            shipSunk = True

        #get the responce message
        responce = 'hit=0'
        if shipSunk:
            responce = 'hit=1&sunk='+checkRow[xCoord-1]
        elif hit:
            responce = 'hit=1'

            #This will give an error on edges
        checkRow = checkRow[0:xCoord-1] + space + checkRow[xCoord:len(checkRow)]
        rows[yCoord-1] = checkRow #new file ready

        #Putting the new lines into the file, Probably could use another way
        newBoard = open(fileName, 'w')
        newBoard.writelines(rows)
        newBoard.close()
    #Deals with out of bounds errors
    except IndexError as err:
        httpCode = 404
    except UnboundLocalError as err:
        httpCode = 404

    self.send_response(httpCode, responce)
    self.end_headers()
    print("response sent")
    
    return



def run():
    while len(sys.argv) == 3:
        print('http server is starting...')
        server_address = ('127.0.0.1', int(sys.argv[1])) #ip and port of server
        server = HTTPServer(server_address, battleshipHandler)
        print('http server is running...')
        server.serve_forever()
    if len(sys.argv) != 3:
        print('Server unable to start, please enter in correct port number and your board')
run()
