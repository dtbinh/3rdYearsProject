import cv2
import numpy as np
import matplotlib

tiger = cv2.imread('Tiger.jpg', 1)
human = cv2.imread('Human.jpg', 1)

row = human.shape[0]
col = human.shape[1]

state = 0


def instruction():
    print "\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/"
    print "\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\n"
    print "This program is about Arithmetic and Logical Operations"
    print "There are 8 function in this program +, -, *, /, and, or, exor, reset"
    print "Press '1','2','3','4','5','6','7','8' with 'left mouse click' to use their function in sequence"
    print "Finally, press 'EXC' for exit the window\n"
    print "\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/"
    print "\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/"


def operation(event, y, x, flags, param):
    if event == cv2.EVENT_LBUTTONDOWN:

        if row + x < tiger.shape[0] and col + y < tiger.shape[1]:
            if state == 1:
                tiger[x:x + row, y:y + col] += human

            elif state == 2:
                tiger[x:x + row, y:y + col] -= human

            elif state == 3:
                tiger[x:x + row, y:y + col] *= human

            elif state == 4:
                tiger[x:x + row, y:y + col] /= (human+1)

            elif state == 5:
                tiger[x:x + row, y:y + col] = cv2.bitwise_and(tiger[x:x + row, y:y + col], human)

            elif state == 6:
                tiger[x:x + row, y:y + col] = cv2.bitwise_or(tiger[x:x + row, y:y + col], human)

            elif state == 7:
                tiger[x:x + row, y:y + col] = cv2.bitwise_xor(tiger[x:x + row, y:y + col], human)

            elif state == 8:
                x = cv2.imread('Tiger.jpg', 1)
                tiger[0:tiger.shape[0], 0:tiger.shape[1]] = x


instruction()
cv2.imshow('image', tiger)
cv2.setMouseCallback('image', operation)

while True:
    k = cv2.waitKey(10)
    if k == 27:
        break
    elif k == 49:
        state = 1
    elif k == 50:
        state = 2
    elif k == 51:
        state = 3
    elif k == 52:
        state = 4
    elif k == 53:
        state = 5
    elif k == 54:
        state = 6
    elif k == 55:
        state = 7
    elif k == 56:
        state = 8

    cv2.imshow('image', tiger)

cv2.destroyAllWindows()
