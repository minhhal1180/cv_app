import 'package:flutter/material.dart';
import '../config/constants.dart';

class OperationList extends StatelessWidget {
  final OperationCategory category;
  final Operation? selectedOperation;
  final Function(Operation) onOperationSelected;

  const OperationList({
    super.key,
    required this.category,
    this.selectedOperation,
    required this.onOperationSelected,
  });

  String _getOperationDescription(String operationId) {
    final descriptions = {
      // Image Enhancement
      'negative': 'Đảo ngược giá trị pixel (s = L-1-r)',
      'gamma': 'Biến đổi lũy thừa (s = c*r^γ)',
      'log-transform': 'Biến đổi log (s = c*log(1+r))',
      'contrast-stretch': 'Kéo giãn độ tương phản tuyến tính từng phần',
      'intensity-slice': 'Cắt lát cường độ để làm nổi bật vùng quan tâm',
      'bit-plane': 'Tách bit plane (0-7) để phân tích ảnh',
      
      // Histogram Processing
      'histogram': 'Hiển thị biểu đồ phân bố mức xám',
      'histogram-equalize': 'Cân bằng histogram để tăng độ tương phản',
      'local-histogram': 'Cân bằng histogram cục bộ theo cửa sổ',
      'histogram-stats': 'Thống kê mean, variance, skewness của histogram',
      'histogram-match': 'Biến đổi histogram theo phân bố mục tiêu',
      
      // Spatial Filtering
      'smooth': 'Làm mịn bằng bộ lọc trung bình (mean filter)',
      'gaussian': 'Làm mờ Gaussian với sigma tùy chỉnh',
      'median': 'Lọc trung vị - hiệu quả với nhiễu muối tiêu',
      'sharpen': 'Làm sắc nét bằng Laplacian',
      'unsharp-mask': 'Tăng độ nét bằng unsharp masking',
      'gradient': 'Tính gradient bằng toán tử Sobel',
      'laplacian': 'Đạo hàm bậc 2 - phát hiện cạnh đẳng hướng',
      'highboost': 'High-boost = Original + k*(Original - Lowpass)',
      
      // Frequency Domain
      'fft-spectrum': 'Hiển thị phổ biên độ Fourier',
      'ideal-lowpass': 'Lọc thông thấp lý tưởng (cắt tần số cao)',
      'ideal-highpass': 'Lọc thông cao lý tưởng (cắt tần số thấp)',
      'butterworth-lowpass': 'Lọc thông thấp Butterworth (mượt hơn ideal)',
      'butterworth-highpass': 'Lọc thông cao Butterworth',
      'gaussian-lowpass': 'Lọc thông thấp Gaussian (không có ringing)',
      'gaussian-highpass': 'Lọc thông cao Gaussian',
      'homomorphic': 'Lọc Homomorphic - cải thiện chiếu sáng không đều',
      
      // PCA & Compression
      'pca': 'Nén PCA với số thành phần chọn trước',
      'pca-eigenfaces': 'Hiển thị các eigenfaces chính',
      'pca-reconstruction': 'Tái tạo ảnh từ PCA components',
      'jpeg-compress': 'Nén JPEG với quality factor',
      'png-compress': 'Nén PNG lossless (Deflate)',
      'webp-lossless': 'Nén WebP không mất dữ liệu',
      'run-length': 'Mã hóa Run-Length (RLE)',
      'huffman': 'Mã hóa Huffman entropy',
      
      // Restoration & Morphology
      'add-gaussian-noise': 'Thêm nhiễu Gaussian (mean, sigma)',
      'add-salt-pepper': 'Thêm nhiễu xung (salt & pepper)',
      'arithmetic-mean': 'Lọc trung bình số học - khử nhiễu Gaussian',
      'contra-harmonic': 'Lọc contra-harmonic - khử nhiễu muối/tiêu',
      'wiener': 'Lọc Wiener - khử nhiễu tối ưu',
      'erode': 'Xói mòn - thu nhỏ vùng sáng',
      'dilate': 'Giãn nở - mở rộng vùng sáng',
      'opening': 'Mở = Erode rồi Dilate (xóa nhiễu nhỏ)',
      'closing': 'Đóng = Dilate rồi Erode (lấp lỗ nhỏ)',
      'boundary': 'Trích xuất biên = A - Erode(A)',
      'skeleton': 'Xương hóa (thinning) đối tượng',
      
      // Segmentation & JPEG
      'threshold': 'Phân ngưỡng toàn cục cố định',
      'otsu': 'Phân ngưỡng Otsu tự động (maximize variance)',
      'adaptive-threshold': 'Phân ngưỡng thích ứng theo vùng',
      'canny': 'Phát hiện cạnh Canny (non-max suppression)',
      'region-growing': 'Phát triển vùng từ seed point',
      'kmeans': 'Phân đoạn K-means clustering',
      'watershed': 'Phân đoạn Watershed (đường phân thủy)',
      'jpeg-dct': 'Biến đổi DCT của JPEG (8x8 blocks)',
      'jpeg-quantize': 'Lượng tử hóa JPEG với quality factor',
      'jpeg-blocks': 'Hiển thị các khối 8x8 của JPEG',
    };
    return descriptions[operationId] ?? 'Thao tác xử lý ảnh số';
  }

