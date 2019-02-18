#!/usr/bin/env python3

import random

def main():

    sizes = [ 5, 8, 10 ]

    for size in sizes:
        filename = "maze"+str(size)+".txt"

        with open(filename, "w") as output:
            maze = [ [ '_' for _ in range(0, size) ] for _ in range(0, size) ]

            for row in range(1, size):
                for col in range(1, size):
                    if random.randrange(100) <= 20:
                        maze[row][col] = 'P'

            wumpus_placed = False
            gold_placed   = False

            def place(object):
                placed = False

                while not placed:
                    row = random.randrange(1, size)
                    col = random.randrange(1, size)

                    if maze[row][col] == '_':
                        placed = True
                        maze[row][col] = object

            place('W') # Place the Wumpus
            place('G') # Place the gold

            for row in range(0, size):
                print(" ".join(maze[row]))
                output.write("".join(maze[row])+"\n")

if __name__ == "__main__":
    main()