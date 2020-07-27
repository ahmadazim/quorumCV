from cv2 import cv2
import numpy as np 

def ResizeWithAspectRatio(image, width=None, height=None, inter=cv2.INTER_AREA):
    dim = None
    (h, w) = image.shape[:2]
    if width is None and height is None:
        return image
    if width is None:
        r = height / float(h)
        dim = (int(w * r), height)
    else:
        r = width / float(w)
        dim = (width, int(h * r))
    return cv2.resize(image, dim, interpolation=inter)

img = cv2.imread("/Users/ahmadazim/Documents/Research/Maryam QS Exp/Pics/Trial_2_6TT/time_3180/IMG_8989.JPG", 0)
img = ResizeWithAspectRatio(img, width=500)
cv2.imshow("Original", img)

ret, thresh_basic = cv2.threshold(img, 70, 255, cv2.THRESH_BINARY)
cv2.imshow("Basic Binary", thresh_basic)

thresh_adapt = cv2.adaptiveThreshold(img, 255, cv2.ADAPTIVE_THRESH_GAUSSIAN_C, cv2.THRESH_BINARY, 115, 1)
cv2.imshow("Adaptive Threshold", thresh_adapt)

ret_otsu,thresh_otsu = cv2.threshold(img,0,255,cv2.THRESH_BINARY+cv2.THRESH_OTSU)
cv2.imshow("Otsu Threshold", thresh_otsu)

cv2.waitKey(0)
cv2.destroyAllWindows()
