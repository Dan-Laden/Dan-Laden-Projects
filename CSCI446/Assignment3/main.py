"""
CSCI446 Assignment 3

@author Joseph Miles
@author Daniel Laden

README!

The approach I think we should take for this is this treating this like a game
of D&D. In this game, there are two agents, the Dungeon Master and the Player.
The Dungeon Master has perfect knowledge of what is happening. They know the
dimensions of the board, the placement of the pits, the placement of the
Wumpus, and the location of the gold.

The Player starts with only knowing where they are. Each turn that passes, they
can ask three questions of the Dungeon Master:
 1. Is there a breeze?
 2. Is there a stench?
 3. Is there glitter?

Based on the results, the Player will make entries into their memory (ie,
update their internal model of the board). The Player can also perform several
actions:
 1. Move
 2. Bump
 3. Shoot
 4. Grab
 5. Drop

Implementation wise, the Dungeon Master will simply be a collection of callable
functions that return true/false responses about the world based upon the
player's position. The Player will be an object that contains an internal map
of the caves, as well as it's current location (based on it's offset from
the start location). The internal map of the caves should probably be stored in
a Prolog knowledge base, but could also be stored as a 2D array and queried by
a handful of functions for useful knowledge that can be used for reasoning.
"""

# Python Standard Library Imports

# Third-party Library Imports
#   pyswip - Python-Prolog interface.
#import pyswip
import random
import time

def move(player, player_moves, invalid_moves):
    #generate random move
    direction = random.randint(0, 3)

    directions = [0, 1, 2, 3]
    while True:
        while player.direction != direction:
            player.turn_right()

        if direction in directions:
            directions.remove(direction)

        player.forward()
        new_move = [player.x, player.y]

        if new_move not in player_moves and new_move not in invalid_moves:
            return new_move
        else:
            direction = random.randint(0, 3)


        player.x = player_moves[-1][0]
        player.y = player_moves[-1][1]

        if not directions:
            return None

def is_smelly(cave, player):
    """
    Returns true if the Wumpus is in an adjacent tile to the player.

    This checks each tile to the North, East, South, and West of the player
    for the Wumpus (represented by 'W' on the board).
    """
    for offset in [ (0, -1), (1, 0), (0, 1), (-1, 0) ]:
        if player.x + offset[0] < 0 or player.x + offset[0] > len(cave)-1:
            continue

        if player.y + offset[1] < 0 or player.y + offset[1] > len(cave)-1:
            continue

        if cave[player.y + offset[1]][player.x + offset[0]] == 'W':
            return True

def is_breezy(cave, player):
    """
    Returns true if there is a pit in a tile that is adjacent to the player.

    This checks each tile to the North, East, South, and West of the player
    for a pit (represented by 'P' on the board).
    """
    for offset in [ (0, -1), (1, 0), (0, 1), (-1, 0) ]:
        if player.x + offset[0] < 0 or player.x + offset[0] > len(cave)-1:
            continue

        if player.y + offset[1] < 0 or player.y + offset[1] > len(cave)-1:
            continue

        if cave[player.y + offset[1]][player.x + offset[0]] == 'P':
            return True

def see_glitter(cave, player):
    """
    Returns true if there is gold in the player's tile.
    """
    return cave[player.y][player.x] == 'G'

def hear_scream(cave, player):
    """
    Returns true if the Wumpus has just died.

    IDK how to actually check for this...
    """
    pass

def has_fallen(cave, player):
    if cave[player.y][player.x] == 'P':
        return True

def has_been_eaten(cave, player):
    if cave[player.y][player.x] == 'W':
        return True

def gameOver(score):
    score = score - 1000
    print("Our courageous adventurer strong and willful has unfortunately fallen. With this character's death, the thread of prophecy is severed. Restore a saved game to restore the weave of fate, or persist in the doomed world you have created.")
    print("Score: "+str(score))
    quit()

