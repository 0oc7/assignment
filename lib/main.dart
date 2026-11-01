
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const NeuralAcademy());
}

// COLORS
const navy = Color(0xFF10243A);
const blue = Color(0xFF3468E8);
const teal = Color(0xFF17B6A4);
const background = Color(0xFFF5F8FC);
const grey = Color(0xFF68798B);
const githubLink = 'https://github.com/0oc7/assignment';

class NeuralAcademy extends StatelessWidget {
  const NeuralAcademy({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Neural Academy',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: blue,
          surface: background,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: navy,
          elevation: 0,
        ),
      ),
      home: const MainScreen(),
    );
  }
}

// MAIN SCREEN
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;

  void navigate(int index) {
    setState(() => selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomePage(onNext: () => navigate(1)),
      AboutPage(onNext: () => navigate(2)),
      const ContactPage(),
    ];

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: navy,
                borderRadius: BorderRadius.circular(13),
              ),
              child: const Icon(
                Icons.psychology_rounded,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 12),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'NEURAL',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.5,
                  ),
                ),
                Text(
                  'ACADEMY',
                  style: TextStyle(
                    fontSize: 10,
                    color: grey,
                    letterSpacing: 2.4,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: background,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.auto_awesome_rounded,
              color: blue,
              size: 21,
            ),
          ),
        ],
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 280),
        child: KeyedSubtree(
          key: ValueKey(selectedIndex),
          child: pages[selectedIndex],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.white,
        indicatorColor: const Color(0xFFE0E9FF),
        selectedIndex: selectedIndex,
        onDestinationSelected: navigate,
        height: 72,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home, color: blue),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.menu_book_outlined),
            selectedIcon: Icon(Icons.menu_book, color: blue),
            label: 'About',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person, color: blue),
            label: 'Contact',
          ),
        ],
      ),
    );
  }
}

// COMMON PAGE LAYOUT
class AppPage extends StatelessWidget {
  final List<Widget> children;

  const AppPage({
    super.key,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: children,
        ),
      ),
    );
  }
}

