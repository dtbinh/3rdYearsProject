from copy import deepcopy
class Agent:

	def __init__(self, Table,Pos_0):
		
		self.Table = Table
		self.x = Pos_0[0]
		self.y = Pos_0[1]
		self.step = 0

	def child(self):
		child = []

		if self.y - 1 != -1:
			child.append(switch_left(self.Table,self.x,self.y))  

		if self.x + 1 != 3:
			child.append(switch_bot(self.Table,self.x,self.y))

		if self.y + 1 != 3:
			child.append(switch_right(self.Table,self.x,self.y))
		
		if self.x - 1 != -1:
			child.append(switch_top(self.Table,self.x,self.y))

		return child


	def walk(self):

		for i in range(0,3):
			for j in range(0,3):
				if self.Table[i][j] == 0:
					self.x = i
					self.y = j
					return (i,j)


	def display(self):

		for i in range(0,3):
			for j in range(0,3):
				print '|'+str(self.Table[i][j])+'|',
			print ""

		return None


	def count(self):
		
		self.step += 1
		return None


def evaluation(table):
	cost = 0
	for x in range(3):
		for y in range(3):
			cost += abs(table[x][y]//3 - x) + abs(table[x][y]%3 - y) 

	return cost


def  switch_top(table,x,y):
	new_table = deepcopy(table)
	new_table[x][y] = table[x-1][y]
	new_table[x-1][y] = table[x][y]

	return (new_table,evaluation(new_table))


def  switch_bot(table,x,y):
	new_table = deepcopy(table)
	new_table[x][y] = table[x+1][y]
	new_table[x+1][y] = table[x][y]

	return (new_table,evaluation(new_table))


def  switch_right(table,x,y):
	new_table = deepcopy(table)
	new_table[x][y] = table[x][y+1]
	new_table[x][y+1] = table[x][y]

	return (new_table,evaluation(new_table))


def  switch_left(table,x,y):
	new_table = deepcopy(table)
	new_table[x][y] = table[x][y-1]
	new_table[x][y-1] = table[x][y]

	return (new_table,evaluation(new_table))