class Player:
    def __init__(self, board_size):
        # The player's internal understanding of the board.
        self.board = []

        # Fill out the player's current understanding of the board with
        # '?', which we will use to denote that the tile is currently unknown
        # to be dangerous or safe.
        for _ in range(board_size):
            self.board.append([ '?' for _ in range(board_size) ])

        # The player's current position.
        self.x = 0
        self.y = 0

        # Set the current position to 'S' for safe (since no dangers are
        # allowed to spawn in the player's starting location).
        self.board[self.y][self.x] = 'S'

        """
        We use the following numbers to represent directions:
            0 = North/Up
            1 = East/Right
            2 = South/Down
            3 = West/Left

        This makes changing direction a simple matter of increments,
        decrements, and bounds checking, rather than a mess of conditionals.
        """
        self.direction = 0

        # Flags that the player can use to reason
        self.wumpus_alive = True
        self.has_gold = False

    def forward(self):
        """
        Update our position based on the direction we were facing.
        """
        if self.direction == 0 and self.y > 0:
            self.y -= 1

        elif self.direction == 1 and self.x < len(self.board[0]) - 1:
            self.x += 1

        elif self.direction == 2 and self.y < len(self.board[0]) - 1:
            self.y += 1

        elif self.direction == 3 and self.x > 0:
            self.x -= 1

    def turn_right(self):
        self.direction += 1

        # 3 (West) is the largest direction index, so if we exeed this, wrap
        # back to our smallest, which is 0 (North).
        if self.direction > 3:
            self.direction = 0

    def turn_left(self):
        self.direction -= 1

        # Just as with turn_right(), when we exceed our smallest direction
        # value (0), wrap back to our largest (3).
        if self.direction < 0:
            self.direction = 3

    def print_board(self):
        for y in self.board:
            holder = ""
            for x in y:
                holder = holder + x
            print(holder)

    def grab_gold(self):
        """
        Grabs the gold if there is any and sets that tile from having the
        gold to just being a safe tile in our internal board representation.
        We also set that the player has the gold.
        """
        if self.board[self.y][self.x] == 'G':
            self.board[self.y][self.x] == 'S'
            self.has_gold = True

    def release_gold(self):
        """
        Releases the gold if we have it and sets the tile from whatever
        it currently is (hopefully safe) to having the gold in our internal
        board representation.
        """
        if self.has_gold:
            self.board[self.y][self.x] == 'G'
            self.has_gold = False

def has_won(player):
    """
    Test to see if the player has won. Returns true if the player has the gold
    and is also at the tile (0,0).
    """
    return player.x == 0 and player.y == 0 and player.has_gold

