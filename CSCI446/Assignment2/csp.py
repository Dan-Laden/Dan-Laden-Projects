####################################
# co-author@ Daniel Laden          #
# email@ dthomasladen@gmail.com    #
# co-author@ Joseph Miles          #
# email@ josephmiles2015@gmail.com #
####################################
import time, sys, math

start_time = time.time()

####################################
# NOTE Start of function dec

def print_puzzle(puzzle):
    print('\n'.join([ ''.join(row) for row in puzzle ]))

def get_bounds(puzzle):
    '''
    This is a procedure to get the bounds of the puzzle. It returns the puzzles
    dimension in the order of height, width
    '''
    return len(puzzle) - 1, len(puzzle[0]) - 1

def meets_constraints(puzzle, x, y):
    '''
    This checks to see if the cell with the given x and y coordinate in the
    puzzle meets the constraints of the puzzle.
    The constraints are as follows:
     1. A source/sink must have exactly one tile of the same color next to it.
     2. A cell of a specific color must have exactly two tiles of the same
        color between it's vertical and horizontal neighborhoods.
     3. If a cell is not bordered by two tiles of the same color, then it must
        have at least 2 blank tiles neighboring it. (Unless the cell is a
        source/sink, then it must have at least 1 blank tile neighboring it.)
    '''

    height, width = get_bounds(puzzle)

    cell = puzzle[y][x].lower()

    number_of_same_neighbors = 0
    number_of_blank_neighbors = 0

    for dx, dy in [ (-1, 0), (0, -1), (1, 0), (0, 1) ]:
        '''
        This loop confirms the constraints by checking each neighboring cell in
        the following order: E, N, W, S.
        We've wrapped this in a try-except block so that if the cell doesn't
        exist, we just skip it instead of crashing and burning.
        '''
        try:
            # Perform bounds checking since Python just can't say no to a
            # negative index.
            if x+dx < 0 or width < x+dx or y+dy < 0 or height < y+dy:
                continue

            if puzzle[y+dy][x+dx].lower() == cell and cell != '_':
                number_of_same_neighbors += 1

            elif puzzle[y+dy][x+dx] == '_':
                number_of_blank_neighbors += 1

        except IndexError:
            pass

    # @DEBUG
    # print('Cell (%d, %d) has %d same neighbors and %d blank neighbors' % (
    #     x, y, number_of_same_neighbors, number_of_blank_neighbors
    # ))

    '''
    We check if the cell is uppercase because source/sinks are identified by
    uppercase characters.
    '''
    if puzzle[y][x].isupper():
        return number_of_same_neighbors == 1 or number_of_blank_neighbors >= 1

    # When the cell is blank, we don't care what's around it.
    elif puzzle[y][x] == '_':
        return True

    else:
        '''
        There are two possible cases when we are looking at a non-source/sink
        cell:
         1. The cell is bordered by either exactly 2 neighbors of the same
            color or is bordered by at least 2 blank neighbors. We return true
            in this case because the cell is either consistent or can be made
            consistent later.
         2. The cell is bordered by only one neighbors of the same color and
            at least 1 blank neighbor. We return true in this case because the
            cell has the opprotunity to become consistent later.
        '''
        if number_of_same_neighbors == 2 or number_of_blank_neighbors >= 2:
            return True

        elif number_of_same_neighbors == 1 and number_of_blank_neighbors >= 1:
            return True

def brute_solver(puzzle, colors, x = 0, y = 0, assignments = 0):
    '''
    Dumbly solve the puzzle. We're going to make an assignment, check if it is
    consistent. If the assignment is consistent, then we recurse and move to
    the next cell in the puzzle. If the assignment is not consistent, we try
    colors until one is consistent or we fail to find a consistent assignment.
    If we fail to find a consistent assignment, we return false to the root
    process, which resumes where it left off.
    '''

    height, width = get_bounds(puzzle)

    if puzzle[y][x].isupper():
        if meets_constraints(puzzle, x, y):
            if x == width and y == height:
                return True, assignments

            solution_found, assignments = brute_solver(
                                            puzzle,
                                            colors,
                                            x+1 if x < width else 0,
                                            y+1 if x == width else y,
                                            assignments
                                          )

            if solution_found:
                return True, assignments

    else:
        for color in colors:
            puzzle[y][x] = color
            assignments += 1

            # @DEBUG
            # print('\nAssignment %d:' % assignments)
            # print_puzzle(puzzle)

            puzzle_is_consistent = True

            for r, row in enumerate(puzzle):
                for c, cell in enumerate(row):
                    if not meets_constraints(puzzle, c, r):
                        puzzle_is_consistent = False
                        break

                if not puzzle_is_consistent:
                    break

            if puzzle_is_consistent:
                if x == width and y == height:
                    return True, assignments

                solution_found, assignments = brute_solver(
                                                puzzle,
                                                colors,
                                                x+1 if x < width else 0,
                                                y+1 if x == width else y,
                                                assignments
                                              )

                if solution_found:
                    return True, assignments

    # We need to reset before returning back up to the root. If we don't do
    # this, we end up with the solver quiting too early.
    puzzle[y][x] = '_' if not puzzle[y][x].isupper() else puzzle[y][x]

    return False, assignments



def checkSolution(map):
    return True
#all colours connected without and problems with checkConstraits

