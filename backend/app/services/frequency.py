import cv2
import numpy as np

def lowpass_filter(img: np.ndarray, cutoff: int = 30) -> np.ndarray:
    """Lọc thông thấp trong miền tần số"""
    gray = img if len(img.shape) == 2 else cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
    
    dft = cv2.dft(np.float32(gray), flags=cv2.DFT_COMPLEX_OUTPUT)
    dft_shift = np.fft.fftshift(dft)
    
    rows, cols = gray.shape
    crow, ccol = rows // 2, cols // 2
    
    mask = np.zeros((rows, cols, 2), np.uint8)
    cv2.circle(mask, (ccol, crow), cutoff, (1, 1), -1)
    
    fshift = dft_shift * mask
    f_ishift = np.fft.ifftshift(fshift)
    img_back = cv2.idft(f_ishift)
    img_back = cv2.magnitude(img_back[:, :, 0], img_back[:, :, 1])
    
    return np.uint8(img_back / img_back.max() * 255)

def highpass_filter(img: np.ndarray, cutoff: int = 30) -> np.ndarray:
    """Lọc thông cao trong miền tần số"""
    gray = img if len(img.shape) == 2 else cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
    
    dft = cv2.dft(np.float32(gray), flags=cv2.DFT_COMPLEX_OUTPUT)
    dft_shift = np.fft.fftshift(dft)
    
    rows, cols = gray.shape
    crow, ccol = rows // 2, cols // 2
    
    mask = np.ones((rows, cols, 2), np.uint8)
    cv2.circle(mask, (ccol, crow), cutoff, (0, 0), -1)
    
    fshift = dft_shift * mask
    f_ishift = np.fft.ifftshift(fshift)
    img_back = cv2.idft(f_ishift)
    img_back = cv2.magnitude(img_back[:, :, 0], img_back[:, :, 1])
    
    return np.uint8(img_back / img_back.max() * 255)
