import cv2
import numpy as np
import math

img = cv2.imread('image1.jpg', 0)

res = cv2.resize(img, None, fx=0.36, fy=0.64, interpolation=cv2.INTER_CUBIC)
row, col = res.shape

cv2.imshow('frame', res)
cv2.imwrite('original.jpg',res)
# image negatives
'''
for x in range(row):
    for y in range(col):
        res[x][y] = 255-res[x][y]'''
# /////////////////////////////////////////////////////////////////

# log transformation
r = 2  # range
c = int(255 / 7 * r)

for x in range(row):
    for y in range(col):
        res[x][y] = c * int(math.log(1 + res[x][y], r))

# /////////////////////////////////////////////////////////////////

cv2.imshow('frame2', res)
cv2.imwrite('trans.jpg',res)
cv2.waitKey(0)
cv2.destroyAllWindows()
