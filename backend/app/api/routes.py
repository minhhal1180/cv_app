from fastapi import APIRouter, UploadFile, File, Form
from typing import Optional
from app.utils.image_helpers import decode_image, encode_image
from app.services import intensity, spatial, frequency, morphology, restoration, segmentation

router = APIRouter()

# ===== INTENSITY TRANSFORMS =====
@router.post("/negative")
async def api_negative(file: UploadFile = File(...)):
    img = decode_image(await file.read())
    result = intensity.negative(img)
    return {"image": encode_image(result)}

@router.post("/log-transform")
async def api_log_transform(file: UploadFile = File(...), c: float = Form(1.0)):
    img = decode_image(await file.read())
    result = intensity.log_transform(img, c)
    return {"image": encode_image(result)}

@router.post("/gamma")
async def api_gamma(file: UploadFile = File(...), gamma: float = Form(1.0)):
    img = decode_image(await file.read())
    result = intensity.gamma_correction(img, gamma)
    return {"image": encode_image(result)}

@router.post("/histogram-eq")
async def api_histogram_eq(file: UploadFile = File(...)):
    img = decode_image(await file.read())
    result = intensity.histogram_equalization(img)
    return {"image": encode_image(result)}

@router.post("/intensity-slice")
async def api_intensity_slice(file: UploadFile = File(...), low: int = Form(100), high: int = Form(200)):
    img = decode_image(await file.read())
    result = intensity.intensity_slicing(img, low, high)
    return {"image": encode_image(result)}

@router.post("/bit-plane")
async def api_bit_plane(file: UploadFile = File(...), plane: int = Form(7)):
    img = decode_image(await file.read())
    result = intensity.bit_plane_slicing(img, plane)
    return {"image": encode_image(result)}

# ===== SPATIAL FILTERS =====
@router.post("/sharpen")
async def api_sharpen(file: UploadFile = File(...)):
    img = decode_image(await file.read())
    result = spatial.sharpen(img)
    return {"image": encode_image(result)}

@router.post("/laplacian")
async def api_laplacian(file: UploadFile = File(...)):
    img = decode_image(await file.read())
    result = spatial.laplacian(img)
    return {"image": encode_image(result)}

@router.post("/median-filter")
async def api_median_filter(file: UploadFile = File(...), ksize: int = Form(5)):
    img = decode_image(await file.read())
    result = spatial.median_filter(img, ksize)
    return {"image": encode_image(result)}

@router.post("/mean-filter")
async def api_mean_filter(file: UploadFile = File(...), ksize: int = Form(5)):
    img = decode_image(await file.read())
    result = spatial.mean_filter(img, ksize)
    return {"image": encode_image(result)}

@router.post("/gaussian-blur")
async def api_gaussian_blur(file: UploadFile = File(...), ksize: int = Form(5)):
    img = decode_image(await file.read())
    result = spatial.gaussian_blur(img, ksize)
    return {"image": encode_image(result)}

@router.post("/sobel")
async def api_sobel(file: UploadFile = File(...)):
    img = decode_image(await file.read())
    result = spatial.sobel_edge(img)
    return {"image": encode_image(result)}

# ===== FREQUENCY DOMAIN =====
@router.post("/lowpass")
async def api_lowpass(file: UploadFile = File(...), cutoff: int = Form(30)):
    img = decode_image(await file.read())
    result = frequency.lowpass_filter(img, cutoff)
    return {"image": encode_image(result)}

@router.post("/highpass")
async def api_highpass(file: UploadFile = File(...), cutoff: int = Form(30)):
    img = decode_image(await file.read())
    result = frequency.highpass_filter(img, cutoff)
    return {"image": encode_image(result)}

# ===== MORPHOLOGY =====
@router.post("/dilate")
async def api_dilate(file: UploadFile = File(...), ksize: int = Form(5)):
    img = decode_image(await file.read())
    result = morphology.dilate(img, ksize)
    return {"image": encode_image(result)}

@router.post("/erode")
async def api_erode(file: UploadFile = File(...), ksize: int = Form(5)):
    img = decode_image(await file.read())
    result = morphology.erode(img, ksize)
    return {"image": encode_image(result)}

@router.post("/opening")
async def api_opening(file: UploadFile = File(...), ksize: int = Form(5)):
    img = decode_image(await file.read())
    result = morphology.opening(img, ksize)
    return {"image": encode_image(result)}

@router.post("/closing")
async def api_closing(file: UploadFile = File(...), ksize: int = Form(5)):
    img = decode_image(await file.read())
    result = morphology.closing(img, ksize)
    return {"image": encode_image(result)}

# ===== NOISE & RESTORATION =====
@router.post("/salt-pepper")
async def api_salt_pepper(file: UploadFile = File(...), amount: float = Form(0.05)):
    img = decode_image(await file.read())
    result = restoration.add_salt_pepper_noise(img, amount)
    return {"image": encode_image(result)}

@router.post("/gaussian-noise")
async def api_gaussian_noise(file: UploadFile = File(...), sigma: float = Form(25)):
    img = decode_image(await file.read())
    result = restoration.add_gaussian_noise(img, sigma)
    return {"image": encode_image(result)}

@router.post("/denoise-median")
async def api_denoise_median(file: UploadFile = File(...), ksize: int = Form(5)):
    img = decode_image(await file.read())
    result = restoration.denoise_median(img, ksize)
    return {"image": encode_image(result)}

@router.post("/denoise-bilateral")
async def api_denoise_bilateral(file: UploadFile = File(...)):
    img = decode_image(await file.read())
    result = restoration.denoise_bilateral(img)
    return {"image": encode_image(result)}

# ===== SEGMENTATION & AI =====
@router.post("/otsu")
async def api_otsu(file: UploadFile = File(...)):
    img = decode_image(await file.read())
    result = segmentation.otsu_threshold(img)
    return {"image": encode_image(result)}

@router.post("/adaptive-threshold")
async def api_adaptive_threshold(file: UploadFile = File(...), block_size: int = Form(11)):
    img = decode_image(await file.read())
    result = segmentation.adaptive_threshold(img, block_size)
    return {"image": encode_image(result)}

@router.post("/canny")
async def api_canny(file: UploadFile = File(...), low: int = Form(50), high: int = Form(150)):
    img = decode_image(await file.read())
    result = segmentation.canny_edge(img, low, high)
    return {"image": encode_image(result)}

@router.post("/pca")
async def api_pca(file: UploadFile = File(...), n_components: int = Form(50)):
    img = decode_image(await file.read())
    result = segmentation.pca_compression(img, n_components)
    return {"image": encode_image(result)}

@router.post("/kmeans")
async def api_kmeans(file: UploadFile = File(...), k: int = Form(3)):
    img = decode_image(await file.read())
    result = segmentation.kmeans_segmentation(img, k)
    return {"image": encode_image(result)}

@router.post("/unet")
async def api_unet(file: UploadFile = File(...)):
    img = decode_image(await file.read())
    result = segmentation.unet_demo(img)
    return {"image": encode_image(result)}

@router.post("/deeplab")
async def api_deeplab(file: UploadFile = File(...)):
    img = decode_image(await file.read())
    result = segmentation.deeplab_demo(img)
    return {"image": encode_image(result)}
