import numpy as np
import cv2
import math

cap = cv2.VideoCapture(0)
state = 0

while cap.isOpened():
    # Capture frame-by-frame
    ret, frame = cap.read()

    cap.set(3, 640)
    cap.set(4, 480)

    # Display the resulting frame
    gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)

    if state == 0:
        cv2.imshow('frame', frame)
    elif state == 1:
        cv2.imshow('frame', gray)

    if cv2.waitKey(1) == ord('q'):
        break
    elif cv2.waitKey(1) == ord('s'):
        if state == 0:
            cv2.imwrite('image.jpg', frame)
            break
        elif state == 1:
            row, col = gray.shape

            # image negatives
            '''
            for x in range(row):
                for y in range(col):
                    gray[x,y] = 255-gray[x,y]'''

            # log transformation
            r = 2  # range
            c = int(255 / 7 * r)
            cv2.imshow('1',gray)
            for x in range(row):
                for y in range(col):
                    gray[x, y] = c*int(math.log(1+gray[x, y], r))
            cv2.imshow('2',gray)
            cv2.imwrite('image.jpg', gray)
            break

    elif cv2.waitKey(1) == ord('g'):
        state = 1
    elif cv2.waitKey(1) == ord('b'):
        state = 0

# When everything done, release the capture
cap.release()
cv2.destroyAllWindows()
