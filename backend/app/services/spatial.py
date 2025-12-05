import cv2
import numpy as np

def sharpen(img: np.ndarray) -> np.ndarray:
    """Làm nét ảnh"""
    kernel = np.array([[-1, -1, -1],
                       [-1,  9, -1],
                       [-1, -1, -1]])
    return cv2.filter2D(img, -1, kernel)

def laplacian(img: np.ndarray) -> np.ndarray:
    """Bộ lọc Laplacian"""
    gray = img if len(img.shape) == 2 else cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
    lap = cv2.Laplacian(gray, cv2.CV_64F)
    return np.uint8(np.absolute(lap))

def median_filter(img: np.ndarray, ksize: int = 5) -> np.ndarray:
    """Lọc trung vị"""
    ksize = ksize if ksize % 2 == 1 else ksize + 1
    return cv2.medianBlur(img, ksize)

def mean_filter(img: np.ndarray, ksize: int = 5) -> np.ndarray:
    """Lọc trung bình"""
    return cv2.blur(img, (ksize, ksize))

def gaussian_blur(img: np.ndarray, ksize: int = 5) -> np.ndarray:
    """Làm mờ Gaussian"""
    ksize = ksize if ksize % 2 == 1 else ksize + 1
    return cv2.GaussianBlur(img, (ksize, ksize), 0)

def sobel_edge(img: np.ndarray) -> np.ndarray:
    """Phát hiện cạnh Sobel"""
    gray = img if len(img.shape) == 2 else cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
    sobelx = cv2.Sobel(gray, cv2.CV_64F, 1, 0, ksize=3)
    sobely = cv2.Sobel(gray, cv2.CV_64F, 0, 1, ksize=3)
    magnitude = np.sqrt(sobelx**2 + sobely**2)
    return np.uint8(magnitude / magnitude.max() * 255)
