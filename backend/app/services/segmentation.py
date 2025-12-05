import cv2
import numpy as np

def otsu_threshold(img: np.ndarray) -> np.ndarray:
    """Phân ngưỡng Otsu"""
    gray = img if len(img.shape) == 2 else cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
    _, thresh = cv2.threshold(gray, 0, 255, cv2.THRESH_BINARY + cv2.THRESH_OTSU)
    return thresh

def adaptive_threshold(img: np.ndarray, block_size: int = 11, c: int = 2) -> np.ndarray:
    """Phân ngưỡng thích ứng"""
    gray = img if len(img.shape) == 2 else cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
    block_size = block_size if block_size % 2 == 1 else block_size + 1
    return cv2.adaptiveThreshold(gray, 255, cv2.ADAPTIVE_THRESH_GAUSSIAN_C, cv2.THRESH_BINARY, block_size, c)

def canny_edge(img: np.ndarray, low: int = 50, high: int = 150) -> np.ndarray:
    """Phát hiện cạnh Canny"""
    gray = img if len(img.shape) == 2 else cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
    return cv2.Canny(gray, low, high)

def pca_compression(img: np.ndarray, n_components: int = 50) -> np.ndarray:
    """Nén ảnh bằng PCA"""
    gray = img if len(img.shape) == 2 else cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
    
    # Chuẩn hóa
    mean = np.mean(gray, axis=0)
    centered = gray - mean
    
    # SVD
    U, S, Vt = np.linalg.svd(centered, full_matrices=False)
    
    # Giữ lại n_components
    n_components = min(n_components, len(S))
    reconstructed = U[:, :n_components] @ np.diag(S[:n_components]) @ Vt[:n_components, :]
    reconstructed = reconstructed + mean
    
    return np.clip(reconstructed, 0, 255).astype(np.uint8)

def kmeans_segmentation(img: np.ndarray, k: int = 3) -> np.ndarray:
    """Phân đoạn bằng K-means"""
    pixel_values = img.reshape((-1, 3)).astype(np.float32) if len(img.shape) == 3 else img.reshape((-1, 1)).astype(np.float32)
    
    criteria = (cv2.TERM_CRITERIA_EPS + cv2.TERM_CRITERIA_MAX_ITER, 100, 0.2)
    _, labels, centers = cv2.kmeans(pixel_values, k, None, criteria, 10, cv2.KMEANS_RANDOM_CENTERS)
    
    centers = np.uint8(centers)
    segmented = centers[labels.flatten()]
    
    return segmented.reshape(img.shape)

def unet_demo(img: np.ndarray) -> np.ndarray:
    """Demo U-Net (giả lập bằng Canny + morphology)"""
    gray = img if len(img.shape) == 2 else cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
    edges = cv2.Canny(gray, 50, 150)
    kernel = np.ones((3, 3), np.uint8)
    dilated = cv2.dilate(edges, kernel, iterations=2)
    return dilated

def deeplab_demo(img: np.ndarray) -> np.ndarray:
    """Demo DeepLab V3 (giả lập bằng K-means)"""
    return kmeans_segmentation(img, k=5)