def main():
    score = 0
    cave = []

    # Read in cave structure based on what was generated by our problem
    # generator.
    with open("maze.txt", "r") as file:
        cave = [ list(line.strip()) for line in file ]

    player = Player(board_size = len(cave[0]))

    bounds = len(cave)

    player_moves = [[0,0]]
    invalid_moves = []

    while not has_won(player):
        """
        The steps that the player must take are the following:
         1. Use all senses (call all of is_smelly(), is_breezy(),
            see_glitter(), and hear_scream())
         2. Based on any new input from those senses, update understanding of
            the board and make a decision:
             a. If the location of the Wumpus has a known location and can be
                shot, shoot it.
             b. If we know we can move in a direction without encountering the
                Wumpus or fallling into a pit, then we move there.
            ....
        """
        down = player.y+1
        up = player.y-1
        right = player.x+1
        left = player.x-1

        # General bounds check to ensure we don't check any tiles that don't
        # make any sense to check.
        if down == bounds:
            down = player.y
        if up == -1:
            up = player.y
        if right == bounds:
            right = player.x
        if left == -1:
            left = player.x

        if is_breezy(cave, player):
            # We sense a pit near by, mark all adjacent tiles that are unknown
            # to be safe with Pit.
            if player.board[down][player.x] == '?':
                player.board[down][player.x] = 'X'
            if player.board[up][player.x] == '?':
                player.board[up][player.x] = 'X'
            if player.board[player.y][right] == '?':
                player.board[player.y][right] = 'X'
            if player.board[player.y][left] == '?':
                player.board[player.y][left] = 'X'

        if is_smelly(cave, player):
            # We smell the wumpus, mark all adjacent tiles that are unknown
            # to be safe with Wumpus.
            if player.board[down][player.x] == '?':
                player.board[down][player.x] = 'X'
            if player.board[up][player.x] == '?':
                player.board[up][player.x] = 'X'
            if player.board[player.y][right] == '?':
                player.board[player.y][right] = 'X'
            if player.board[player.y][left] == '?':
                player.board[player.y][left] = 'X'

        if not is_breezy(cave, player) and not is_smelly(cave, player):
            # If we don't detect any dangers adjacent to us, retract any
            # assumptions we've made and mark all adjacent tiles as safe.
            # We also need to remove any invalid moves, or else we risk
            # getting stuck due to a tile being marked as invalid despite
            # being safe.
            if player.board[down][player.x] == 'X' or player.board[down][player.x] == '?':
                player.board[down][player.x] = 'S'
                invalid_moves = [ move for move in invalid_moves if move != [player.x, down] ]

            if player.board[up][player.x] == 'X' or player.board[up][player.x] == '?':
                player.board[up][player.x] = 'S'
                invalid_moves = [ move for move in invalid_moves if move != [player.x, up] ]

            if player.board[player.y][right] == 'X' or player.board[player.y][right] == '?':
                player.board[player.y][right] = 'S'
                invalid_moves = [ move for move in invalid_moves if move != [right, player.y] ]

            if player.board[player.y][left] == 'X' or player.board[player.y][left] == '?':
                player.board[player.y][left] = 'S'
                invalid_moves = [ move for move in invalid_moves if move != [left, player.y] ]


        if see_glitter(cave, player):
            # If we see glitter, pickup the gold and remove the gold from the
            # primary cave map.
            player.grab_gold()

        if hear_scream(cave, player):
            # Declare the wumpus dead and remove all wumpus marks from the
            # player's internal representation of the caves.
            player.wumpus_alive = False

        #move logic
        active_move = None
        while not active_move:
            holder = move(player, player_moves, invalid_moves)

            # print("Player position: "+str([player.x,player.y]))
            # print("New move: " +str(holder))
            # print("Player moves: "+str(player_moves))
            # print("Invalid moves :" +str(invalid_moves))

            # time.sleep(2)

            try:
                #check bounds
                if not -1 in holder and not bounds in holder:
                    if not holder in player_moves:
                        if player.board[player.y][player.x] == 'X':
                            if holder not in invalid_moves:
                                invalid_moves.append(holder)
                        else:
                            active_move = holder
                            break
                    else:
                        continue

                else:
                    if holder not in invalid_moves:
                        invalid_moves.append(holder)

                player.x = player_moves[-1][0]
                player.y = player_moves[-1][1]

            except:
                break

        if active_move:
            stuck = 0
            print(active_move)
            player_moves.append(active_move)
            player.board[player.y][player.x] = 'S'
            player.print_board()

            print(player.has_gold)

            score = score - 1

        else:
            try:
                del player_moves[-1]

                player.x = player_moves[-1][0]
                player.y = player_moves[-1][1]

            except:
                print("With nowhere safe left you decide to leave the cave valuing your life over the promised treasure inside.")
                print("Score: "+str(score))
                quit()

        if score <= -500:
            print("The darkness proved too much for the lonely adventurer, as the endless nights raged on and on the adventurer even lost who they were and just became another wumpus in the cave.")
            print("Score: "+str(score))
            quit()


        if has_fallen(cave, player) or has_been_eaten(cave, player):
            gameOver(score)

        if '?' not in [ c for line in player.board for c in line ]:
            break

    score = score + 1000 - len(player_moves)
    print("The victorious adventurer, treasure in hand, leaves the dark cave with his live and riches intact")
    print("Score: "+str(score))
    quit()

if __name__ == '__main__':
    main()
