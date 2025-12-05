import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';

class ImageViewer extends StatefulWidget {
  final File? originalImage;
  final Uint8List? processedImage;

  const ImageViewer({
    super.key,
    this.originalImage,
    this.processedImage,
  });

  @override
  State<ImageViewer> createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer> {
  bool _showProcessed = true;

  @override
  Widget build(BuildContext context) {
    if (widget.originalImage == null) {
      return _buildEmptyState(context);
    }

    return Column(
      children: [
        Container(
          height: 280,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              fit: StackFit.expand,
              children: [
                _buildImage(),
                if (widget.processedImage != null)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: _buildToggleButton(context),
                  ),
              ],
            ),
          ),
        ),
        if (widget.processedImage != null) ...[
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildTabButton(context, 'Original', !_showProcessed, () {
                setState(() => _showProcessed = false);
              }),
              const SizedBox(width: 8),
              _buildTabButton(context, 'Processed', _showProcessed, () {
                setState(() => _showProcessed = true);
              }),
            ],
          ),
        ],
      ],
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).colorScheme.outlineVariant,
          width: 2,
          strokeAlign: BorderSide.strokeAlignInside,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.add_photo_alternate_outlined,
            size: 48,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: 12),
          Text(
            'Select an image to start',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Choose from gallery or camera',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    if (widget.processedImage != null && _showProcessed) {
      return Image.memory(
        widget.processedImage!,
        fit: BoxFit.contain,
      );
    }
    return Image.file(
      widget.originalImage!,
      fit: BoxFit.contain,
    );
  }

  Widget _buildToggleButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(20),
      ),
      child: IconButton(
        icon: Icon(
          _showProcessed ? Icons.compare : Icons.auto_fix_high,
          color: Colors.white,
          size: 20,
        ),
        onPressed: () => setState(() => _showProcessed = !_showProcessed),
        tooltip: _showProcessed ? 'Show original' : 'Show processed',
      ),
    );
  }

  Widget _buildTabButton(BuildContext context, String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).colorScheme.primaryContainer
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.outline,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.onSurfaceVariant,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
