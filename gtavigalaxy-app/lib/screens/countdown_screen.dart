import 'dart:async';
import 'package:flutter/material.dart';

/// Live countdown to the GTA VI launch (19 November 2026).
class CountdownScreen extends StatefulWidget {
  const CountdownScreen({super.key});

  @override
  State<CountdownScreen> createState() => _CountdownScreenState();
}

class _CountdownScreenState extends State<CountdownScreen> {
  static final DateTime _launch = DateTime(2026, 11, 19, 0, 0, 0);
  late Timer _timer;
  Duration _remaining = _launch.difference(DateTime.now());

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        _remaining = _launch.difference(DateTime.now());
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final launched = _remaining.isNegative;
    final d = launched ? Duration.zero : _remaining;
    final days = d.inDays;
    final hours = d.inHours % 24;
    final minutes = d.inMinutes % 60;
    final seconds = d.inSeconds % 60;

    return Scaffold(
      appBar: AppBar(title: const Text('Launch Countdown')),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2B1055), Color(0xFF0E0E16)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  colors: [Color(0xFFFF2D78), Color(0xFF9D4EDD)],
                ),
              ),
              child: const Text(
                'GRAND THEFT AUTO VI',
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2,
                    fontSize: 14),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              launched ? 'IT\'S HERE!' : 'LAUNCHES IN',
              style: const TextStyle(
                  color: Colors.white54, letterSpacing: 4, fontSize: 13),
            ),
            const SizedBox(height: 16),
            if (!launched)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _unit('$days', 'DAYS'),
                  _unit('$hours'.padLeft(2, '0'), 'HOURS'),
                  _unit('$minutes'.padLeft(2, '0'), 'MINS'),
                  _unit('$seconds'.padLeft(2, '0'), 'SECS'),
                ],
              )
            else
              const Text('🎮',
                  style: TextStyle(fontSize: 64)),
            const SizedBox(height: 24),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 48),
              child: Text(
                '19 November 2026\nPlayStation 5 • Xbox Series X|S',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white54, height: 1.6),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _unit(String value, String label) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 4),
      width: 72,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white12),
      ),
      child: Column(
        children: [
          Text(value,
              style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                  color: Colors.white)),
          const SizedBox(height: 4),
          Text(label,
              style: const TextStyle(fontSize: 10, color: Colors.white54)),
        ],
      ),
    );
  }
}
