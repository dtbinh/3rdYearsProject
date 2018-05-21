from Agent import Agent
from World import World
import pygame
import math
import heapq

#---------------------------------- Set up screen -----------------------------------------

print ("Setting up screen")
width = 400
height = 400
cell_size = 40                                                #Change this to change grid size
screen = pygame.display.set_mode((width, height))
screen.fill((255, 255, 255))

running  = 1

for i in range(1, int(math.floor(width / cell_size) + 1)):
    pygame.draw.line(screen, (0, 0, 0), (i * cell_size, 0), (i * cell_size, height))
    pygame.display.flip()

for i in range(1, int(math.floor(height / cell_size) + 1)):
    pygame.draw.line(screen, (0, 0, 0), (0, i * cell_size), (width, i * cell_size))
    pygame.display.flip()


#---------------------------------- Set up World ------------------------------------------
print ("Conjuring the Matrix")

end = (8,7)                                                        # Goal State

w = World(width, height, cell_size)
wall_pos = w.random_wall(40)  
#wall_pos = []                                      # Percentage of Walls in Grid

for i in wall_pos:
    if i == end:
        wall_pos.remove(end)


#---------------------------------- Simulation --------------------------------------------
print wall_pos
print ("Activating the Matrix")

#---------------------------------- Setting Up the World ----------------------------------

track = {}
limit = 0
agent = Agent(w, 0, 0, 0)                                              # State State
neighbors = agent.neighbor()
visited = [(0,0)]
current = (agent.pos_x,agent.pos_y)


#---------------------------------- Drawing Walls------------------------------------------

for wall in wall_pos:
    w.draw_rec(screen, wall, pygame.Color(0, 0, 0))
w.draw_rec(screen, end, pygame.Color(0, 255, 0))

#---------------------------------- Searching ---------------------------------------------
cc =[]

while True:
    agent.limit = limit  

    if agent.limit >= w.width:
        print "Failure"
        break

    for n in agent.neighbor():
        if n not in visited and n not in neighbors and n not in wall_pos:
            track[n] = (agent.pos_x,agent.pos_y)
            neighbors.append(n)

    while len(neighbors) != 0:

        ################################## Pygame Stuff #######################################
        event = pygame.event.poll()
        if event.type == pygame.QUIT:
            running = 0
        w.draw_rec(screen, (agent.pos_x, agent.pos_y), pygame.Color(255, 0, 0))
        w.draw_rec(screen, current, pygame.Color(100, 100, 100))
        #######################################################################################

        current = neighbors.pop(0)
        visited.append(current)
        agent.walk(current)

        ################################## Pygame Stuff #######################################
        w.draw_rec(screen, current, pygame.Color(0, 255, 255))
        pygame.display.flip()
        #######################################################################################

        if current == end:
            break
        for n in agent.neighbor():
            if n not in visited and n not in neighbors and n not in wall_pos:
                track[n] = (agent.pos_x,agent.pos_y)
                cc.append(n)
                ################################## Pygame Stuff ###############################
                if n != end:
                    w.draw_rec(screen, n, pygame.Color(175, 175, 175))
                else:
                    w.draw_rec(screen, n, pygame.Color(0, 175, 0))
                ###############################################################################

        for m in neighbors:
            cc.append(m)
        neighbors = cc
        cc = []
        pygame.time.delay(500)

    if current == end:
            break

    limit += 1
    agent.walk((0,0))
    neighbors = []
    visited = [(0,0)]
    current = (agent.pos_x,agent.pos_y)
    track = {}
    ################################## Pygame Stuff ###############################
    for i in range(limit+1):
        for j in range(limit+1):
                if (i,j) not in wall_pos and (i,j) not in end:
                    w.draw_rec(screen, (i,j), pygame.Color(255, 255, 255))
    ###############################################################################
    pygame.time.delay(500)

if current == end:
    key = end
    path = []
    while True:
        path.append(key)
        if key == (0,0):
            break
        key = track[key]
    path = path[::-1]
    ################################## Pygame Stuff ###############################
    for i in range(limit+1):
        for j in range(limit+1):
                if (i,j) not in wall_pos and (i,j) not in end:
                    w.draw_rec(screen, (i,j), pygame.Color(255, 255, 255))
    pygame.time.delay(500)
    for n in path:
        print(n)
        w.draw_rec(screen, n, pygame.Color(100, 50, 80))
        pygame.time.delay(200)
    ###############################################################################
    
pygame.time.delay(8000)                                 #Delay after completion