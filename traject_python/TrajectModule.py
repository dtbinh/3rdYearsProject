import numpy as np
from sub_traject import *
from scipy.optimize import minimize
from matplotlib import pyplot as plt


class TrajectModule:
    sequence = []

    def __init__(self,path,v_1,v_N,v_max,a_max):
        self.sequence = self.SequenceGen(path,v_1,v_N,v_max,a_max)

    def SequenceGen(self,path,v_1,v_N,v_max,a_max):
        step = len(path)
        sequence = []
        for p_ind in range(step):
            q = path[p_ind]
            Traject = self.TrajectGen(q,v_1,v_N,v_max,a_max)
            sequence.append(Traject)

        return sequence

    def TrajectGen(self,q,v_1,v_N,v_max,a_max):
        (D, N) = q.shape
        [T,c] = self.computeT(q,v_1,v_N,v_max,a_max)
        t_i = np.cumsum(np.append(np.array([0]),T[0:N-2]))
        K = len(T)
        Traject = []
        for k in range(K):
            sub_traject_k = subtraject()
            sub_traject_k.coef = c[:,:,k]
            sub_traject_k.t_i = t_i[k]
            sub_traject_k.T = T[k]
            Traject.append(sub_traject_k)

        return Traject

    def computeT(self,q,v_1,v_N,v_max,a_max):
        (D, N) = q.shape
        T = np.zeros((N-1,))
        max = 0
        for i in range(N-1):
            for j in range(D):
               if abs(q[j][i]-q[j][i+1]) > max:
                   max = abs(q[j][i]-q[j][i+1])
            T[i] = np.sqrt(max*2/np.min(a_max)) + max/np.min(v_max)

        [v, c] = self.Computeviapointvel(T,q, v_1, v_N)
        self.plotTraj(T,q,c,v_max,a_max)
        return [T,c]

    def cubicSpline(self, q, v_1, v_N, v_max, a_max):
        (D, N) = q.shape
        fun = lambda T: sum(T)
        cons = []
        for i in range(N):
            cons.append({'fun': lambda T: self.nonlcon(T, q, v_1, v_N, v_max, a_max,i),'type': 'ineq'})
        cons = tuple(cons)
        bnds = ((0.5, 10),) * (N - 1)
        T_init = np.ones((N - 1, ))
        T = minimize(fun, T_init, method='SLSQP', bounds=bnds, constraints=cons,options={'disp':True,'maxiter':10000000})
        [v, c] = self.Computeviapointvel(T.x,q, v_1, v_N)
        self.plotTraj(T.x,q,c,v_max,a_max)
        return [T.x, c]

    def plotTraj(self,T,q,c,v_max,a_max):
        (D, N) = q.shape
        t_i = np.cumsum(np.append(np.array([0]),T[0:N-2]))

        for i in range(D):
            plt.subplot(3,D,i+1)
            plt.plot(np.append(t_i,t_i[N-2]+T[N-2]),q[i,:],'ko')

            plt.subplot(3,D,D+i+1)
            plt.plot([t_i[0],t_i[N-2]+T[N-2]],[1,1]*v_max[i],'k--')
            plt.plot([t_i[0],t_i[N-2]+T[N-2]],[-1,-1]*v_max[i],'k--')

            plt.subplot(3,D,2*D+i+1)
            plt.plot([t_i[0],t_i[N-2]+T[N-2]],[1,1]*a_max[i],'k--')
            plt.plot([t_i[0],t_i[N-2]+T[N-2]],[-1,-1]*a_max[i],'k--')

            for k in range(N-1):
                t = np.arange(t_i[k],(t_i[k]+T[k]),0.01)
                tau = t-t_i[k]
                q_t = np.matmul(np.transpose(c[i][:,k]),np.append([np.ones(tau.shape)],[tau,tau**2,tau**3],axis =0))
                qd_t = np.matmul(np.transpose(c[i][:,k]),np.append([np.zeros(tau.shape)],[np.ones(tau.shape),2*tau,3*tau**2],axis =0))
                qdd_t = np.matmul(np.transpose(c[i][:,k]),np.append([np.zeros(tau.shape)],[np.zeros(tau.shape),2*np.ones(tau.shape),6*tau],axis =0))
                plt.subplot(3,D,i+1)
                plt.plot(t,q_t)
                plt.subplot(3,D,D+i+1)
                plt.plot(t,qd_t)
                plt.subplot(3,D,2*D+i+1)
                plt.plot(t,qdd_t)
        plt.show()


    def nonlcon(self, T, q, v_1, v_N, v_max, a_max,n):
        (D, N) = q.shape
        [v, c] = self.Computeviapointvel(T, q, v_1, v_N)
        a = np.zeros((D, N))
        for i in range(D):
            a[i][0] = 2 * c[i][2][0]
            for k in range(N - 1):
                a[i][k + 1] = np.matmul(np.array([2, 6 * T[k]]), np.array([[c[i][2][k]], [c[i][3][k]]]))

        con = np.array([[v_max - v], [a_max - a], [v_max + v], [a_max + a]]).reshape(24, N)
        print('---------------------------------------------------------')
        print(con)
        return con[:, n]

    def Computeviapointvel(self, T, q, v_1, v_N):
        (D, N) = q.shape
        v = np.zeros((D, N))
        c = np.zeros((D, 4, N - 1))

        D1 = np.zeros((1, N - 2))
        D2 = np.zeros((1, N - 3))
        D3 = np.zeros((1, N - 3))
        b = np.zeros((N - 2, 1))

        if N > 3:
            for i in range(D):
                for k in range(N - 2):
                    D1[0][k] = 2 * (T[k] ** 2 * T[k + 1] + T[k] * T[k + 1] ** 2)
                    if k > 0:
                        D2[0][k - 1] = T[k - 1] ** 2 * T[k]
                        D3[0][k - 1] = T[k] * T[k + 1] ** 2

                    b[k][0] = 3 * (
                    -T[k + 1] ** 2 * q[i][k] - (T[k] ** 2 - T[k + 1] ** 2) * q[i][k + 1] + T[k] ** 2 * q[i][k + 2])
                    if k == 0:
                        b[k][0] = b[k] - T[k] * T[k + 1] ** 2 * v_1[i]
                    elif k == N - 3:
                        b[k][0] = b[k] - T[k] ** 2 * T[k + 1] * v_N[i]
                A = np.diag(D1[0]) + np.diag(D2[0], 1) + np.diag(D3[0], -1)

                v[i][0] = v_1[i]
                v[i][N - 1] = v_N[i]
                v[i][1:N - 1] = np.matmul(np.linalg.inv(A), b).reshape((N-2,))

                for k in range(N - 1):
                    c[i][0][k] = q[i][k]
                    c[i][1][k] = v[i][k]
                    c[i][2][k] = (-3 * q[i][k] + 3 * q[i][k + 1] - 2 * T[k] * v[i][k] - T[k] * v[i][k + 1]) / T[k] ** 2
                    c[i][3][k] = (2 * q[i][k] - 2 * q[i][k + 1] + T[k] * v[i][k] + T[k] * v[i][k + 1]) / T[k] ** 3
        elif N == 3:
            for i in range(D):
                v[i][0] = v_1[i]
                v[i][1] = 3 * (-T[1] ** 2 * q[i][0] - (T[0] ** 2 - T[1] ** 2) * q[i][1] + T[0] ** 2 * q[i][2]) - T[0] * \
                                                                                                                 T[
                                                                                                                     1] ** 2 * \
                                                                                                                 v_1[
                                                                                                                     i] - \
                          T[0] ** 2 * T[1] * v_N[i]
                v[i][N - 1] = v_N[i]

                for k in range(N - 1):
                    c[i][0][k] = q[i][k]
                    c[i][1][k] = v[i][k]
                    c[i][2][k] = (-3 * q[i][k] + 3 * q[i][k + 1] - 2 * T[k] * v[i][k] - T[k] * v[i][k + 1]) / T[k] ** 2
                    c[i][3][k] = (2 * q[i][k] - 2 * q[i][k + 1] + T[k] * v[i][k] + T[k] * v[i][k + 1]) / T[k] ** 3
        elif N == 2:
            for i in range(D):
                v[i][0] = v_1[i]
                v[i][1] = v_N[i]
                for k in range(N - 1):
                    c[i][0][k] = q[i][k]
                    c[i][1][k] = v[i][k]
                    c[i][2][k] = (-3 * q[i][k] + 3 * q[i][k + 1] - 2 * T[k] * v[i][k] - T[k] * v[i][k + 1]) / T[k] ** 2
                    c[i][3][k] = (2 * q[i][k] - 2 * q[i][k + 1] + T[k] * v[i][k] + T[k] * v[i][k + 1]) / T[k] ** 3
        return [v, c]
