import cv2
import numpy as np
from matplotlib import pyplot as plt


def filtering(event, x, y, flags, param):
    if event == cv2.EVENT_LBUTTONDOWN:
        cv2.circle(mag, (x, y), 10, (0, 0, 0), -1)
        cv2.circle(filter, (x, y), 10, 0, -1)

img = cv2.imread('car.png',0)

# FFT input
f = np.fft.fft2(img)
fshift = np.fft.fftshift(f)  # shift img
filter = np.ones_like(img)

magnitude_spectrum1 = 10*np.log(np.abs(fshift))  # Before remove

cv2.imwrite('mag.png',magnitude_spectrum1)
mag = cv2.imread('mag.png',0)

cv2.imshow('image', mag)
cv2.setMouseCallback('image', filtering)
while True:
    k = cv2.waitKey(10)
    if k == 27:
        break
    cv2.imshow('image', mag)

cv2.destroyAllWindows()

final = fshift*filter

magnitude_spectrum2 = 10*np.log(np.abs(final))

img_back = np.fft.ifftshift(final)
img_back = np.fft.ifft2(img_back)
img_back = np.abs(img_back)


plt.subplot(221), plt.imshow(img, cmap='gray')
plt.title('Input Image'), plt.xticks([]), plt.yticks([])
plt.subplot(222), plt.imshow(img, cmap='gray')
plt.title('Input Image'), plt.xticks([]), plt.yticks([])
plt.subplot(223), plt.imshow(img_back, cmap='gray')
plt.title('output Image'), plt.xticks([]), plt.yticks([])
plt.subplot(224), plt.imshow(img_back, cmap='gray')
plt.title('output Image'), plt.xticks([]), plt.yticks([])


plt.show()
