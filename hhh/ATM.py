'''import pyqrcode
qr=pyqrcode.create('Ahmed issa')
qr.png('test1.png',scale=8)
'''
'''
from pyzbar.pyzbar import decode
from PIL import Image
d=decode(Image.open('test1.png'))
print(d[0].data.decode('ascii'))
'''
import cv2

import numpy as np
from pyzbar.pyzbar import decode
img=cv2.imread('test1.png')
code=decode(img)
print(code)