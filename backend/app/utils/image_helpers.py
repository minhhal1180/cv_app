import cv2
import numpy as np
import base64
from io import BytesIO
from PIL import Image

def decode_image(file_bytes: bytes) -> np.ndarray:
    """Decode bytes to OpenCV image"""
    nparr = np.frombuffer(file_bytes, np.uint8)
    img = cv2.imdecode(nparr, cv2.IMREAD_COLOR)
    return img

def encode_image(img: np.ndarray) -> str:
    """Encode OpenCV image to base64 string"""
    _, buffer = cv2.imencode('.png', img)
    return base64.b64encode(buffer).decode('utf-8')

def to_grayscale(img: np.ndarray) -> np.ndarray:
    """Convert to grayscale if needed"""
    if len(img.shape) == 3:
        return cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
    return img
