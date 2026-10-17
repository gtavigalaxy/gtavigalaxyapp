import 'package:flutter/material.dart';
import '../data/hub_data.dart';

/// GTA VI facts — tap a question to expand the answer.
class FactsScreen extends StatefulWidget {
  const FactsScreen({super.key});

  @override
  State<FactsScreen> createState() => _FactsScreenState();
}

class _FactsScreenState extends State<FactsScreen> {
  int? _expanded;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GTA VI Facts')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: gtaFacts.length,
        itemBuilder: (context, i) {
          final fact = gtaFacts[i];
          final isOpen = _expanded == i;
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: () =>
                  setState(() => _expanded = isOpen ? null : i),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFFFF2D78),
                                Color(0xFF9D4EDD)
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              '${i + 1}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                  fontSize: 15),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            fact['title']!,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                height: 1.3),
                          ),
                        ),
                        AnimatedRotation(
                          turns: isOpen ? 0.5 : 0,
                          duration:
                              const Duration(milliseconds: 250),
                          child: const Icon(
                            Icons.expand_more,
                            color: Colors.white54,
                          ),
                        ),
                      ],
                    ),
                    AnimatedCrossFade(
                      firstChild: const SizedBox.shrink(),
                      secondChild: Padding(
                        padding:
                            const EdgeInsets.only(top: 12, left: 48),
                        child: Text(
                          fact['body']!,
                          style: TextStyle(
                              color: Colors.white
                                  .withValues(alpha: 0.75),
                              fontSize: 13.5,
                              height: 1.55),
                        ),
                      ),
                      crossFadeState: isOpen
                          ? CrossFadeState.showSecond
                          : CrossFadeState.showFirst,
                      duration:
                          const Duration(milliseconds: 280),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
