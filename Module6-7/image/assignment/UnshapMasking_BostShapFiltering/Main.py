import cv2
import numpy as np
from matplotlib import pyplot as plt

img = cv2.imread("Pokemon.jpg",1)

# convert BGR to RGB
img = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)

# Blurred
kernel = np.ones((10, 10), np.float32)/100
dst = cv2.filter2D(img, -1, kernel)

# Subtract
g_mask = cv2.subtract(img, dst)  # img + dst

# add mask
k1 = 1  # unSharp
k2 = 5  # boost sharp
g_mask1 = cv2.add(img, k1*g_mask)  # img + k1*g_mask
g_mask2 = cv2.add(img, k2*g_mask)  # img + k2*g_mask

# plot
plt.subplot(221), plt.imshow(img), plt.title('Original')
plt.xticks([]), plt.yticks([])
plt.subplot(222), plt.imshow(g_mask), plt.title('subtract')
plt.xticks([]), plt.yticks([])
plt.subplot(223), plt.imshow(g_mask1), plt.title('unSharp')
plt.xticks([]), plt.yticks([])
plt.subplot(224), plt.imshow(g_mask2), plt.title('boostSharp')
plt.xticks([]), plt.yticks([])
plt.show()

# save
cv2.imwrite("unSharp.jpg", cv2.cvtColor(g_mask1, cv2.COLOR_RGB2BGR))
cv2.imwrite("boostSharp(k=5).jpg", cv2.cvtColor(g_mask2, cv2.COLOR_RGB2BGR))
