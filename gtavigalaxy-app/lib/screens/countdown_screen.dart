import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../data/hub_data.dart';

/// Global countdown to the GTA VI launch with worldwide release times.
class CountdownScreen extends StatefulWidget {
  const CountdownScreen({super.key});

  @override
  State<CountdownScreen> createState() => _CountdownScreenState();
}

class _CountdownScreenState extends State<CountdownScreen> {
  late Timer _timer;
  DateTime _now = DateTime.now().toUtc();

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() => _now = DateTime.now().toUtc());
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final remaining = gta6LaunchUtc.difference(_now);
    final launched = remaining.isNegative;
    final d = launched ? Duration.zero : remaining;

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
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  const SizedBox(height: 32),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 8),
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
                  const SizedBox(height: 20),
                  Text(
                    launched ? 'IT\'S HERE!' : 'GLOBAL LAUNCH IN',
                    style: const TextStyle(
                        color: Colors.white54,
                        letterSpacing: 4,
                        fontSize: 13),
                  ),
                  const SizedBox(height: 16),
                  if (!launched)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _unit('${d.inDays}', 'DAYS'),
                        _unit('${d.inHours % 24}'.padLeft(2, '0'), 'HOURS'),
                        _unit('${d.inMinutes % 60}'.padLeft(2, '0'), 'MINS'),
                        _unit('${d.inSeconds % 60}'.padLeft(2, '0'), 'SECS'),
                      ],
                    )
                  else
                    const Text('🎮', style: TextStyle(fontSize: 64)),
                  const SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 48),
                    child: Text(
                      '19 November 2026\nPlayStation 5 • Xbox Series X|S',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white54, height: 1.6),
                    ),
                  ),
                  const SizedBox(height: 28),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'GLOBAL RELEASE TIMES',
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            letterSpacing: 2,
                            fontSize: 13,
                            color: Colors.white70),
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'New Zealand plays first — your region unlocks at local midnight.',
                        style:
                            TextStyle(color: Colors.white38, fontSize: 12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, i) =>
                      _regionTile(getReleaseRegions()[i]),
                  childCount: getReleaseRegions().length,
                ),
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

  Widget _regionTile(ReleaseRegion region) {
    final released = !_now.isBefore(region.utcRelease);
    final localTime =
        DateFormat('d MMM, HH:mm').format(region.utcRelease.toLocal());

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          children: [
            Text(region.flag, style: const TextStyle(fontSize: 26)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    region.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${region.localLabel} • $localTime your time',
                    style: const TextStyle(
                        color: Colors.white38, fontSize: 11.5),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: released
                    ? const Color(0xFF00C853).withValues(alpha: 0.15)
                    : Colors.white.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                released ? 'LIVE' : 'SOON',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1,
                  color: released
                      ? const Color(0xFF00E676)
                      : Colors.white54,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
