from queue import *
from Agent import Agent

stack = PriorityQueue()

'''for i in range(1,5):
	stack.add(i)

for j in range(1,5):
	if stack.count != 0:
		print stack.start_pointer.data,stack.get().data



stack.add({1:2,2:3})

print stack.start_pointer.data

print stack.get().data
print stack.isEmpty()

print None<5'''

'''stack.add(1,1)
stack.add(2,2)
stack.add(3,3)
stack.add(4,4)
stack.add(5,5)
stack.add(6,6)
stack.add(7,7)
stack.add(8,8)
stack.add(9,9)
stack.add(92,5)
stack.add(11,1)

print ""
while stack.start_pointer != None:
	x = stack.get()
	print x.data , x.priority'''

goal = [[4,1,2],[3,0,5],[6,7,8]]
x = Agent(goal,(1,1))
print x.child()

y = ([[4,1,2],[3,0,5],[6,7,8]],1)
print y[0]