from Agent import Agent
from World import World

w = World(400, 400, 40)
end = (7,8)
agent = Agent(w, 0, 0, end)    
visited = [(0,0)]

neighbors = agent.neighbor()
track = {}
for n in agent.neighbor():
    if n not in visited and n not in neighbors :
        track[n] = (agent.pos_x,agent.pos_y)
        neighbors.append(n)

'''
w = World(300, 300, 100)
agent = Agent(w, 0, 0, 0)   

track = {}
for i in [(1,0),(0,1)]:
	track[i] = (agent.pos_x,agent.pos_y)

end = (0,1)
path = end

ans = []
while path != (0,0):
	ans.append(path)
	path = track[path]
print ans'''
'''
x = Node(1,1)
PriQueue = PriorityQueue(x)
PriQueue.add(Node(2,3))
PriQueue.add(Node(3,4))
PriQueue.add(Node(4,1))
PriQueue.add(Node(5,5))
PriQueue.add(Node(6,4))
PriQueue.add(Node(7,0))
PriQueue.add(Node(8,0))
PriQueue.add(Node(9,5))
PriQueue.add(Node(7,10))'''
'''

while PriQueue.count > 0:
	print PriQueue.get().data'''