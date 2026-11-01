
import 'package:flutter/material.dart';

void main() {
  runApp(const NovaApp());
}

const Color bg = Color(0xFF090E1D);
const Color card = Color(0xFF151D32);
const Color violet = Color(0xFF8B5CF6);
const Color sky = Color(0xFF38BDF8);
const Color softText = Color(0xFFA5B0C8);

class NovaApp extends StatelessWidget {
  const NovaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nova Creative',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: bg,
        colorScheme: ColorScheme.fromSeed(
          seedColor: violet,
          brightness: Brightness.dark,
        ),
      ),
      home: const MainScreen(),
    );
  }
}

// MAIN SCREEN + NAVIGATION
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  void changePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomePage(onNext: () => changePage(1)),
      AboutPage(onNext: () => changePage(2)),
      const ContactPage(),
    ];

    const titles = ['Home', 'About', 'Contact'];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: bg,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: violet,
                borderRadius: BorderRadius.circular(11),
              ),
              child: const Icon(
                Icons.auto_awesome,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'NOVA',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                letterSpacing: 3,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Center(
              child: Text(
                titles[currentIndex].toUpperCase(),
                style: const TextStyle(
                  color: softText,
                  fontSize: 11,
                  letterSpacing: 2,
                ),
              ),
            ),
          ),
        ],
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 350),
        transitionBuilder: (child, animation) {
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.08, 0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            ),
          );
        },
        child: KeyedSubtree(
          key: ValueKey(currentIndex),
          child: pages[currentIndex],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: card,
          border: Border(
            top: BorderSide(color: Color(0xFF29324A)),
          ),
        ),
        child: SafeArea(
          top: false,
          child: NavigationBar(
            height: 68,
            backgroundColor: card,
            indicatorColor: violet.withValues(alpha: 0.22),
            selectedIndex: currentIndex,
            onDestinationSelected: changePage,
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(
                  Icons.home_rounded,
                  color: violet,
                ),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Icon(Icons.explore_outlined),
                selectedIcon: Icon(
                  Icons.explore,
                  color: violet,
                ),
                label: 'About',
              ),
              NavigationDestination(
                icon: Icon(Icons.mail_outline),
                selectedIcon: Icon(
                  Icons.mail,
                  color: violet,
                ),
                label: 'Contact',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// REUSABLE BUTTON
class NovaButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const NovaButton({
    super.key,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: FilledButton(
        onPressed: onTap,
        style: FilledButton.styleFrom(
          backgroundColor: violet,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 12),
            const Icon(Icons.arrow_forward_rounded),
          ],
        ),
      ),
    );
  }
}

