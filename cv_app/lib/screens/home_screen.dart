import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import '../providers/image_provider.dart';
import '../widgets/image_viewer.dart';
import '../widgets/category_list.dart';
import '../widgets/operation_list.dart';
import '../widgets/param_sliders.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<ImageProcessingProvider>(
          builder: (context, provider, child) {
            return Column(
              children: [
                _buildHeader(context, provider),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildImageSection(context, provider),
                        const SizedBox(height: 20),
                        _buildCategorySection(context, provider),
                        if (provider.selectedCategory != null) ...[
                          const SizedBox(height: 16),
                          _buildOperationSection(context, provider),
                        ],
                        if (provider.selectedOperation != null) ...[
                          const SizedBox(height: 16),
                          _buildParamsSection(context, provider),
                          const SizedBox(height: 20),
                          _buildProcessButton(context, provider),
                        ],
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, ImageProcessingProvider provider) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.auto_fix_high,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'CV Image Processing',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'OpenCV & Deep Learning',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          if (provider.originalImage != null)
            IconButton(
              onPressed: () => provider.reset(),
              icon: const Icon(Icons.refresh),
              tooltip: 'Reset',
            ),
        ],
      ),
    );
  }

  Widget _buildImageSection(BuildContext context, ImageProcessingProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Image',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        ImageViewer(
          originalImage: provider.originalImage,
          processedImage: provider.processedImage,
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () => provider.pickImage(ImageSource.gallery),
                icon: const Icon(Icons.photo_library),
                label: const Text('Gallery'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () => provider.pickImage(ImageSource.camera),
                icon: const Icon(Icons.camera_alt),
                label: const Text('Camera'),
              ),
            ),
          ],
        ),
        if (provider.processedImage != null) ...[
          const SizedBox(height: 8),
          FilledButton.icon(
            onPressed: () => provider.saveProcessedImage(),
            icon: const Icon(Icons.save_alt),
            label: const Text('Save Result'),
          ),
        ],
        if (provider.error != null) ...[
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.errorContainer,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.error_outline, color: Theme.of(context).colorScheme.error),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    provider.error!,
                    style: TextStyle(color: Theme.of(context).colorScheme.error),
                  ),
                ),
              ],
            ),
          ),
        ],
        if (provider.successMessage != null) ...[
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green.shade700),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    provider.successMessage!,
                    style: TextStyle(color: Colors.green.shade700),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildCategorySection(BuildContext context, ImageProcessingProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Category',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        CategoryList(
          selectedCategory: provider.selectedCategory,
          onCategorySelected: provider.selectCategory,
        ),
      ],
    );
  }

  Widget _buildOperationSection(BuildContext context, ImageProcessingProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Operation',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        OperationList(
          category: provider.selectedCategory!,
          selectedOperation: provider.selectedOperation,
          onOperationSelected: provider.selectOperation,
        ),
      ],
    );
  }

  Widget _buildParamsSection(BuildContext context, ImageProcessingProvider provider) {
    if (provider.selectedOperation?.params == null ||
        provider.selectedOperation!.params!.isEmpty) {
      return const SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Parameters',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        ParamSliders(
          params: provider.selectedOperation!.params!,
          values: provider.params,
          onParamChanged: provider.updateParam,
        ),
      ],
    );
  }

  Widget _buildProcessButton(BuildContext context, ImageProcessingProvider provider) {
    return FilledButton.icon(
      onPressed: provider.originalImage != null && !provider.isLoading
          ? () => provider.processImage()
          : null,
      icon: provider.isLoading
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white,
              ),
            )
          : const Icon(Icons.play_arrow),
      label: Text(provider.isLoading ? 'Processing...' : 'Process Image'),
      style: FilledButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
    );
  }
}
