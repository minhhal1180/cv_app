import cv2
import numpy as np

def add_salt_pepper_noise(img: np.ndarray, amount: float = 0.05) -> np.ndarray:
    """Thêm nhiễu muối tiêu"""
    noisy = img.copy()
    num_salt = int(amount * img.size / 2)
    num_pepper = int(amount * img.size / 2)
    
    # Salt
    coords = [np.random.randint(0, i - 1, num_salt) for i in img.shape[:2]]
    if len(img.shape) == 3:
        noisy[coords[0], coords[1], :] = 255
    else:
        noisy[coords[0], coords[1]] = 255
    
    # Pepper
    coords = [np.random.randint(0, i - 1, num_pepper) for i in img.shape[:2]]
    if len(img.shape) == 3:
        noisy[coords[0], coords[1], :] = 0
    else:
        noisy[coords[0], coords[1]] = 0
    
    return noisy

def add_gaussian_noise(img: np.ndarray, sigma: float = 25) -> np.ndarray:
    """Thêm nhiễu Gaussian"""
    noise = np.random.normal(0, sigma, img.shape).astype(np.float32)
    noisy = img.astype(np.float32) + noise
    return np.clip(noisy, 0, 255).astype(np.uint8)

def denoise_median(img: np.ndarray, ksize: int = 5) -> np.ndarray:
    """Khử nhiễu bằng lọc trung vị"""
    ksize = ksize if ksize % 2 == 1 else ksize + 1
    return cv2.medianBlur(img, ksize)

def denoise_bilateral(img: np.ndarray, d: int = 9, sigma_color: float = 75, sigma_space: float = 75) -> np.ndarray:
    """Khử nhiễu bằng bilateral filter"""
    return cv2.bilateralFilter(img, d, sigma_color, sigma_space)

def denoise_nlm(img: np.ndarray, h: float = 10) -> np.ndarray:
    """Khử nhiễu Non-local Means"""
    if len(img.shape) == 3:
        return cv2.fastNlMeansDenoisingColored(img, None, h, h, 7, 21)
    return cv2.fastNlMeansDenoising(img, None, h, 7, 21)
