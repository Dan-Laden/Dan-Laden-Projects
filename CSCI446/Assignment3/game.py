import random

#read in the map

def move(loc, player_moves, invalid_moves):
    #generate random move
    direction = random.randint(0, 3)

    # 0: down
    # 1: right
    # 2: left
    # 3: up
    while True:
        if direction == 0:
            loc = [loc[0],loc[1]+1]
        elif direction == 1:
            loc = [loc[0]+1,loc[1]]
        elif direction == 2:
            loc = [loc[0]-1,loc[1]]
        elif direction == 3:
            loc = [loc[0],loc[1]-1]

        if not loc in player_moves:
            return loc
        elif loc in invalid_moves:
            direction = random.randint(0, 3)
        else:
            direction = random.randint(0, 3)


def whumpas(loc):
    if loc == [3, 1]:
        gameOver("Whumpas")

def gameOver(condition):
    print("game over")
    quit()


# Start of maincode

bounds = 4

player_moves = [[0,0]]
invalid_moves = []

stuck = 0
while True:
    active_move = None
    loop = 0
    while not active_move:
        holder = move(player_moves[-1], player_moves, invalid_moves)
        loop += 1

        #check bounds
        if not -1 in holder and not bounds in holder:
            if not holder in player_moves:
                loop = 0
                active_move = holder
            else:
                continue

        elif loop == 4:
            break
            
        else:
            stuck += 1
            invalid_moves.append(holder)
            break

    if stuck == 4:
        break

    if active_move:
        stuck = 0
        print(active_move)
        player_moves.append(active_move)
        whumpas(active_move)


print(player_moves)
