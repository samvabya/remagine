import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remagine/providers/image_provider.dart';
import 'package:remagine/widgets/generated_image.dart';
import 'package:remagine/widgets/prompt_input.dart';
import 'package:remagine/widgets/loading_indicator.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imageProvider = Provider.of<ImageGeneratorProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            flexibleSpace: ShaderMask(
              shaderCallback: (rect) {
                return const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF121212), Colors.transparent],
                ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
              },
              blendMode: BlendMode.dstIn,
              child: Image.asset(
                'assets/icon.png',
                fit: BoxFit.cover,
              ),
            ),
            expandedHeight: 250,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(100),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 15,
                      backgroundImage: NetworkImage(
                          'https://avatars.githubusercontent.com/u/127547778?v=4'),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'by samvabya',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Turn your imagination into reality',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Create stunning AI-generated images with a simple text prompt',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.white70,
                        ),
                  ),
                  const SizedBox(height: 32),
                  const PromptInput(),
                  const SizedBox(height: 32),
                  if (imageProvider.isLoading)
                    const LoadingIndicator()
                  else if (imageProvider.generatedImageBytes != null)
                    const GeneratedImage(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
