# conda activate compVis
# conda env list

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
h, w = img.shape
cv2.imshow("Original Img", img)

binary = np.zeros([h,w,1], 'uint8')

thresh = 100 

for row in range(0, h):
    for col in range(0, w):
        if img[row][col] > thresh:
            binary[row][col] = 255

cv2.imshow("Slow Binary", binary)  

## More efficient way in openCV
ret, thresh = cv2.threshold(img, thresh, 255, cv2.THRESH_BINARY)
cv2.imshow("CV Threshold", thresh)

cv2.waitKey(0)
cv2.destroyAllWindows()

