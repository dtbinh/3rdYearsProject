class Node:
	data = None
	next_pointer = None
	priority = None

	def __init__(self,dat,pri):
		self.data = dat
		self.priority = pri



class PriorityQueue:
	start_pointer = None
	end_pointer = None
	count = 1


	def __init__(self,node = None):
		self.start_pointer = node
		self.end_pointer = node


	def add(self,node):
		if node.priority < self.start_pointer.priority:
			node.next_pointer = self.start_pointer
			self.start_pointer = node

		elif node.priority >= self.end_pointer.priority:
			self.end_pointer.next_pointer = node
			self.end_pointer = node

		else:
			temp = self.start_pointer
			while node.priority >= temp.next_pointer.priority:
				temp = temp.next_pointer

			node.next_pointer = temp.next_pointer
			temp.next_pointer = node

		self.count += 1


	def get(self):
		temp = self.start_pointer
		self.start_pointer = temp.next_pointer
		self.count -= 1

		return temp


	def isEmpty(self):
		if count == 0:
			return True

		else:
			return False