// COMMON BUTTON
class ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  const ActionButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: FilledButton.icon(
        onPressed: onPressed,
        icon: Icon(icon),
        label: Text(
          label,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: FilledButton.styleFrom(
          backgroundColor: navy,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}

// COMMON FEATURE CARD
class FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color color;

  const FeatureCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    this.color = blue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFE5EBF2),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(icon, color: color, size: 27),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: navy,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  description,
                  style: const TextStyle(
                    color: grey,
                    fontSize: 12,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// SECTION HEADING
class SectionHeading extends StatelessWidget {
  final String title;
  final String subtitle;

  const SectionHeading({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.w900,
            color: navy,
          ),
        ),
        const SizedBox(height: 7),
        Text(
          subtitle,
          style: const TextStyle(
            fontSize: 13,
            color: grey,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}

// HOME PAGE
class HomePage extends StatelessWidget {
  final VoidCallback onNext;

  const HomePage({
    super.key,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return AppPage(
      children: [
        const Text(
          'YOUR JOURNEY INTO AI',
          style: TextStyle(
            color: blue,
            fontWeight: FontWeight.bold,
            fontSize: 11,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 14),
        const Text(
          'Understand AI.\nShape Tomorrow.',
          style: TextStyle(
            color: navy,
            fontSize: 35,
            fontWeight: FontWeight.w900,
            height: 1.15,
          ),
        ),
        const SizedBox(height: 14),
        const Text(
          'Explore the technologies behind intelligent '
              'systems and discover how machines learn '
              'from data.',
          style: TextStyle(
            color: grey,
            fontSize: 14,
            height: 1.7,
          ),
        ),
        const SizedBox(height: 25),

        // AI HERO CARD
        Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xFF10243A),
                Color(0xFF195774),
                Color(0xFF247A8C),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(27),
          ),
          child: Column(
            children: [
              const Row(
                children: [
                  Icon(
                    Icons.memory_rounded,
                    color: Color(0xFF70E0D1),
                  ),
                  SizedBox(width: 9),
                  Text(
                    'ARTIFICIAL INTELLIGENCE',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.3,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // AI illustration drawn locally
              const SizedBox(
                height: 185,
                width: double.infinity,
                child: CustomPaint(
                  painter: NeuralPainter(),
                ),
              ),

              const SizedBox(height: 8),
              const Text(
                'Inside the Neural Network',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 7),
              const Text(
                'Connected neurons process information '
                    'and learn patterns from data.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFFD8EBF2),
                  fontSize: 12,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 28),
        const SectionHeading(
          title: 'Explore AI Fields',
          subtitle:
          'Three important areas of artificial intelligence.',
        ),
        const SizedBox(height: 18),
        const FeatureCard(
          icon: Icons.model_training,
          title: 'Machine Learning',
          description:
          'Algorithms that identify patterns from data.',
        ),
        const FeatureCard(
          icon: Icons.hub_rounded,
          title: 'Deep Learning',
          description:
          'Multi-layer neural networks for complex tasks.',
          color: teal,
        ),
        const FeatureCard(
          icon: Icons.visibility_outlined,
          title: 'Computer Vision',
          description:
          'AI systems that analyze images and video.',
          color: Color(0xFFE89B36),
        ),
        const SizedBox(height: 15),
        ActionButton(
          label: 'Learn How AI Works',
          icon: Icons.arrow_forward_rounded,
          onPressed: onNext,
        ),
      ],
    );
  }
}

// NEURAL NETWORK ILLUSTRATION
class NeuralPainter extends CustomPainter {
  const NeuralPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final layers = [
      [0.18, 0.39, 0.61, 0.82],
      [0.12, 0.31, 0.50, 0.69, 0.88],
      [0.20, 0.40, 0.60, 0.80],
      [0.35, 0.65],
    ];

    final positions = <List<Offset>>[];

    for (int layer = 0; layer < layers.length; layer++) {
      final x = size.width * (0.12 + layer * 0.25);
      positions.add(
        layers[layer]
            .map((y) => Offset(x, size.height * y))
            .toList(),
      );
    }

    final linePaint = Paint()
      ..color = const Color(0xFF81D9E9).withValues(alpha: 0.28)
      ..strokeWidth = 1;

    for (int layer = 0; layer < positions.length - 1; layer++) {
      for (final start in positions[layer]) {
        for (final end in positions[layer + 1]) {
          canvas.drawLine(start, end, linePaint);
        }
      }
    }

    for (int layer = 0; layer < positions.length; layer++) {
      for (final position in positions[layer]) {
        canvas.drawCircle(
          position,
          9,
          Paint()
            ..color = const Color(0xFF57D6DF)
                .withValues(alpha: 0.18),
        );

        canvas.drawCircle(
          position,
          4.5,
          Paint()
            ..color = layer == positions.length - 1
                ? Colors.white
                : const Color(0xFF63E6E0),
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

// ABOUT PAGE
class AboutPage extends StatelessWidget {
  final VoidCallback onNext;

  const AboutPage({
    super.key,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return AppPage(
      children: [
        const Text(
          'ABOUT ARTIFICIAL INTELLIGENCE',
          style: TextStyle(
            color: blue,
            fontSize: 11,
            letterSpacing: 1.8,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 15),
        const Text(
          'How Do Machines\nLearn?',
          style: TextStyle(
            color: navy,
            fontSize: 34,
            fontWeight: FontWeight.w900,
            height: 1.15,
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Artificial intelligence enables computers '
              'to perform tasks such as recognizing patterns, '
              'understanding language and making predictions.',
          style: TextStyle(
            color: grey,
            fontSize: 14,
            height: 1.7,
          ),
        ),
        const SizedBox(height: 26),

        Container(
          padding: const EdgeInsets.all(23),
          decoration: BoxDecoration(
            color: navy,
            borderRadius: BorderRadius.circular(24),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.psychology_rounded,
                color: Color(0xFF7BE4D7),
                size: 50,
              ),
              SizedBox(height: 15),
              Text(
                'From Data to Intelligence',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 9),
              Text(
                'Machine learning models learn relationships '
                    'from examples and use those relationships '
                    'to make predictions on new data.',
                style: TextStyle(
                  color: Color(0xFFD1E3E9),
                  height: 1.6,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 28),
        const SectionHeading(
          title: 'The AI Workflow',
          subtitle: 'Four common stages in model development.',
        ),
        const SizedBox(height: 18),
        const FeatureCard(
          icon: Icons.dataset_outlined,
          title: '01 — Data Preparation',
          description:
          'Collect, clean and organize training data.',
        ),
        const FeatureCard(
          icon: Icons.settings_suggest_outlined,
          title: '02 — Model Training',
          description:
          'Learn useful patterns from training examples.',
          color: teal,
        ),
        const FeatureCard(
          icon: Icons.analytics_outlined,
          title: '03 — Evaluation',
          description:
          'Measure performance on unseen test data.',
          color: Color(0xFFE89B36),
        ),
        const FeatureCard(
          icon: Icons.rocket_launch_outlined,
          title: '04 — Deployment',
          description:
          'Integrate the model into a real application.',
        ),

        const SizedBox(height: 24),
        const SectionHeading(
          title: 'Natural Language Processing',
          subtitle:
          'NLP helps computers process human language, '
              'supporting applications like translation, '
              'search and conversational assistants.',
        ),
        const SizedBox(height: 25),
        ActionButton(
          label: 'Contact & Project Details',
          icon: Icons.arrow_forward_rounded,
          onPressed: onNext,
        ),
      ],
    );
  }
}

// CONTACT PAGE
class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  Future<void> copyGithub(BuildContext context) async {
    await Clipboard.setData(
      const ClipboardData(text: githubLink),
    );

    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('GitHub link copied successfully!'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppPage(
      children: [
        const Text(
          'CONTACT & PROJECT',
          style: TextStyle(
            color: blue,
            fontSize: 11,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 15),
        const Text(
          'Connect With\nThe Project.',
          style: TextStyle(
            color: navy,
            fontSize: 35,
            height: 1.15,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 15),
        const Text(
          'Neural Academy is an educational Flutter '
              'application introducing core concepts '
              'of artificial intelligence.',
          style: TextStyle(
            color: grey,
            height: 1.7,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 28),

        Container(
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: navy,
            borderRadius: BorderRadius.circular(27),
          ),
          child: const Column(
            children: [
              Icon(
                Icons.code_rounded,
                color: Color(0xFF7BE4D7),
                size: 58,
              ),
              SizedBox(height: 18),
              Text(
                'Explore The Source Code',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'The Flutter project is available '
                    'through its GitHub repository.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFFD1E3E9),
                  height: 1.6,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 26),
        const SectionHeading(
          title: 'Project Information',
          subtitle:
          'Details about this Flutter assignment.',
        ),
        const SizedBox(height: 17),
        const FeatureCard(
          icon: Icons.school_outlined,
          title: 'Academic Project',
          description:
          'A three-page Flutter application about AI.',
        ),
        const FeatureCard(
          icon: Icons.phone_android_rounded,
          title: 'Flutter Application',
          description:
          'Developed with Dart and Material Design 3.',
          color: teal,
        ),
        const FeatureCard(
          icon: Icons.account_tree_outlined,
          title: 'GitHub Repository',
          description: githubLink,
        ),
        const SizedBox(height: 16),
        ActionButton(
          label: 'Copy GitHub Link',
          icon: Icons.copy_rounded,
          onPressed: () => copyGithub(context),
        ),
        const SizedBox(height: 30),
        const Center(
          child: Text(
            'NEURAL ACADEMY  •  FLUTTER PROJECT',
            style: TextStyle(
              color: grey,
              fontSize: 11,
              letterSpacing: 1.2,
            ),
          ),
        ),
      ],
    );
  }
}
