import cv2
import numpy as np
from matplotlib import pyplot as plt


img = cv2.imread('Tiger.jpg') #BGR

# by split
[B,G,R] = cv2.split(img)
img2 = cv2.merge((R,G,B))

# by opencv
img3 = cv2.cvtColor(img,cv2.COLOR_BGR2RGB)

# ////////////////////////////////////////////
kernel1 = np.ones((5,5),np.float32)/25
dst1 = cv2.filter2D(img2,-1,kernel1)

kernel2 = np.ones((10,10),np.float32)/100
dst2 = cv2.filter2D(img2,-1,kernel2)

kernel3 = np.ones((20,20),np.float32)/400
dst3 = cv2.filter2D(img2,-1,kernel3)

kernel4 = np.ones((40,40),np.float32)/1600
dst4 = cv2.filter2D(img2,-1,kernel4)

plt.subplot(232),plt.imshow(img2),plt.title('Original')
plt.xticks([]), plt.yticks([])
plt.subplot(234),plt.imshow(dst1),plt.title('5*5')
plt.xticks([]), plt.yticks([])
plt.subplot(235),plt.imshow(dst2),plt.title('10*10')
plt.xticks([]), plt.yticks([])
plt.subplot(236),plt.imshow(dst3),plt.title('20*20')
plt.xticks([]), plt.yticks([])
plt.show()