// REUSABLE CARD
class NovaCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color color;

  const NovaCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    this.color = violet,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: card,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.06),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.13),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: color, size: 26),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  description,
                  style: const TextStyle(
                    color: softText,
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

// HOME PAGE
class HomePage extends StatelessWidget {
  final VoidCallback onNext;

  const HomePage({
    super.key,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(22),
      children: [
        const Text(
          'WELCOME TO THE FUTURE',
          style: TextStyle(
            color: sky,
            fontSize: 11,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 15),
        const Text(
          'Design Beyond\nLimits.',
          style: TextStyle(
            fontSize: 39,
            height: 1.15,
            fontWeight: FontWeight.w900,
            letterSpacing: -1,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Explore a modern Flutter experience '
              'where creativity meets technology.',
          style: TextStyle(
            color: softText,
            fontSize: 14,
            height: 1.7,
          ),
        ),
        const SizedBox(height: 25),

        // HERO CARD + IMAGE
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xFF663FD3),
                Color(0xFF236AB6),
                Color(0xFF123954),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(28),
          ),
          child: Column(
            children: [
              const Row(
                children: [
                  Icon(
                    Icons.bolt_rounded,
                    color: Colors.white,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'BUILT WITH FLUTTER',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Image.network(
                'https://docs.flutter.dev/assets/images/flutter-logo-sharing.png',
                height: 145,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) {
                  return const Icon(
                    Icons.flutter_dash,
                    size: 110,
                    color: Colors.white,
                  );
                },
              ),
              const SizedBox(height: 14),
              const Text(
                'Build Something Amazing',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'One framework. Infinite possibilities.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFFE0E7FF),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 28),
        const Text(
          'What Makes Us Different?',
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 17),
        const NovaCard(
          icon: Icons.palette_rounded,
          title: 'Creative Design',
          description: 'Beautiful and modern user interfaces.',
        ),
        const NovaCard(
          icon: Icons.rocket_launch_rounded,
          title: 'Smooth Performance',
          description: 'Fast and responsive Flutter experience.',
          color: sky,
        ),
        const SizedBox(height: 12),
        NovaButton(
          label: 'Discover More',
          onTap: onNext,
        ),
      ],
    );
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
    return ListView(
      padding: const EdgeInsets.all(22),
      children: [
        const Text(
          'GET TO KNOW US',
          style: TextStyle(
            color: sky,
            letterSpacing: 2,
            fontSize: 11,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 15),
        const Text(
          'A Little About\nOur Vision.',
          style: TextStyle(
            fontSize: 36,
            height: 1.2,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: card,
            borderRadius: BorderRadius.circular(26),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.auto_awesome_rounded,
                color: sky,
                size: 45,
              ),
              SizedBox(height: 18),
              Text(
                'Our Mission',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 12),
              Text(
                'Nova is a creative Flutter project '
                    'focused on clean design, smooth navigation, '
                    'and reusable UI components.',
                style: TextStyle(
                  color: softText,
                  fontSize: 14,
                  height: 1.8,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 28),
        const Text(
          'Technologies Used',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        const NovaCard(
          icon: Icons.flutter_dash,
          title: 'Flutter & Dart',
          description: 'Modern cross-platform development.',
          color: sky,
        ),
        const NovaCard(
          icon: Icons.layers_rounded,
          title: 'Material Design 3',
          description: 'Consistent and elegant components.',
        ),
        const NovaCard(
          icon: Icons.animation_rounded,
          title: 'Smooth Animations',
          description: 'Beautiful transitions between pages.',
          color: Color(0xFF4ADE80),
        ),
        const SizedBox(height: 12),
        NovaButton(
          label: 'Contact Us',
          onTap: onNext,
        ),
      ],
    );
  }
}

// CONTACT PAGE
class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(22),
      children: [
        const Text(
          'LET US CONNECT',
          style: TextStyle(
            color: sky,
            letterSpacing: 2,
            fontSize: 11,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 15),
        const Text(
          "Let's Start\nA Conversation.",
          style: TextStyle(
            fontSize: 36,
            height: 1.2,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Have a great idea or a question? '
              'We would love to connect with you.',
          style: TextStyle(
            color: softText,
            fontSize: 14,
            height: 1.7,
          ),
        ),
        const SizedBox(height: 28),
        Container(
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF633CC6), Color(0xFF24639C)],
            ),
            borderRadius: BorderRadius.circular(26),
          ),
          child: const Column(
            children: [
              Icon(
                Icons.mark_email_read_rounded,
                size: 65,
                color: Colors.white,
              ),
              SizedBox(height: 14),
              Text(
                'We Are Here For You',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Every great project starts with a hello.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFFE0E7FF),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 27),
        const NovaCard(
          icon: Icons.email_outlined,
          title: 'Email Us',
          description: 'Get in touch by email.',
        ),
        const NovaCard(
          icon: Icons.phone_outlined,
          title: 'Call Us',
          description: 'We are happy to answer questions.',
          color: sky,
        ),
        const NovaCard(
          icon: Icons.location_on_outlined,
          title: 'Find Us',
          description: 'Connected wherever you are.',
          color: Color(0xFF4ADE80),
        ),
        const SizedBox(height: 20),
        const Center(
          child: Text(
            'Thank you for exploring NOVA!',
            style: TextStyle(color: softText),
          ),
        ),
      ],
    );
  }
}
