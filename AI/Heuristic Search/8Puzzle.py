from Agent import Agent
from queue import *
import time

init = [[1,2,5],[3,4,0],[6,7,8]]
goal = [[0,1,2],[3,4,5],[6,7,8]]

Pos_0 = (1,2)
agent = Agent(init,Pos_0)
Childs = []
stack = FILOQueue()
Expored = []
Expored.append(agent.Table)

for n in agent.child():
	if n[0] not in Childs and n[0] not in Expored:
		Childs.append(n[0])
		stack.add(n[0],n[1])


while len(Childs) != 0:
	agent.display()
	agent.Table = stack.get().data
	Childs.remove(agent.Table)
	agent.count()
	Expored.append(agent.Table)
	agent.walk()
	print ""

	if agent.Table == goal:
		break
	for n in agent.child():
		if n[0] not in Childs and n[0] not in Expored:
			Childs.append(n[0])
			stack.add(n[0],n[1])

	time.sleep(0.5)

agent.display()
#print agent.step