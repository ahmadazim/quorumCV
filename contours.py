from cv2 import cv2
import numpy as np 
import random

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

img = cv2.imread("/Users/ahmadazim/Documents/Research/Maryam QS Exp/Pics/Trial_2_6TT/time_3180/IMG_8989.JPG", 1)
img = ResizeWithAspectRatio(img, width=500)
cv2.imshow("Original", img)

gray = cv2.cvtColor(img, cv2.COLOR_RGB2GRAY)
blur = cv2.GaussianBlur(gray, (7,7), 0)
cv2.imshow("Blurred", blur)

def cleanUpImage(img, min_thresh = 5):
    ret,clean = cv2.threshold(img, min_thresh, 255, cv2.THRESH_TOZERO)
    return clean

thresh_tozero = cleanUpImage(blur, 5)
cv2.imshow("To Zero", thresh_tozero)

thresh = cv2.adaptiveThreshold(thresh_tozero, 255, cv2.ADAPTIVE_THRESH_GAUSSIAN_C, cv2.THRESH_BINARY, 205, 1)
cv2.imshow("Binary", thresh)

contours, hierarchy = cv2.findContours(thresh, cv2.RETR_TREE, cv2.CHAIN_APPROX_SIMPLE)
print(len(contours))

filtered = []
for c in contours:
    if cv2.contourArea(c) < 700 or cv2.contourArea(c) > 5000:continue
    filtered.append(c)

print(len(filtered))

objects = np.zeros(list(img.shape), 'uint8')
mask = np.zeros(objects.shape[:2], np.uint8)

for c in filtered:
    col = (random.randint(0,255), random.randint(0,255), random.randint(0,255))
    cv2.drawContours(objects, [c], -1, col, 2)
    cv2.drawContours(mask, [c], 0, 255, -1)

    M = cv2.moments(c)
    area = cv2.contourArea(c)
    p = cv2.arcLength(c, True)
    mean = cv2.mean(img, mask=mask)  # BGR format
    cx = int(M['m10']/M['m00'])

    print(cx, area, p, mean)

cv2.imshow("Contours", objects)

cv2.waitKey(0)
cv2.destroyAllWindows()