import cv2
import numpy as np
from matplotlib import pyplot as plt

img = cv2.imread('book_text.png',0)

# create element and kernel
element1 = np.ones((38,1),np.uint8)
element2 = np.ones((1,28),np.uint8)
element3 = np.ones((36,26),np.uint8)

kernel = np.ones((5,5),np.uint8)
kernel2 = np.ones((1,2),np.uint8)
kernel3 = np.ones((3,3),np.uint8)

# Opening with 38*1 kernel and Reconstruction
Opening = cv2.morphologyEx(img,cv2.MORPH_OPEN,element1)

delade = cv2.morphologyEx(Opening,cv2.MORPH_DILATE,kernel)
for i in range(50):
    delade = cv2.morphologyEx(delade,cv2.MORPH_DILATE,kernel)
    delade = cv2.bitwise_and(delade,img)

finish = cv2.bitwise_xor(delade,img)


# Opening with 1*26 kernel and Reconstruction
Opening2 = cv2.morphologyEx(finish,cv2.MORPH_OPEN,element2)


delade2 = cv2.morphologyEx(Opening2,cv2.MORPH_DILATE,kernel)

for j in range(50):
    delade2 = cv2.morphologyEx(delade2,cv2.MORPH_DILATE,kernel)
    delade2 = cv2.bitwise_and(delade2,img)

end = cv2.bitwise_xor(delade2,finish)

# make perfect 'O'
delade3 = cv2.morphologyEx(end,cv2.MORPH_DILATE,kernel2)
for k in range(5):
    delade3 = cv2.morphologyEx(delade3,cv2.MORPH_DILATE,kernel2)

# hole filling
im_floodfill = delade3.copy()
h,w = img.shape[:2]
mask = np.zeros((h+2, w+2), np.uint8)
cv2.floodFill(im_floodfill, mask, (0,0), 255)
im_floodfill = cv2.bitwise_not(im_floodfill) + delade3

# Opening with 36*26 kernel and Reconstruction
Opening3 = cv2.morphologyEx(im_floodfill,cv2.MORPH_OPEN,element3)

delade4 = cv2.morphologyEx(Opening3,cv2.MORPH_DILATE,kernel3)
for l in range(50):
    delade4 = cv2.morphologyEx(delade4,cv2.MORPH_DILATE,kernel3)
    delade4 = cv2.bitwise_and(delade4,img)

output_image = delade4

plt.subplot(221), plt.imshow(img, cmap='gray')
plt.title('Input Image'), plt.xticks([]), plt.yticks([])
plt.subplot(222), plt.imshow(finish, cmap='gray')
plt.title('Opening with 38*1 kernel'), plt.xticks([]), plt.yticks([])
plt.subplot(223), plt.imshow(end, cmap='gray')
plt.title('Opening with 1*28 kernel'), plt.xticks([]), plt.yticks([])
plt.subplot(224), plt.imshow(output_image, cmap='gray')
plt.title('Output Image'), plt.xticks([]), plt.yticks([])

plt.show()
