import cv2
import numpy as np

def dilate(img: np.ndarray, ksize: int = 5) -> np.ndarray:
    """Phép giãn"""
    kernel = np.ones((ksize, ksize), np.uint8)
    return cv2.dilate(img, kernel, iterations=1)

def erode(img: np.ndarray, ksize: int = 5) -> np.ndarray:
    """Phép co"""
    kernel = np.ones((ksize, ksize), np.uint8)
    return cv2.erode(img, kernel, iterations=1)

def opening(img: np.ndarray, ksize: int = 5) -> np.ndarray:
    """Phép mở (co rồi giãn)"""
    kernel = np.ones((ksize, ksize), np.uint8)
    return cv2.morphologyEx(img, cv2.MORPH_OPEN, kernel)

def closing(img: np.ndarray, ksize: int = 5) -> np.ndarray:
    """Phép đóng (giãn rồi co)"""
    kernel = np.ones((ksize, ksize), np.uint8)
    return cv2.morphologyEx(img, cv2.MORPH_CLOSE, kernel)

def gradient(img: np.ndarray, ksize: int = 5) -> np.ndarray:
    """Gradient hình thái học"""
    kernel = np.ones((ksize, ksize), np.uint8)
    return cv2.morphologyEx(img, cv2.MORPH_GRADIENT, kernel)

def tophat(img: np.ndarray, ksize: int = 5) -> np.ndarray:
    """Top Hat transform"""
    kernel = np.ones((ksize, ksize), np.uint8)
    return cv2.morphologyEx(img, cv2.MORPH_TOPHAT, kernel)

def blackhat(img: np.ndarray, ksize: int = 5) -> np.ndarray:
    """Black Hat transform"""
    kernel = np.ones((ksize, ksize), np.uint8)
    return cv2.morphologyEx(img, cv2.MORPH_BLACKHAT, kernel)
