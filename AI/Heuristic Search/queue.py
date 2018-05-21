from Node import Node

class FIFOQueue:
	start_pointer = None
	end_pointer = None
	count = 0

	def __init__(self):
		self.start_pointer = None
		self.end_pointer = None


	def add(self,n,pri):

		temp = Node(n)
		if self.start_pointer == None:
			self.start_pointer = temp
			self.end_pointer = temp
		else:
			self.end_pointer.next_pointer = temp
			self.end_pointer = temp
		self.count += 1


	def get(self):

		temp = self.start_pointer
		self.start_pointer = temp.next_pointer
		self.count -= 1
		return temp


	def isEmpty(self):

		if self.count == 0:
			return True
		else:
			return False


class FILOQueue:
	start_pointer = None
	end_pointer = None
	count = 0

	def __init__(self):
		self.start_pointer = None
		self.end_pointer = None


	def add(self,n,pri):

		temp = Node(n)
		if self.start_pointer == None:
			self.start_pointer = temp
			self.end_pointer = temp
		else:
			temp.next_pointer = self.start_pointer
			self.start_pointer = temp
		self.count += 1


	def get(self):

		temp = self.start_pointer
		self.start_pointer = temp.next_pointer
		self.count -= 1
		return temp


	def isEmpty(self):

		if self.count == 0:
			return True
		else:
			return False


class PriorityQueue:
	start_pointer = None
	end_pointer = None
	count = 0


	def __init__(self):

		self.start_pointer = None
		self.end_pointer = None	


	def add(self,n,pri):

		temp = Node(n,pri)
		if self.start_pointer == None:
			self.start_pointer = temp
			self.end_pointer = temp

		else:
			pos = self.start_pointer
			if temp.priority >= self.end_pointer.priority:
				self.end_pointer.next_pointer = temp
				self.end_pointer = temp

			elif temp.priority <= self.start_pointer.priority:
				temp.next_pointer = self.start_pointer
				self.start_pointer = temp

			else:
				while pos.next_pointer.priority < temp.priority:
					pos = pos.next_pointer
				temp.next_pointer = pos.next_pointer
				pos.next_pointer = temp
		self.count += 1


	def get(self):

		temp = self.start_pointer
		self.start_pointer = temp.next_pointer
		self.count -= 1
		return temp


	def isEmpty(self):

		if self.count == 0:
			return True
		else:
			return False


	