def printPuzzle(puzzle):
    for line in puzzle:
        holder = ""
        for char in line:
            holder = holder + char

        print(holder)

    print("")


def move(puzzle, position, max_width, max_height, end_loc, restricted_moves, colour, start_loc): #(x, y) -> (y, x)
    #Setting up the possible moves
    up = position[1]-1
    right = position[0]+1
    left = position[0]-1
    down = position[1]+1

    #checking boundaries and removing known bad moves
    if left > max_width or left < 0 or "left" in restricted_moves:
        left = position[0]
    if up < 0 or "up" in restricted_moves:
        up = position[1]
    if right < 0 or right > max_width or "right" in restricted_moves:
        right = position[0]
    if down > max_height or "down" in restricted_moves:
        down = position[1]

    move = None

    #Poor Man's Greedy Search
    closestPosition = abs(position[0] - end_loc[0]) + abs(position[1] - end_loc[1])
    #Make a move in some direction
    if puzzle[up][position[0]] == "_":
        newPosition = abs(position[0] - end_loc[0]) + abs(up - end_loc[1])
        if newPosition < closestPosition:
            move = [position[0], up]
        elif not move:
            move = [position[0], up]
    elif puzzle[up][position[0]] == colour and [position[0], up] != start_loc:
        return colour
    if puzzle[position[1]][right] == "_":
        newPosition = abs(right - end_loc[0]) + abs(position[1] - end_loc[1])
        if newPosition < closestPosition:
            move = [right, position[1]]
        elif not move:
            move = [right, position[1]]
    elif puzzle[position[1]][right] == colour and [right, position[1]] != start_loc:
        return colour
    if puzzle[position[1]][left] == "_":
        newPosition = abs(left - end_loc[0]) + abs(position[1] - end_loc[1])
        if newPosition < closestPosition:
            move = [left, position[1]]
        elif not move:
            move = [left, position[1]]
    elif puzzle[position[1]][left] == colour  and [left, position[1]] != start_loc:
        return colour
    if puzzle[down][position[0]] == "_":
        newPosition = abs(position[0] - end_loc[0]) + abs(down - end_loc[1])
        if newPosition < closestPosition:
            move = [position[0], down]
        elif not move:
            move = [position[0], down]
    elif puzzle[down][position[0]] == colour and [position[0], down] != start_loc:
        return colour
    if not move : #if no move is found check for a solution and return that value
        move = checkSolution(puzzle)

    return move

def smart_solver(puzzle, colours):

    height, width = get_bounds(puzzle)

    #Get all positions of the colours
    #Dic {"color", [start_x, start_y]}
    endPositions = {}
    moveList = {}

    for colour in colours:
        start = []
        for line in puzzle:
            if colour in line and not start:
                start = [line.index(colour), puzzle.index(line)]
            elif colour in line:
                end = [line.index(colour), puzzle.index(line)]
            else:
                pass


        endPositions[colour] = end
        moveList[colour] = [start]
    #print(colourPositions)
    #step forward on all colours
    allColours = colours
    while checkSolution(puzzle):
        for colour in colours:
            position = moveList[colour][-1]

            position = move(puzzle, position, width, height, endPositions[colour], [], colour, moveList[colour][0])

            if type(position) == bool:
                if position:
                    print("no solution found")
                    return puzzle
                else:
                    print("Backtrack")
                    break
            else:
                puzzle[position[1]][position[0]] = colour.lower()
                moveList[colour].append(position)

                finished = move(puzzle, position, width, height, endPositions[colour], [], colour, moveList[colour][0])
                if type(finished) == str:
                    if finished == colour:
                        colours.remove(colour)


        printPuzzle(puzzle)


# NOTE End of function dec
####################################

####################################
# NOTE Start of main code

#Stupid solver
puzzle = []

with open('9x9maze.txt', 'r') as f:
    puzzle = [ list(line.strip()) for line in f if line.strip() ]

colors = []

for row in puzzle:
    for cell in row:
        if cell != '_' and cell not in colors:
            colors.append(cell)

colors = list(map(lambda c: c.lower(), colors))

print('Puzzle:')
print_puzzle(puzzle)

print('\nColors: '+', '.join(colors))

found_solution, assignments = brute_solver(puzzle, colors)

if found_solution:
    print('\nSolution (%d assignments made):' % assignments)
    print_puzzle(puzzle)

else:
    print('\nNo solution! (%d assignments made)' % assignments)

#smart_solver
puzzle = []

f = open('7x7maze.txt', 'r')

for line in f:
    holder = []
    for char in line:
        if char != "\n":
            holder.append(char)
        else:
            continue #\n skipped
    if holder:
        puzzle.append(holder)
    else:
        continue #nothing in list

print(puzzle)

colours = []

for row in puzzle:
    for cell in row:
        if cell != '_' and cell not in colours:
            colours.append(cell)

smart_solver(puzzle, colours)


# NOTE End of main code
####################################


####################################
# NOTE Resources used
# https://stackoverflow.com/questions/53513/how-do-i-check-if-a-list-is-empty
# https://stackoverflow.com/questions/930397/getting-the-last-element-of-a-list-in-python
# https://stackoverflow.com/questions/176918/finding-the-index-of-an-item-given-a-list-containing-it-in-python
# https://stackoverflow.com/questions/14113187/how-do-you-set-a-conditional-in-python-based-on-datatypes
#
####################################
