####################################
# co-author@ Daniel Laden          #
# email@ dthomasladen@gmail.com    #
# co-author@ Joseph Miles          #
# email@ josephmiles2015@gmail.com #
####################################
import time, sys, math

start_time = time.time()

def get_frontier(node, maze, explored, frontier, goal):
    '''
    Finds all neighboring nodes that are unknown and are traversible (ie, not
    '%'). Returns a list of 4-tuples that contain the destination node, the
    source (the given node), the Manhattan distance cost to go from source to
    desitination, and the Manhattan distance from destination to goal.
    '''
    tmp = list()
    known_nodes = list()

    '''
    We're only interested in unknown nodes when looking at expanding the
    frontier. Thus, we will combine the sets of explored nodes and nodes
    already on the frontier, forming the set of all known nodes.
    '''
    for layer in explored:
        known_nodes.extend([ pair[0] for pair in layer])

    known_nodes.extend([ pair[0] for pair in frontier ])

    '''
    Converting a list to set back to list ensures that we are looking only at
    unique nodes. This ensures we don't waste work by comparing against the
    same node multiple times.
    '''
    known_nodes = list(set(known_nodes))

    for y in range(node[0]-1, node[0]+2):
        for x in range(node[1]-1, node[1]+2):
            if maze[y][x] not in known_nodes and maze[y][x][2] != '%':
                tmp.append(
                    (
                        maze[y][x],
                        node,
                        abs((y-node[0]))+abs(x-node[1]),
                        abs(goal[0]-node[0])+abs(goal[1]-node[1])
                    )
                )

    return tmp

def bfs(start, goal, maze):
    '''
    Breadth First Search (BFS) implementation.
    '''

    # Initialize explored
    explored = [ [ (start, None) ] ]

    # The frontier needs to be declared so that we can use get_frontier() to
    # initialize it.
    frontier = list()

    # Initialize the frontier
    frontier = get_frontier(start, maze, explored, frontier, goal)

    # While the frontier is not empty
    while len(frontier) > 0:
        new_frontier = list()

        # Visit each node that is already on the frontier
        for pair in frontier:
            if pair[0][2] == goal[2]: # If the node is the goal, end the search.

                print(
                    'goal found, %d nodes explored (%d layers)' % (
                        len([ pair for layer in explored for pair in layer ]),
                        len(explored)
                    )
                )

                # Initialize the path with the goal node.
                path = [ pair[0], pair[1] ]

                # Set the start layer and the last node we visited
                layer = len(explored) - 1
                last_node = pair[1]

                while start not in path:
                    '''
                    Search the current layer for a pair that stores the last
                    node we found. When we've found it, append its parent node
                    to the path.
                    '''
                    for pair in explored[layer]:
                        if pair[0] == last_node:
                            path.append(pair[1])
                            last_node = pair[1]
                            break

                    layer = layer - 1

                return path

            else: # If the current node is not goal, get the node's frontier.
                new_frontier.extend(
                    get_frontier(pair[0], maze, explored, frontier, goal)
                )

        # Add frontier to explored set.
        explored.append(frontier)

        '''
        Set the frontier to the nodes in the new frontier.
        (Casting the new frontier to a set ensures that there are no
        duplicate positions, since a set can only have unique elements.)
        '''
        frontier = list(set(new_frontier))

def greedy_first(start, goal, maze):
    '''
    Greedy-First Search or Best-First Search implementation.
    '''
    path = [ start ]
    explored = [ [ (start, None, 0, math.inf) ] ]

    frontier = list()
    frontier = get_frontier(start, maze, explored, frontier, goal)
    frontier.sort(key=(lambda p: p[3])) # Sorts by increasing Manhattan distance

    cheapest_distance = math.inf

    while len(frontier) > 0:

        top = frontier.pop(0)

        if top[0][2] == goal[2]:
            print('goal found, %d nodes explored' % len(explored))

            # Explored has our path embedded in it, so we'll reverse it so that
            # we can backtrack.
            explored.reverse()

            path  = [ top[0], top[1] ]
            last_node = top[1]

            for pair in [ layer[0] for layer in explored ]:

                if start in path:
                    break

                if pair[0] == last_node:
                    path.append(pair[1])
                    last_node = pair[1]

            return path

        elif top[3] < cheapest_distance:
            explored.append([ top ])
            frontier.extend(
                get_frontier(top[0], maze, explored, frontier, goal)
            )

        else:
            frontier.append(top)

        frontier.sort(key=(lambda p: p[3]))

