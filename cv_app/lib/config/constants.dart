import 'package:flutter/material.dart';

// API Configuration
class AppConstants {
  static const String apiUrl = 'http://10.0.2.2:8000/api';
  
  static List<OperationCategory> categories = [
    OperationCategory(
      id: 'intensity',
      name: 'Intensity',
      label: 'Intensity',
      icon: Icons.brightness_6,
      color: Colors.orange,
      operations: [
        Operation(id: 'negative', name: 'Negative'),
        Operation(
          id: 'gamma',
          name: 'Gamma',
          params: [
            OperationParam(name: 'gamma', label: 'Gamma', min: 0.1, max: 3.0, defaultValue: 1.0),
          ],
        ),
        Operation(id: 'histogram', name: 'Histogram'),
        Operation(id: 'histogram-equalize', name: 'Equalize Histogram'),
        Operation(
          id: 'local-histogram',
          name: 'Local Histogram',
          params: [
            OperationParam(name: 'window_size', label: 'Window Size', min: 3, max: 15, defaultValue: 7),
          ],
        ),
        Operation(id: 'histogram-stats', name: 'Histogram Stats'),
        Operation(
          id: 'bit-plane',
          name: 'Bit Plane',
          params: [
            OperationParam(name: 'bit', label: 'Bit Plane', min: 0, max: 7, defaultValue: 7),
          ],
        ),
      ],
    ),
    OperationCategory(
      id: 'spatial',
      name: 'Spatial Filter',
      label: 'Spatial',
      icon: Icons.blur_on,
      color: Colors.blue,
      operations: [
        Operation(
          id: 'smooth',
          name: 'Smooth',
          params: [
            OperationParam(name: 'kernel_size', label: 'Kernel Size', min: 3, max: 15, defaultValue: 5),
          ],
        ),
        Operation(
          id: 'gaussian',
          name: 'Gaussian',
          params: [
            OperationParam(name: 'kernel_size', label: 'Kernel Size', min: 3, max: 15, defaultValue: 5),
            OperationParam(name: 'sigma', label: 'Sigma', min: 0.1, max: 5.0, defaultValue: 1.0),
          ],
        ),
        Operation(
          id: 'median',
          name: 'Median',
          params: [
            OperationParam(name: 'kernel_size', label: 'Kernel Size', min: 3, max: 15, defaultValue: 5),
          ],
        ),
        Operation(id: 'sharpen', name: 'Sharpen'),
        Operation(id: 'gradient', name: 'Gradient'),
      ],
    ),
    OperationCategory(
      id: 'frequency',
      name: 'Frequency Filter',
      label: 'Frequency',
      icon: Icons.waves,
      color: Colors.purple,
      operations: [
        Operation(id: 'fft-spectrum', name: 'FFT Spectrum'),
        Operation(
          id: 'ideal-lowpass',
          name: 'Ideal Lowpass',
          params: [
            OperationParam(name: 'cutoff', label: 'Cutoff', min: 5, max: 100, defaultValue: 30),
          ],
        ),
        Operation(
          id: 'ideal-highpass',
          name: 'Ideal Highpass',
          params: [
            OperationParam(name: 'cutoff', label: 'Cutoff', min: 5, max: 100, defaultValue: 30),
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
      ],
    ),
    OperationCategory(
      id: 'morphology',
      name: 'Morphology',
      label: 'Morphology',
      icon: Icons.category,
      color: Colors.green,
      operations: [
        Operation(
          id: 'erode',
          name: 'Erode',
          params: [
            OperationParam(name: 'kernel_size', label: 'Kernel Size', min: 3, max: 15, defaultValue: 5),
          ],
        ),
        Operation(
          id: 'dilate',
          name: 'Dilate',
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
        Operation(id: 'boundary', name: 'Boundary'),
      ],
    ),
    OperationCategory(
      id: 'noise',
      name: 'Noise',
      label: 'Noise',
      icon: Icons.grain,
      color: Colors.teal,
      operations: [
        Operation(
          id: 'add-gaussian-noise',
          name: 'Add Gaussian',
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
          name: 'Arithmetic Mean',
          params: [
            OperationParam(name: 'kernel_size', label: 'Kernel Size', min: 3, max: 15, defaultValue: 5),
          ],
        ),
        Operation(
          id: 'contra-harmonic',
          name: 'Contra Harmonic',
          params: [
            OperationParam(name: 'kernel_size', label: 'Kernel Size', min: 3, max: 15, defaultValue: 5),
            OperationParam(name: 'q', label: 'Q Order', min: -3.0, max: 3.0, defaultValue: 1.5),
          ],
        ),
      ],
    ),
    OperationCategory(
      id: 'segmentation',
      name: 'Segmentation',
      label: 'Segment',
      icon: Icons.auto_awesome,
      color: Colors.indigo,
      operations: [
        Operation(
          id: 'threshold',
          name: 'Threshold',
          params: [
            OperationParam(name: 'thresh', label: 'Threshold', min: 0, max: 255, defaultValue: 127),
          ],
        ),
        Operation(id: 'otsu', name: 'Otsu'),
        Operation(
          id: 'canny',
          name: 'Canny Edge',
          params: [
            OperationParam(name: 'low', label: 'Low', min: 0, max: 255, defaultValue: 50),
            OperationParam(name: 'high', label: 'High', min: 0, max: 255, defaultValue: 150),
          ],
        ),
        Operation(id: 'pca', name: 'PCA'),
        Operation(id: 'unet-demo', name: 'U-Net Demo'),
        Operation(id: 'deeplab-demo', name: 'DeepLab Demo'),
      ],
    ),
  ];
}

// Data Models
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
