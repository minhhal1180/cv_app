import cv2
import numpy as np

def negative(img: np.ndarray) -> np.ndarray:
    """Tạo ảnh âm tính"""
    return 255 - img

def log_transform(img: np.ndarray, c: float = 1.0) -> np.ndarray:
    """Biến đổi log"""
    img_float = img.astype(np.float64)
    result = c * np.log1p(img_float)
    result = (result / result.max() * 255).astype(np.uint8)
    return result

def gamma_correction(img: np.ndarray, gamma: float = 1.0) -> np.ndarray:
    """Hiệu chỉnh gamma"""
    inv_gamma = 1.0 / gamma
    table = np.array([((i / 255.0) ** inv_gamma) * 255 for i in range(256)]).astype(np.uint8)
    return cv2.LUT(img, table)

def histogram_equalization(img: np.ndarray) -> np.ndarray:
    """Cân bằng histogram"""
    if len(img.shape) == 3:
        img_yuv = cv2.cvtColor(img, cv2.COLOR_BGR2YUV)
        img_yuv[:, :, 0] = cv2.equalizeHist(img_yuv[:, :, 0])
        return cv2.cvtColor(img_yuv, cv2.COLOR_YUV2BGR)
    return cv2.equalizeHist(img)

def intensity_slicing(img: np.ndarray, low: int = 100, high: int = 200) -> np.ndarray:
    """Cắt mức xám"""
    gray = img if len(img.shape) == 2 else cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
    result = np.zeros_like(gray)
    result[(gray >= low) & (gray <= high)] = 255
    return result

def bit_plane_slicing(img: np.ndarray, plane: int = 7) -> np.ndarray:
    """Tách bit plane"""
    gray = img if len(img.shape) == 2 else cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
    result = ((gray >> plane) & 1) * 255
    return result.astype(np.uint8)
