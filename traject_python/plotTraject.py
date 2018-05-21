from matplotlib import pyplot as plt

def plotTraj(Path):
	K = len(Path) #numofsubtraject

	for K in range(K):
		t_i = Path[k].ti 
		T = Path[k].t 
		c = Path[k].coef
		time = np.arange(t_i,(t_i+T),0.01)
		for i in range(6):
			q = []
			for t in time:
				tau = t-t_i
				q_t = c[i][0] + c[i][1]*tau + c[i][2]*tau**2 + c[i][3]*tau**3
				q.append(q_t)

			plt.subplot(1,6,i+1)
            plt.plot(time,q)
            
	plt.show()


