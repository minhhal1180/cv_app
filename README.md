# CV Image Processing App

Ứng dụng xử lý ảnh số sử dụng Flutter + FastAPI (Python) với OpenCV.

## Cấu trúc project
```bash
cv-flutter-app/
├── backend/                      # Python FastAPI Backend
│   ├── app/
│   │   ├── main.py              # Entry point
│   │   ├── api/routes.py        # API endpoints
│   │   ├── services/            # Image processing modules
│   │   │   ├── intensity.py     # Biến đổi cường độ
│   │   │   ├── spatial.py       # Lọc không gian
│   │   │   ├── frequency.py     # Lọc miền tần số
│   │   │   ├── morphology.py    # Xử lý hình thái học
│   │   │   ├── restoration.py   # Khôi phục ảnh
│   │   │   └── segmentation.py  # Phân đoạn ảnh
│   │   └── utils/
│   │       └── image_helpers.py # Encode/decode ảnh
│   └── requirements.txt
│
└── cv_app/                       # Flutter Mobile App
    ├── lib/
    │   ├── main.dart            # Entry point
    │   ├── config/
    │   │   └── constants.dart   # API URL & operations config
    │   ├── providers/
    │   │   └── image_provider.dart  # State management
    │   ├── services/
    │   │   └── api_service.dart # HTTP client
    │   ├── screens/
    │   │   └── home_screen.dart # Main UI
    │   └── widgets/
    │       ├── image_viewer.dart    # Hiển thị ảnh
    │       ├── category_list.dart   # Danh sách category
    │       ├── operation_list.dart  # Danh sách operations
    │       └── param_sliders.dart   # Sliders điều chỉnh params
    └── pubspec.yaml
```
## Tính năng xử lý ảnh

### 1. Intensity (Biến đổi cường độ)
- **Negative** - Âm bản ảnh
- **Gamma** - Điều chỉnh gamma (0.1 - 3.0)
- **Histogram** - Hiển thị histogram
- **Equalize Histogram** - Cân bằng histogram
- **Local Histogram** - Histogram cục bộ (window 3-15)
- **Histogram Stats** - Thống kê histogram
- **Bit Plane** - Tách bit plane (0-7)

### 2. Spatial Filter (Lọc không gian)
- **Smooth** - Làm mịn (kernel 3-15)
- **Gaussian** - Lọc Gaussian (kernel + sigma)
- **Median** - Lọc trung vị (kernel 3-15)
- **Sharpen** - Làm sắc nét
- **Gradient** - Tính gradient

### 3. Frequency Filter (Lọc miền tần số)
- **FFT Spectrum** - Hiển thị phổ FFT
- **Ideal Lowpass** - Lọc thông thấp lý tưởng
- **Ideal Highpass** - Lọc thông cao lý tưởng
- **Gaussian Lowpass** - Lọc thông thấp Gaussian
- **Gaussian Highpass** - Lọc thông cao Gaussian

### 4. Morphology (Hình thái học)
- **Erode** - Co ảnh (kernel 3-15)
- **Dilate** - Giãn ảnh (kernel 3-15)
- **Opening** - Mở ảnh (erode → dilate)
- **Closing** - Đóng ảnh (dilate → erode)
- **Boundary** - Trích biên

### 5. Noise (Nhiễu)
- **Add Gaussian** - Thêm nhiễu Gaussian (mean, sigma)
- **Add Salt & Pepper** - Thêm nhiễu muối tiêu
- **Arithmetic Mean** - Lọc trung bình số học
- **Contra Harmonic** - Lọc contra-harmonic

### 6. Segmentation (Phân đoạn)
- **Threshold** - Ngưỡng hóa (0-255)
- **Otsu** - Ngưỡng Otsu tự động
- **Canny Edge** - Phát hiện biên Canny (low, high)
- **PCA** - Nén PCA
- **U-Net Demo** - Demo segmentation U-Net
- **DeepLab Demo** - Demo segmentation DeepLab

## Yêu cầu hệ thống

### Backend
- Python 3.10+
- FastAPI, OpenCV, NumPy, Pillow

### Flutter App
- Flutter SDK 3.10+
- Dart SDK 3.10+

## Cài đặt & Chạy

### 1. Backend

```bash
cd backend
pip install -r requirements.txt
python -m uvicorn app.main:app --host 0.0.0.0 --port 8000
```

### 2. Flutter App

```bash
cd cv_app
flutter pub get

# Chạy trên Android Emulator
flutter run

# Chạy trên iOS Simulator (macOS)
cd ios && pod install && cd ..
flutter run -d ios

# Chạy trên thiết bị thực
flutter run -d <device_id>
```

### 3. Build Production

```bash
# Android APK
flutter build apk --release

# Android App Bundle
flutter build appbundle --release

# iOS (macOS only)
flutter build ipa --release
```

## Cấu hình API URL

Sửa file `cv_app/lib/config/constants.dart`:

```dart
class AppConstants {
  // Android Emulator
  static const String apiUrl = 'http://10.0.2.2:8000/api';
  
  // iOS Simulator
  // static const String apiUrl = 'http://localhost:8000/api';
  
  // Real Device (thay bằng IP máy chạy backend)
  // static const String apiUrl = 'http://192.168.1.x:8000/api';
}
```

## Lưu ý

- **Android Emulator**: dùng `10.0.2.2` để truy cập localhost của máy host
- **Thiết bị thật**: dùng IP của máy chạy backend, đảm bảo cùng mạng WiFi
- Backend cần chạy với `--host 0.0.0.0` để cho phép kết nối từ bên ngoài
