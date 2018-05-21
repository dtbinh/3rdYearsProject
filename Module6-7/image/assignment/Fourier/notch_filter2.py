import cv2
import numpy as np
from matplotlib import pyplot as plt

img = cv2.imread('car.png',0)
filter = cv2.imread('filter.png',0)

# Fast Fourier
f = np.fft.fft2(img)
fshift1 = np.fft.fftshift(f)  # shift img
magnitude_spectrum1 = np.log(np.abs(fshift1))  # Before remove

filtered = np.zeros(fshift1.shape,fshift1.dtype)
filtered = fshift1*filter

magnitude_spectrum2 = np.log(np.abs(filtered))

# Invert Fast Fourier
img_back = np.fft.ifft2(filtered)
img_back = np.abs(img_back)  # convert to real

# Plot
plt.subplot(221), plt.imshow(img, cmap='gray')
plt.title('Input Image'), plt.xticks([]), plt.yticks([])
plt.subplot(222), plt.imshow(magnitude_spectrum1, cmap='gray')
plt.title('Magnitude Input'), plt.xticks([]), plt.yticks([])
plt.subplot(223), plt.imshow(img_back, cmap='gray')
plt.title('Output Image'), plt.xticks([]), plt.yticks([])
plt.subplot(224), plt.imshow(magnitude_spectrum2, cmap='gray')
plt.title('Magnitude Output'), plt.xticks([]), plt.yticks([])


plt.show()
