/// Static data for the Hub tab: global release times, trailers, facts.
///
/// Release times mirror gtavigalaxy.com's GTA VI Global Countdown page:
/// most regions unlock at local midnight on 19 Nov 2026.
library;

/// A regional midnight release, stored as the exact UTC instant.
class ReleaseRegion {
  final String flag;
  final String name;
  final String localLabel;
  final DateTime utcRelease;

  const ReleaseRegion({
    required this.flag,
    required this.name,
    required this.localLabel,
    required this.utcRelease,
  });
}

/// Global midnight release: 19 Nov 2026, 00:00 UTC.
final DateTime gta6LaunchUtc = DateTime.utc(2026, 11, 19, 0, 0, 0);

/// Regions with real UTC instants.
List<ReleaseRegion> getReleaseRegions() => [
      ReleaseRegion(
        flag: '🇳🇿',
        name: 'New Zealand',
        localLabel: '12:00 AM NZDT — Nov 19',
        utcRelease: DateTime.utc(2026, 11, 18, 11, 0),
      ),
      ReleaseRegion(
        flag: '🇦🇺',
        name: 'Australia',
        localLabel: '12:00 AM AEDT — Nov 19',
        utcRelease: DateTime.utc(2026, 11, 18, 13, 0),
      ),
      ReleaseRegion(
        flag: '🇯🇵',
        name: 'Japan & South Korea',
        localLabel: '12:00 AM JST / KST — Nov 19',
        utcRelease: DateTime.utc(2026, 11, 18, 15, 0),
      ),
      ReleaseRegion(
        flag: '🇭🇰',
        name: 'Hong Kong, Singapore, Malaysia & Taiwan',
        localLabel: '12:00 AM local — Nov 19',
        utcRelease: DateTime.utc(2026, 11, 18, 16, 0),
      ),
      ReleaseRegion(
        flag: '🇹🇭',
        name: 'Thailand & Indonesia',
        localLabel: '12:00 AM local — Nov 19',
        utcRelease: DateTime.utc(2026, 11, 18, 17, 0),
      ),
      ReleaseRegion(
        flag: '🇮🇳',
        name: 'India',
        localLabel: '12:00 AM IST — Nov 19',
        utcRelease: DateTime.utc(2026, 11, 18, 18, 30),
      ),
      ReleaseRegion(
        flag: '🇦🇪',
        name: 'United Arab Emirates',
        localLabel: '12:00 AM GST — Nov 19',
        utcRelease: DateTime.utc(2026, 11, 18, 20, 0),
      ),
      ReleaseRegion(
        flag: '🇸🇦',
        name: 'Saudi Arabia & Turkey',
        localLabel: '12:00 AM local — Nov 19',
        utcRelease: DateTime.utc(2026, 11, 18, 21, 0),
      ),
      ReleaseRegion(
        flag: '🇿🇦',
        name: 'South Africa & Eastern Europe',
        localLabel: '12:00 AM local — Nov 19',
        utcRelease: DateTime.utc(2026, 11, 18, 22, 0),
      ),
      ReleaseRegion(
        flag: '🇪🇺',
        name: 'Central Europe',
        localLabel: '12:00 AM CET — Nov 19',
        utcRelease: DateTime.utc(2026, 11, 18, 23, 0),
      ),
      ReleaseRegion(
        flag: '🇬🇧',
        name: 'UK, Ireland, Portugal & Iceland',
        localLabel: '12:00 AM GMT — Nov 19',
        utcRelease: DateTime.utc(2026, 11, 19, 0, 0),
      ),
      ReleaseRegion(
        flag: '🇧🇷',
        name: 'Brazil',
        localLabel: '12:00 AM BRT — Nov 19',
        utcRelease: DateTime.utc(2026, 11, 19, 3, 0),
      ),
      ReleaseRegion(
        flag: '🇧🇴',
        name: 'Bolivia',
        localLabel: '12:00 AM BOT — Nov 19',
        utcRelease: DateTime.utc(2026, 11, 19, 4, 0),
      ),
      ReleaseRegion(
        flag: '🇺🇸',
        name: 'US East Coast & Canada East',
        localLabel: '12:00 AM EST — Nov 19',
        utcRelease: DateTime.utc(2026, 11, 19, 5, 0),
      ),
      ReleaseRegion(
        flag: '🇺🇸',
        name: 'US Central & Mexico',
        localLabel: '12:00 AM CST — Nov 19',
        utcRelease: DateTime.utc(2026, 11, 19, 6, 0),
      ),
      ReleaseRegion(
        flag: '🇺🇸',
        name: 'US Mountain',
        localLabel: '12:00 AM MST — Nov 19',
        utcRelease: DateTime.utc(2026, 11, 19, 7, 0),
      ),
      ReleaseRegion(
        flag: '🇺🇸',
        name: 'US West Coast',
        localLabel: '12:00 AM PST — Nov 19',
        utcRelease: DateTime.utc(2026, 11, 19, 8, 0),
      ),
    ];

