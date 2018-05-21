import cv2
import numpy as np
from matplotlib import pyplot as plt

img = cv2.imread('car.png',1)

# Fast Fourier
f = np.fft.fft2(cv2.cvtColor(img,cv2.COLOR_BGR2GRAY))
fshift1 = np.fft.fftshift(f)  # shift img

magnitude_spectrum1 = np.log(np.abs(fshift1))  # Before remove

# remove notch
row, col = fshift1.shape
crow, ccol = row/2, col/2  # center point

for i in range(row):
    for j in range(col):
        if (i < crow-90 or i > crow + 90) or (j < ccol-90 or j > ccol + 90):  # keep only in 180*180 square
            fshift1[i][j] = 1

magnitude_spectrum2 = np.log(np.abs(fshift1))  # After remove
f_ishift = np.fft.ifftshift(fshift1)  # shift back

# Invert Fast Fourier
img_back = np.fft.ifft2(f_ishift)
img_back = np.abs(img_back)  # convert to real

laplacian = cv2.Laplacian(img_back, cv2.CV_64F)  # find edge
img_back = cv2.add(img_back, laplacian)  # add edge for sharpening

# Plot
plt.subplot(141), plt.imshow(img, cmap='gray')
plt.title('Input Image'), plt.xticks([]), plt.yticks([])
plt.subplot(142),plt.imshow(magnitude_spectrum1, cmap = 'gray')
plt.title('Magnitude Spectrum1'), plt.xticks([]), plt.yticks([])
plt.subplot(143), plt.imshow(img_back, cmap='gray')
plt.title('output image'), plt.xticks([]), plt.yticks([])
plt.subplot(144),plt.imshow(magnitude_spectrum2, cmap = 'gray')
plt.title('magnitude spectrum2'), plt.xticks([]), plt.yticks([])

plt.show()
