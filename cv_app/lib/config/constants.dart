import 'package:flutter/material.dart';

class AppConstants {
  static const String apiUrl = 'http://10.0.2.2:8000/api';

  static List<OperationCategory> categories = [
    // 1. Image Enhancement (Point Processing)
    OperationCategory(
      id: 'enhancement',
      name: 'Image Enhancement',
      label: 'Enhancement',
      icon: Icons.brightness_6,
      color: Colors.orange,
      operations: [
        Operation(id: 'negative', name: 'Negative'),
        Operation(
          id: 'gamma',
          name: 'Gamma Correction',
          params: [
            OperationParam(name: 'gamma', label: 'Gamma', min: 0.1, max: 3.0, defaultValue: 1.0),
          ],
        ),
        Operation(
          id: 'log-transform',
          name: 'Log Transform',
          params: [
            OperationParam(name: 'c', label: 'Constant C', min: 1, max: 100, defaultValue: 1),
          ],
        ),
        Operation(
          id: 'contrast-stretch',
          name: 'Contrast Stretching',
          params: [
            OperationParam(name: 'r1', label: 'r1', min: 0, max: 127, defaultValue: 70),
            OperationParam(name: 's1', label: 's1', min: 0, max: 127, defaultValue: 0),
            OperationParam(name: 'r2', label: 'r2', min: 128, max: 255, defaultValue: 180),
            OperationParam(name: 's2', label: 's2', min: 128, max: 255, defaultValue: 255),
          ],
        ),
        Operation(
          id: 'intensity-slice',
          name: 'Intensity Slicing',
          params: [
            OperationParam(name: 'low', label: 'Low', min: 0, max: 255, defaultValue: 100),
            OperationParam(name: 'high', label: 'High', min: 0, max: 255, defaultValue: 200),
          ],
        ),
        Operation(
          id: 'bit-plane',
          name: 'Bit Plane Slicing',
          params: [
            OperationParam(name: 'bit', label: 'Bit Plane', min: 0, max: 7, defaultValue: 7),
          ],
        ),
      ],
    ),

    // 2. Histogram Processing
    OperationCategory(
      id: 'histogram',
      name: 'Histogram Processing',
      label: 'Histogram',
      icon: Icons.bar_chart,
      color: Colors.blue,
      operations: [
        Operation(id: 'histogram', name: 'Show Histogram'),
        Operation(id: 'histogram-equalize', name: 'Histogram Equalization'),
        Operation(
          id: 'local-histogram',
          name: 'Local Histogram Equalization',
          params: [
            OperationParam(name: 'window_size', label: 'Window Size', min: 3, max: 15, defaultValue: 7),
          ],
        ),
        Operation(id: 'histogram-stats', name: 'Histogram Statistics'),
        Operation(
          id: 'histogram-match',
          name: 'Histogram Matching',
          params: [
            OperationParam(name: 'mean', label: 'Target Mean', min: 0, max: 255, defaultValue: 128),
            OperationParam(name: 'std', label: 'Target Std', min: 1, max: 100, defaultValue: 50),
          ],
        ),
      ],
    ),

    // 3. Spatial Filtering
    OperationCategory(
      id: 'spatial',
      name: 'Spatial Filtering',
      label: 'Spatial',
      icon: Icons.blur_on,
      color: Colors.purple,
      operations: [
        Operation(
          id: 'smooth',
          name: 'Smoothing (Mean)',
          params: [
            OperationParam(name: 'kernel_size', label: 'Kernel Size', min: 3, max: 15, defaultValue: 5),
          ],
        ),
        Operation(
          id: 'gaussian',
          name: 'Gaussian Blur',
          params: [
            OperationParam(name: 'kernel_size', label: 'Kernel Size', min: 3, max: 15, defaultValue: 5),
            OperationParam(name: 'sigma', label: 'Sigma', min: 0.1, max: 5.0, defaultValue: 1.0),
          ],
        ),
        Operation(
          id: 'median',
          name: 'Median Filter',
          params: [
            OperationParam(name: 'kernel_size', label: 'Kernel Size', min: 3, max: 15, defaultValue: 5),
          ],
        ),
        Operation(id: 'sharpen', name: 'Sharpening (Laplacian)'),
        Operation(id: 'unsharp-mask', name: 'Unsharp Masking'),
        Operation(id: 'gradient', name: 'Gradient (Sobel)'),
        Operation(id: 'laplacian', name: 'Laplacian'),
        Operation(id: 'highboost', name: 'High-boost Filtering'),
      ],
    ),

    // 4. Frequency Domain Processing
    OperationCategory(
      id: 'frequency',
      name: 'Frequency Domain',
      label: 'Frequency',
      icon: Icons.waves,
      color: Colors.teal,
      operations: [
        Operation(id: 'fft-spectrum', name: 'FFT Spectrum'),
        Operation(
          id: 'ideal-lowpass',
          name: 'Ideal Lowpass Filter',
          params: [
            OperationParam(name: 'cutoff', label: 'Cutoff Freq', min: 5, max: 100, defaultValue: 30),
          ],
        ),
        Operation(
          id: 'ideal-highpass',
          name: 'Ideal Highpass Filter',
          params: [
            OperationParam(name: 'cutoff', label: 'Cutoff Freq', min: 5, max: 100, defaultValue: 30),
          ],
        ),
        Operation(
          id: 'butterworth-lowpass',
          name: 'Butterworth Lowpass',
          params: [
            OperationParam(name: 'cutoff', label: 'Cutoff', min: 5, max: 100, defaultValue: 30),
            OperationParam(name: 'order', label: 'Order', min: 1, max: 5, defaultValue: 2),
          ],
        ),
        Operation(
          id: 'butterworth-highpass',
          name: 'Butterworth Highpass',
          params: [
            OperationParam(name: 'cutoff', label: 'Cutoff', min: 5, max: 100, defaultValue: 30),
            OperationParam(name: 'order', label: 'Order', min: 1, max: 5, defaultValue: 2),
          ],
        ),
        Operation(
          id: 'gaussian-lowpass',
          name: 'Gaussian Lowpass',
          params: [
            OperationParam(name: 'cutoff', label: 'Cutoff', min: 5, max: 100, defaultValue: 30),
          ],
        ),
        Operation(
          id: 'gaussian-highpass',
          name: 'Gaussian Highpass',
          params: [
            OperationParam(name: 'cutoff', label: 'Cutoff', min: 5, max: 100, defaultValue: 30),
          ],
        ),
        Operation(
          id: 'homomorphic',
          name: 'Homomorphic Filter',
          params: [
            OperationParam(name: 'gamma_l', label: 'Gamma L', min: 0.1, max: 1.0, defaultValue: 0.5),
            OperationParam(name: 'gamma_h', label: 'Gamma H', min: 1.0, max: 3.0, defaultValue: 2.0),
            OperationParam(name: 'cutoff', label: 'Cutoff', min: 5, max: 100, defaultValue: 30),
          ],
        ),
      ],
    ),

    // 5. PCA & Image Compression (Lossless)
    OperationCategory(
      id: 'compression',
      name: 'PCA & Compression',
      label: 'PCA/Compress',
      icon: Icons.compress,
      color: Colors.deepOrange,
      operations: [
        Operation(
          id: 'pca',
          name: 'PCA Compression',
          params: [
            OperationParam(name: 'n_components', label: 'Components', min: 1, max: 100, defaultValue: 50),
          ],
        ),
        Operation(id: 'pca-eigenfaces', name: 'PCA Eigenfaces'),
        Operation(id: 'pca-reconstruction', name: 'PCA Reconstruction'),
        Operation(
          id: 'jpeg-compress',
          name: 'JPEG Compression',
          params: [
            OperationParam(name: 'quality', label: 'Quality', min: 1, max: 100, defaultValue: 95),
          ],
        ),
        Operation(
          id: 'png-compress',
          name: 'PNG Lossless',
          params: [
            OperationParam(name: 'level', label: 'Compression Level', min: 0, max: 9, defaultValue: 9),
          ],
        ),
        Operation(id: 'webp-lossless', name: 'WebP Lossless'),
        Operation(id: 'run-length', name: 'Run-Length Encoding'),
        Operation(id: 'huffman', name: 'Huffman Coding'),
      ],
    ),

    // 6. Image Restoration & Morphological Processing
    OperationCategory(
      id: 'restoration',
      name: 'Restoration & Morphology',
      label: 'Restore',
      icon: Icons.healing,
      color: Colors.green,
      operations: [
        Operation(
          id: 'add-gaussian-noise',
          name: 'Add Gaussian Noise',
          params: [
            OperationParam(name: 'mean', label: 'Mean', min: 0, max: 50, defaultValue: 0),
            OperationParam(name: 'sigma', label: 'Sigma', min: 1, max: 50, defaultValue: 25),
          ],
        ),
        Operation(
          id: 'add-salt-pepper',
          name: 'Add Salt & Pepper',
          params: [
            OperationParam(name: 'amount', label: 'Amount', min: 0.01, max: 0.2, defaultValue: 0.05),
          ],
        ),
        Operation(
          id: 'arithmetic-mean',
          name: 'Arithmetic Mean Filter',
          params: [
            OperationParam(name: 'kernel_size', label: 'Kernel Size', min: 3, max: 15, defaultValue: 5),
          ],
        ),
        Operation(
          id: 'contra-harmonic',
          name: 'Contra-Harmonic Filter',
          params: [
            OperationParam(name: 'kernel_size', label: 'Kernel Size', min: 3, max: 15, defaultValue: 5),
            OperationParam(name: 'q', label: 'Q Order', min: -3.0, max: 3.0, defaultValue: 1.5),
          ],
        ),
        Operation(
          id: 'wiener',
          name: 'Wiener Filter',
          params: [
            OperationParam(name: 'noise_var', label: 'Noise Variance', min: 0.001, max: 0.1, defaultValue: 0.01),
          ],
        ),
        Operation(
          id: 'erode',
          name: 'Erosion',
          params: [
            OperationParam(name: 'kernel_size', label: 'Kernel Size', min: 3, max: 15, defaultValue: 5),
          ],
        ),
        Operation(
          id: 'dilate',
          name: 'Dilation',
          params: [
            OperationParam(name: 'kernel_size', label: 'Kernel Size', min: 3, max: 15, defaultValue: 5),
          ],
        ),
        Operation(
          id: 'opening',
          name: 'Opening',
          params: [
            OperationParam(name: 'kernel_size', label: 'Kernel Size', min: 3, max: 15, defaultValue: 5),
          ],
        ),
        Operation(
          id: 'closing',
          name: 'Closing',
          params: [
            OperationParam(name: 'kernel_size', label: 'Kernel Size', min: 3, max: 15, defaultValue: 5),
          ],
        ),
        Operation(id: 'boundary', name: 'Boundary Extraction'),
        Operation(id: 'skeleton', name: 'Skeletonization'),
      ],
    ),

    // 7. Image Segmentation & JPEG Standard
    OperationCategory(
      id: 'segmentation',
      name: 'Segmentation & JPEG',
      label: 'Segment',
      icon: Icons.auto_awesome,
      color: Colors.indigo,
      operations: [
        Operation(
          id: 'threshold',
          name: 'Global Thresholding',
          params: [
            OperationParam(name: 'thresh', label: 'Threshold', min: 0, max: 255, defaultValue: 127),
          ],
        ),
        Operation(id: 'otsu', name: 'Otsu Thresholding'),
        Operation(
          id: 'adaptive-threshold',
          name: 'Adaptive Thresholding',
          params: [
            OperationParam(name: 'block_size', label: 'Block Size', min: 3, max: 31, defaultValue: 11),
            OperationParam(name: 'c', label: 'Constant C', min: -10, max: 10, defaultValue: 2),
          ],
        ),
        Operation(
          id: 'canny',
          name: 'Canny Edge Detection',
          params: [
            OperationParam(name: 'low', label: 'Low Threshold', min: 0, max: 255, defaultValue: 50),
            OperationParam(name: 'high', label: 'High Threshold', min: 0, max: 255, defaultValue: 150),
          ],
        ),
        Operation(id: 'region-growing', name: 'Region Growing'),
        Operation(
          id: 'kmeans',
          name: 'K-Means Segmentation',
          params: [
            OperationParam(name: 'k', label: 'Number of Clusters', min: 2, max: 10, defaultValue: 3),
          ],
        ),
        Operation(id: 'watershed', name: 'Watershed'),
        Operation(id: 'jpeg-dct', name: 'JPEG DCT Transform'),
        Operation(
          id: 'jpeg-quantize',
          name: 'JPEG Quantization',
          params: [
            OperationParam(name: 'quality', label: 'Quality Factor', min: 1, max: 100, defaultValue: 50),
          ],
        ),
        Operation(id: 'jpeg-blocks', name: 'Show JPEG Blocks (8x8)'),
      ],
    ),
  ];
}

class OperationCategory {
  final String id;
  final String name;
  final String label;
  final IconData icon;
  final Color color;
  final List<Operation> operations;

  OperationCategory({
    required this.id,
    required this.name,
    required this.label,
    required this.icon,
    required this.color,
    required this.operations,
  });
}

class Operation {
  final String id;
  final String name;
  final List<OperationParam>? params;

  Operation({
    required this.id,
    required this.name,
    this.params,
  });
}

class OperationParam {
  final String name;
  final String label;
  final double min;
  final double max;
  final double defaultValue;

  OperationParam({
    required this.name,
    required this.label,
    required this.min,
    required this.max,
    required this.defaultValue,
  });
}