  IconData _getOperationIcon(String operationId) {
    final icons = {
      // Image Enhancement
      'negative': Icons.invert_colors,
      'gamma': Icons.brightness_6,
      'log-transform': Icons.functions,
      'contrast-stretch': Icons.tune,
      'intensity-slice': Icons.layers,
      'bit-plane': Icons.view_week,
      
      // Histogram
      'histogram': Icons.bar_chart,
      'histogram-equalize': Icons.equalizer,
      'local-histogram': Icons.grid_on,
      'histogram-stats': Icons.analytics,
      'histogram-match': Icons.compare_arrows,
      
      // Spatial
      'smooth': Icons.blur_on,
      'gaussian': Icons.blur_circular,
      'median': Icons.filter_9_plus,
      'sharpen': Icons.deblur,
      'unsharp-mask': Icons.hdr_strong,
      'gradient': Icons.gradient,
      'laplacian': Icons.border_outer,
      'highboost': Icons.trending_up,
      
      // Frequency
      'fft-spectrum': Icons.auto_graph,
      'ideal-lowpass': Icons.filter_alt,
      'ideal-highpass': Icons.filter_alt_off,
      'butterworth-lowpass': Icons.waves,
      'butterworth-highpass': Icons.waves,
      'gaussian-lowpass': Icons.graphic_eq,
      'gaussian-highpass': Icons.graphic_eq,
      'homomorphic': Icons.wb_sunny,
      
      // PCA & Compression
      'pca': Icons.compress,
      'pca-eigenfaces': Icons.face,
      'pca-reconstruction': Icons.restore,
      'jpeg-compress': Icons.photo,
      'png-compress': Icons.image,
      'webp-lossless': Icons.high_quality,
      'run-length': Icons.linear_scale,
      'huffman': Icons.account_tree,
      
      // Restoration & Morphology
      'add-gaussian-noise': Icons.grain,
      'add-salt-pepper': Icons.scatter_plot,
      'arithmetic-mean': Icons.cleaning_services,
      'contra-harmonic': Icons.auto_fix_high,
      'wiener': Icons.auto_fix_normal,
      'erode': Icons.compress,
      'dilate': Icons.expand,
      'opening': Icons.open_in_full,
      'closing': Icons.close_fullscreen,
      'boundary': Icons.border_style,
      'skeleton': Icons.straighten,
      
      // Segmentation & JPEG
      'threshold': Icons.contrast,
      'otsu': Icons.auto_awesome,
      'adaptive-threshold': Icons.grid_view,
      'canny': Icons.border_clear,
      'region-growing': Icons.hub,
      'kmeans': Icons.bubble_chart,
      'watershed': Icons.water_drop,
      'jpeg-dct': Icons.grid_4x4,
      'jpeg-quantize': Icons.compress,
      'jpeg-blocks': Icons.view_module,
    };
    return icons[operationId] ?? Icons.settings;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: category.operations.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final operation = category.operations[index];
        final isSelected = selectedOperation?.id == operation.id;
        
        return GestureDetector(
          onTap: () => onOperationSelected(operation),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isSelected
                  ? category.color.withValues(alpha: 0.15)
                  : Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected
                    ? category.color
                    : Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
                width: isSelected ? 2 : 1,
              ),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: category.color.withValues(alpha: 0.2),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ]
                  : null,
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isSelected 
                      ? category.color.withValues(alpha: 0.2)
                      : Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    _getOperationIcon(operation.id),
                    size: 22,
                    color: isSelected
                        ? category.color
                        : Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        operation.name,
                        style: TextStyle(
                          color: isSelected
                              ? category.color
                              : Theme.of(context).colorScheme.onSurface,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        _getOperationDescription(operation.id),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 11,
                          color: Theme.of(context).colorScheme.onSurfaceVariant.withValues(alpha: 0.8),
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  isSelected ? Icons.check_circle : Icons.arrow_forward_ios,
                  size: isSelected ? 22 : 16,
                  color: isSelected 
                      ? category.color 
                      : Theme.of(context).colorScheme.outline,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