def dfs(start, goal, maze):
    frontier = [start]
    path = {}
    explored = []
    total_expanded = 1

    while len(frontier) > 0:
        top = frontier[len(frontier)-1]

        frontier.remove(top)
        explored.append(top)


        if top[2] == goal[2]:
            #goal reached reconstruct maze
            print("Total nodes expanded is: "+str(total_expanded))
            return reconstruct_path(path, top)

        neighbours = []
        #grab children and put them on the frontier r to left
        if maze[top[0]][top[1]+1][2] != '%':
            neighbours.append(maze[top[0]][top[1]+1])

        if maze[top[0]+1][top[1]][2] != '%':
            neighbours.append(maze[top[0]+1][top[1]])

        if maze[top[0]-1][top[1]][2] != '%':
            neighbours.append(maze[top[0]-1][top[1]])

        if maze[top[0]][top[1]-1][2] != '%':
            neighbours.append(maze[top[0]][top[1]-1])

        for neighbour in neighbours:
            if neighbour in explored:
                continue
            if neighbour not in frontier:
                total_expanded += 1
                frontier.append(neighbour)
            path[neighbour] = top



def a_star(start, goal, maze):
    frontier = [start]
    path = {}
    explored = []
    travelScore = {}
    travelScore[start] = 0
    toGoalScore = {}
    toGoalScore[start] = Manhattan(start, goal)
    total_expanded = 1
    distance = 0



    while len(frontier) > 0:
        sort_toGoalScore = sorted(toGoalScore.items(), key=lambda x: x[1])
        #print(sort_toGoalScore)
        index = 0
        while True:
            try:
                top = sort_toGoalScore[index][0]
                frontier.remove(top)
                break
            except:
                index += 1
        #print(top)

        if(top[2] == goal[2]):
            print("Total nodes expanded is: "+str(total_expanded))
            return reconstruct_path(path, top)


        explored.append(top)

        neighbours = []
        distance += 1

        #grab children and put them on the frontier r to left
        if maze[top[0]][top[1]+1][2] != '%':
            neighbours.append(maze[top[0]][top[1]+1])

        if maze[top[0]+1][top[1]][2] != '%':
            neighbours.append(maze[top[0]+1][top[1]])

        if maze[top[0]-1][top[1]][2] != '%':
            neighbours.append(maze[top[0]-1][top[1]])

        if maze[top[0]][top[1]-1][2] != '%':
            neighbours.append(maze[top[0]][top[1]-1])

        for neighbour in neighbours:
            if neighbour in explored:
                continue

            neighbourGoalScore = travelScore[top] + distance

            if neighbour not in frontier:
                total_expanded += 1
                frontier.append(neighbour)
            elif neighbourGoalScore >= travelScore[neighbour]:
                continue

            path[neighbour] = top
            travelScore[neighbour] = neighbourGoalScore
            toGoalScore[neighbour] = travelScore[neighbour] + Manhattan(neighbour, goal)


def Manhattan(node, goal):
    return (abs(node[1] - goal[1]) + abs(node[0] - goal[0]))

def reconstruct_path(path, top):
    path_back = [top]
    while top in path.keys():
        top = path[top]
        path_back.append(top)

    print("Path Length is: "+str(len(path_back)))
    return path_back

def printPath(path, mazeIn):
    for node in path:
        mazeIn[node[0]][node[1]] = '.'

    for row in mazeIn:
        print(''.join(row))

    return mazeIn
##########################################
#Main Code

# The maze, stored as a 2D array of 3-tuples that store (x, y, character)
maze = list()

# Open the maze file and unpack
with open('medium-maze.txt', 'r') as lines:
    maze = [ list(line.strip()) for line in lines ]

# Start location, a 3-tuple of (y, x, character)
start = None
# Goal location, also a 3-tuple
goal = None
# Where we store the more algorithm-friendly maze.
coord_maze = [ [ None for c in line ] for line in maze ]

'''
Perform conversion of the map and also discover where the agent is starting, as
well as what our x and y bounds are. I don't think the bounds are going to
matter much, but handy to have.
'''
for y, row in enumerate(maze):
    for x, c in enumerate(row):
        coord_maze[y][x] = (y, x, c)

        if c in ['P', 'p']:
            start = (y, x, c)

        elif c == '*':
            goal = (y, x, c)

path = dfs(start, goal, coord_maze)
printPath(path, maze)
with open('large-maze.txt', 'r') as lines:
    maze = [ list(line.strip()) for line in lines ]
path = a_star(start, goal, coord_maze)
printPath(path, maze)

print("--- %s seconds ---" % round((time.time() - start_time),2))

###############
#  #  #  #  #.#
#             #
#P            #
###############

#https://stackoverflow.com/questions/613183/how-do-i-sort-a-dictionary-by-value
#https://en.wikipedia.org/wiki/A*_search_algorithm
