class Agent:

    pos_x = 0
    pos_y = 0
    world = None
    goal = None
    cost = 0

    def __init__(self, world = None, x=0, y=0, goal=None):

        self.world = world
        self.pos_x = x
        self.pos_y = y
        self.goal = goal    


    def neighbor(self):

        neighbors = []
        self.cost += 1
        if self.pos_x != self.world.width:
            neighbors.append((self.pos_x + 1,self.pos_y,self.cost + evalution(self.pos_x,self.pos_y,self.goal)))

        if self.pos_y != self.world.width:
            neighbors.append((self.pos_x, self.pos_y + 1,self.cost + evalution(self.pos_x,self.pos_y,self.goal)))       

        if self.pos_x - 1 != -1:
            neighbors.append((self.pos_x - 1,self.pos_y,self.cost + evalution(self.pos_x,self.pos_y,self.goal)))    

        if self.pos_y - 1 != -1:
            neighbors.append((self.pos_x, self.pos_y - 1,self.cost + evalution(self.pos_x,self.pos_y,self.goal)))

        return neighbors


    def walk(self, pos):
        self.pos_x = pos[0]
        self.pos_y = pos[1]


def evalution(pos_x,pos_y,goal):
    return abs(goal[0] - pos_x) + abs(goal[1] - pos_y)
