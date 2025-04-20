import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:provider/provider.dart';
import 'package:remagine/providers/image_provider.dart';

class PromptInput extends StatefulWidget {
  const PromptInput({Key? key}) : super(key: key);

  @override
  State<PromptInput> createState() => _PromptInputState();
}

class _PromptInputState extends State<PromptInput> {
  final TextEditingController _promptController = TextEditingController();

  @override
  void dispose() {
    _promptController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final imageProvider = Provider.of<ImageGeneratorProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Enter your prompt',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF2A2A2A),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: TextField(
            controller: _promptController,
            style: const TextStyle(color: Colors.white),
            maxLines: 3,
            minLines: 1,
            decoration: InputDecoration(
              hintText: 'A magical Disney-inspired castle...',
              hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(16),
              suffixIcon: IconButton(
                icon: const Icon(FeatherIcons.x, size: 18),
                onPressed: () {
                  _promptController.clear();
                },
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: imageProvider.isLoading
                ? null
                : () {
                    if (_promptController.text.isNotEmpty) {
                      imageProvider.generateImage(_promptController.text);
                      FocusScope.of(context).unfocus();
                    }
                  },
            icon: const Icon(FeatherIcons.image),
            label: const Text('Generate Image'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6C63FF),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
