import cv2
import numpy as np
from matplotlib import pyplot as plt

img1 = cv2.imread('bar.jpg',0)
img2 = cv2.imread('trans.jpg',0)
img3 = cv2.imread('rotage.jpg',0)

f1 = np.fft.fft2(img1)
fshift1 = np.fft.fftshift(f1)
magnitude_spectrum1 = 20*np.log(np.abs(fshift1))

f2 = np.fft.fft2(img2)
fshift2 = np.fft.fftshift(f2)
magnitude_spectrum2 = 20*np.log(np.abs(fshift2))

f = np.fft.fft2(img3)
fshift3 = np.fft.fftshift(f)
magnitude_spectrum3 = 20*np.log(np.abs(fshift3))

mag = magnitude_spectrum1 - magnitude_spectrum2
plt.subplot(231),plt.imshow(img1, cmap = 'gray')
plt.title('Input Image'), plt.xticks([]), plt.yticks([])
plt.subplot(234),plt.imshow(magnitude_spectrum1, cmap = 'gray')
plt.title('Magnitude Spectrum'), plt.xticks([]), plt.yticks([])

plt.subplot(232),plt.imshow(img2, cmap = 'gray')
plt.title('Input Image'), plt.xticks([]), plt.yticks([])
plt.subplot(235),plt.imshow(magnitude_spectrum2, cmap = 'gray')
plt.title('Magnitude Spectrum'), plt.xticks([]), plt.yticks([])

plt.subplot(233),plt.imshow(img3, cmap = 'gray')
plt.title('Input Image'), plt.xticks([]), plt.yticks([])
plt.subplot(236),plt.imshow(mag, cmap = 'gray')
plt.title('Magnitude Spectrum'), plt.xticks([]), plt.yticks([])


plt.show()