/// An official GTA VI trailer.
class Trailer {
  final String youtubeId;
  final String title;
  final String date;
  final String duration;

  const Trailer({
    required this.youtubeId,
    required this.title,
    required this.date,
    required this.duration,
  });

  String get thumbnailUrl =>
      'https://img.youtube.com/vi/$youtubeId/maxresdefault.jpg';
  String get watchUrl => 'https://www.youtube.com/watch?v=$youtubeId';
}

const List<Trailer> trailers = [
  Trailer(
    youtubeId: 'rz1B4B2yBZY',
    title: 'Grand Theft Auto VI — Launch Trailer',
    date: '15 Oct 2026',
    duration: '1:30',
  ),
  Trailer(
    youtubeId: 'VQRLujxTm3c',
    title: 'Grand Theft Auto VI — Trailer 2',
    date: '6 May 2025',
    duration: '2:47',
  ),
  Trailer(
    youtubeId: 'QdBZY2fkU-0',
    title: 'Grand Theft Auto VI — Trailer 1',
    date: '4 Dec 2023',
    duration: '1:31',
  ),
];

/// Key facts about GTA VI.
const List<Map<String, String>> gtaFacts = [
  {
    'title': 'Welcome to Leonida',
    'body':
        'GTA VI is set in the state of Leonida, Rockstar\'s parody of Florida — home to the neon-soaked streets of Vice City, the Grassrivers wetlands, the Leonida Keys, Port Gellhorn, Ambrosia and Mount Kalaga National Park.',
  },
  {
    'title': 'Two protagonists',
    'body':
        'For the first time in the series you play as a duo: Lucia Caminos and Jason Duval, a couple in the style of Bonnie and Clyde, forced to rely on each other after an easy score goes wrong.',
  },
  {
    'title': 'Lucia makes history',
    'body':
        'Lucia Caminos is the first playable female protagonist in GTA history. Her story begins as she gets out of prison at the start of the game.',
  },
  {
    'title': 'Release date',
    'body':
        'Grand Theft Auto VI launches on 19 November 2026 for PlayStation 5 and Xbox Series X|S. No PC version has been announced yet — following Rockstar\'s usual console-first pattern.',
  },
  {
    'title': 'Record-breaking reveals',
    'body':
        'Trailer 1 (Dec 2023) pulled over 93 million YouTube views in 24 hours — a Guinness World Record for a game reveal. Trailer 2 (May 2025) passed 475 million views across all platforms in its first day, the biggest video launch of all time.',
  },
  {
    'title': 'Vice City returns',
    'body':
        'This is the first GTA set in Vice City since 2006\'s Vice City Stories — but reimagined in the modern day, over 20 years later in the series timeline.',
  },
  {
    'title': 'The soundtrack',
    'body':
        'The official album "Grand Theft Auto VI: The Album" features 34 original tracks and releases the same day as the game. French duo Justice composed the original score.',
  },
  {
    'title': 'Built for new consoles',
    'body':
        'All official footage so far was captured on a PlayStation 5. Rockstar says the technology built for this game will carry over into their future projects.',
  },
  {
    'title': 'Biggest map yet',
    'body':
        'Community mapping estimates suggest Leonida could be roughly twice the size of GTA V\'s San Andreas, with the Keys, swamplands and countryside fully explorable beyond the city.',
  },
  {
    'title': 'A long time coming',
    'body':
        'GTA VI is Rockstar\'s first major new single-player release since Red Dead Redemption 2 in 2018 — an 8-year gap the studio says won\'t be repeated.',
  },
];
