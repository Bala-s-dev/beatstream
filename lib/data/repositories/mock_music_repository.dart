import '../models/album.dart';
import '../models/song.dart';
import 'music_repository.dart';

/// In-memory mock implementation, heavily expanded with a robust dataset of
/// 30 trending Tamil songs and 15 popular albums for realistic testing.
class MockMusicRepository implements MusicRepository {
  final Duration _latency = const Duration(milliseconds: 500);

  final List<Song> _trending = const [
    // --- Top Modern Hits ---
    Song(
        id: 'trend-1',
        title: 'Hukum - Thalaivar Alappara',
        artist: 'Anirudh Ravichander',
        imageUrl:
            'https://images.unsplash.com/photo-1514525253161-7a46d19cd819?w=400'),
    Song(
        id: 'trend-2',
        title: 'Leo Das Badass',
        artist: 'Anirudh Ravichander',
        imageUrl:
            'https://images.unsplash.com/photo-1470225620780-dba8ba36b745?w=400'),
    Song(
        id: 'trend-3',
        title: 'Naa Ready',
        artist: 'Anirudh Ravichander, Thalapathy Vijay',
        imageUrl:
            'https://images.unsplash.com/photo-1498038432885-c6f3f1b912ee?w=400'),
    Song(
        id: 'trend-4',
        title: 'Manasilaayo',
        artist: 'Anirudh Ravichander, Malaysia Vasudevan (AI)',
        imageUrl:
            'https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?w=400'),
    Song(
        id: 'trend-5',
        title: 'Whistle Podu',
        artist: 'Yuvan Shankar Raja, Thalapathy Vijay',
        imageUrl:
            'https://images.unsplash.com/photo-1501386761578-eac5c94b800a?w=400'),
    Song(
        id: 'trend-6',
        title: 'Achacho',
        artist: 'Hiphop Tamizha, Kharesma Ravichandran',
        imageUrl:
            'https://images.unsplash.com/photo-1516280440614-37939bbacd6a?w=400'),
    Song(
        id: 'trend-7',
        title: 'Spark',
        artist: 'Yuvan Shankar Raja, Javi',
        imageUrl:
            'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=400'),
    Song(
        id: 'trend-8',
        title: 'Chilla Chilla',
        artist: 'Anirudh Ravichander, Ghibran',
        imageUrl:
            'https://images.unsplash.com/photo-1459749411175-04bf5292ceea?w=400'),
    Song(
        id: 'trend-9',
        title: 'Ranjithame',
        artist: 'Thalapathy Vijay, MMT Manasi',
        imageUrl:
            'https://images.unsplash.com/photo-1487180142328-054b783fc471?w=400'),
    Song(
        id: 'trend-10',
        title: 'Pathala Pathala',
        artist: 'Kamal Haasan, Anirudh Ravichander',
        imageUrl:
            'https://images.unsplash.com/photo-1511379938547-c1f69419868d?w=400'),

    // --- Romantic & Melodic ---
    Song(
        id: 'trend-11',
        title: 'Hayyoda',
        artist: 'Anirudh Ravichander, Priya Mali',
        imageUrl:
            'https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=400'),
    Song(
        id: 'trend-12',
        title: 'Kaavaaalaa',
        artist: 'Shilpa Rao, Anirudh Ravichander',
        imageUrl:
            'https://images.unsplash.com/photo-1518609878373-06d740f60d8b?w=400'),
    Song(
        id: 'trend-13',
        title: 'Kaatulae Kaatulae',
        artist: 'Ilaiyaraaja, Shreya Ghoshal',
        imageUrl:
            'https://images.unsplash.com/photo-1507838153414-b4b713384a76?w=400'),
    Song(
        id: 'trend-14',
        title: 'Golden Sparrow',
        artist: 'Sublahshini, GV Prakash',
        imageUrl:
            'https://images.unsplash.com/photo-1446057032654-9d8885b7a391?w=400'),
    Song(
        id: 'trend-15',
        title: 'Anbennum Khanavin',
        artist: 'Anirudh Ravichander, Lothika',
        imageUrl:
            'https://images.unsplash.com/photo-1514525253161-7a46d19cd819?w=400'),
    Song(
        id: 'trend-16',
        title: 'Megham Karukatha',
        artist: 'Dhanush, Santhosh Narayanan',
        imageUrl:
            'https://images.unsplash.com/photo-1470225620780-dba8ba36b745?w=400'),
    Song(
        id: 'trend-17',
        title: 'Katchi Sera',
        artist: 'Sai Abhyankkar',
        imageUrl:
            'https://images.unsplash.com/photo-1498038432885-c6f3f1b912ee?w=400'),
    Song(
        id: 'trend-18',
        title: 'Nira',
        artist: 'Sid Sriram',
        imageUrl:
            'https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?w=400'),
    Song(
        id: 'trend-19',
        title: 'Bodhai Kaname',
        artist: 'Anirudh Ravichander, Shashaa Tirupati',
        imageUrl:
            'https://images.unsplash.com/photo-1501386761578-eac5c94b800a?w=400'),
    Song(
        id: 'trend-20',
        title: 'Ordinary Person',
        artist: 'Anirudh Ravichander',
        imageUrl:
            'https://images.unsplash.com/photo-1516280440614-37939bbacd6a?w=400'),

    // --- High Energy & Global Beats ---
    Song(
        id: 'trend-21',
        title: 'Enjoy Enjaami',
        artist: 'Dhee, Arivu, Santhosh Narayanan',
        imageUrl:
            'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=400'),
    Song(
        id: 'trend-22',
        title: 'Tum Tum',
        artist: 'Sri Vardhini, Aditi Bhavaraju',
        imageUrl:
            'https://images.unsplash.com/photo-1459749411175-04bf5292ceea?w=400'),
    Song(
        id: 'trend-23',
        title: 'Arabic Kuthu',
        artist: 'Anirudh Ravichander, Jonita Gandhi',
        imageUrl:
            'https://images.unsplash.com/photo-1487180142328-054b783fc471?w=400'),
    Song(
        id: 'trend-24',
        title: 'Jalabulanjangu',
        artist: 'Anirudh Ravichander',
        imageUrl:
            'https://images.unsplash.com/photo-1511379938547-c1f69419868d?w=400'),
    Song(
        id: 'trend-25',
        title: 'Rowdy Baby',
        artist: 'Dhanush, Dhee',
        imageUrl:
            'https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=400'),
    Song(
        id: 'trend-26',
        title: 'Vaathi Coming',
        artist: 'Anirudh Ravichander',
        imageUrl:
            'https://images.unsplash.com/photo-1518609878373-06d740f60d8b?w=400'),
    Song(
        id: 'trend-27',
        title: 'Rakita Rakita',
        artist: 'Dhanush, Santhosh Narayanan',
        imageUrl:
            'https://images.unsplash.com/photo-1507838153414-b4b713384a76?w=400'),
    Song(
        id: 'trend-28',
        title: 'Verithanam',
        artist: 'Thalapathy Vijay, A.R. Rahman',
        imageUrl:
            'https://images.unsplash.com/photo-1446057032654-9d8885b7a391?w=400'),
    Song(
        id: 'trend-29',
        title: 'Sodakku',
        artist: 'Anthony Daasan, Anirudh Ravichander',
        imageUrl:
            'https://images.unsplash.com/photo-1514525253161-7a46d19cd819?w=400'),
    Song(
        id: 'trend-30',
        title: 'Aaluma Doluma',
        artist: 'Anirudh Ravichander, Badshah',
        imageUrl:
            'https://images.unsplash.com/photo-1470225620780-dba8ba36b745?w=400'),
  ];

  final List<Album> _albums = [
    const Album(
      id: 'album-1',
      title: "Leo",
      imageUrl:
          'https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?w=400',
      songs: [
        Song(
            id: 'leo-1',
            title: 'Naa Ready',
            artist: 'Anirudh Ravichander, Thalapathy Vijay',
            imageUrl:
                'https://images.unsplash.com/photo-1498038432885-c6f3f1b912ee?w=400'),
        Song(
            id: 'leo-2',
            title: 'Badass',
            artist: 'Anirudh Ravichander',
            imageUrl:
                'https://images.unsplash.com/photo-1470225620780-dba8ba36b745?w=400'),
        Song(
            id: 'leo-3',
            title: 'Ordinary Person',
            artist: 'Anirudh Ravichander',
            imageUrl:
                'https://images.unsplash.com/photo-1516280440614-37939bbacd6a?w=400'),
        Song(
            id: 'leo-4',
            title: 'Chilla Chilla',
            artist: 'Anirudh Ravichander, Ghibran',
            imageUrl:
                'https://images.unsplash.com/photo-1459749411175-04bf5292ceea?w=400'),
      ],
    ),
    const Album(
      id: 'album-2',
      title: "Vikram",
      imageUrl:
          'https://images.unsplash.com/photo-1507838153414-b4b713384a76?w=400',
      songs: const [
        Song(
            id: 'vikram-1',
            title: 'Once Upon a Time',
            artist: 'Anirudh Ravichander',
            imageUrl:
                'https://images.unsplash.com/photo-1507838153414-b4b713384a76?w=400'),
        Song(
            id: 'vikram-2',
            title: 'Mainaru Vaandi',
            artist: 'Arunraja Kamaraj, Anirudh Ravichander',
            imageUrl:
                'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=400'),
        Song(
            id: 'vikram-3',
            title: 'Pathala Pathala',
            artist: 'Kamal Haasan, Anirudh Ravichander',
            imageUrl:
                'https://images.unsplash.com/photo-1511379938547-c1f69419868d?w=400'),
      ],
    ),
    const Album(
      id: 'album-3',
      title: "Jailer",
      imageUrl:
          'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=400',
      songs: const [
        Song(
            id: 'jailer-1',
            title: 'Hukum - Thalaivar Alappara',
            artist: 'Anirudh Ravichander',
            imageUrl:
                'https://images.unsplash.com/photo-1514525253161-7a46d19cd819?w=400'),
        Song(
            id: 'jailer-2',
            title: 'Kaavaalaa',
            artist: 'Shilpa Rao, Anirudh Ravichander',
            imageUrl:
                'https://images.unsplash.com/photo-1518609878373-06d740f60d8b?w=400'),
        Song(
            id: 'jailer-3',
            title: 'Kannazhaga',
            artist: 'Anirudh Ravichander',
            imageUrl:
                'https://images.unsplash.com/photo-1487180142328-054b783fc471?w=400'),
      ],
    ),
    const Album(
      id: 'album-4',
      title: "The Greatest of All Time (GOAT)",
      imageUrl:
          'https://images.unsplash.com/photo-1470225620780-dba8ba36b745?w=400',
      songs: const [
        Song(
            id: 'goat-1',
            title: 'Spark',
            artist: 'Yuvan Shankar Raja, Javi',
            imageUrl:
                'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=400'),
        Song(
            id: 'goat-2',
            title: 'Whistle Podu',
            artist: 'Yuvan Shankar Raja, Thalapathy Vijay',
            imageUrl:
                'https://images.unsplash.com/photo-1501386761578-eac5c94b800a?w=400'),
      ],
    ),
    const Album(
      id: 'album-5',
      title: "Vettaiyan",
      imageUrl:
          'https://images.unsplash.com/photo-1514525253161-7a46d19cd819?w=400',
      songs: const [
        Song(
            id: 'vettaiyan-1',
            title: 'Manasilaayo',
            artist: 'Anirudh Ravichander, Malaysia Vasudevan (AI)',
            imageUrl:
                'https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?w=400'),
        Song(
            id: 'vettaiyan-2',
            title: 'Rathamada',
            artist: 'Anirudh Ravichander',
            imageUrl:
                'https://images.unsplash.com/photo-1446057032654-9d8885b7a391?w=400'),
      ],
    ),
    const Album(
      id: 'album-6',
      title: "Ponniyin Selvan: Part 1",
      imageUrl:
          'https://images.unsplash.com/photo-1446057032654-9d8885b7a391?w=400',
      songs: const [
        Song(
            id: 'ps1-1',
            title: 'Chola Chola',
            artist: 'A.R. Rahman',
            imageUrl:
                'https://images.unsplash.com/photo-1446057032654-9d8885b7a391?w=400'),
        Song(
            id: 'ps1-2',
            title: 'Ponni Nadhi',
            artist: 'A.R. Rahman',
            imageUrl:
                'https://images.unsplash.com/photo-1498038432885-c6f3f1b912ee?w=400'),
      ],
    ),
    const Album(
      id: 'album-7',
      title: "Ponniyin Selvan: Part 2",
      imageUrl:
          'https://images.unsplash.com/photo-1498038432885-c6f3f1b912ee?w=400',
      songs: const [
        Song(
            id: 'ps2-1',
            title: 'Veera Raja Veera',
            artist: 'A.R. Rahman',
            imageUrl:
                'https://images.unsplash.com/photo-1498038432885-c6f3f1b912ee?w=400'),
        Song(
            id: 'ps2-2',
            title: 'Sol Papa Sol',
            artist: 'A.R. Rahman',
            imageUrl:
                'https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?w=400'),
      ],
    ),
    const Album(
      id: 'album-8',
      title: "Master",
      imageUrl:
          'https://images.unsplash.com/photo-1501386761578-eac5c94b800a?w=400',
      songs: const [
        Song(
            id: 'master-1',
            title: 'Vaathi Coming',
            artist: 'Anirudh Ravichander',
            imageUrl:
                'https://images.unsplash.com/photo-1518609878373-06d740f60d8b?w=400'),
        Song(
            id: 'master-2',
            title: 'Kutti Story',
            artist: 'Anirudh Ravichander',
            imageUrl:
                'https://images.unsplash.com/photo-1501386761578-eac5c94b800a?w=400'),
        Song(
            id: 'master-3',
            title: 'Andha Kanna Paathaakaa',
            artist: 'Anirudh Ravichander',
            imageUrl:
                'https://images.unsplash.com/photo-1516280440614-37939bbacd6a?w=400'),
      ],
    ),
    const Album(
      id: 'album-9',
      title: "Thiruchitrambalam",
      imageUrl:
          'https://images.unsplash.com/photo-1516280440614-37939bbacd6a?w=400',
      songs: const [
        Song(
            id: 'thiru-1',
            title: 'Chellamma',
            artist: 'Anirudh Ravichander, Anthony Daasan',
            imageUrl:
                'https://images.unsplash.com/photo-1516280440614-37939bbacd6a?w=400'),
        Song(
            id: 'thiru-2',
            title: 'Nee Yaaro',
            artist: 'Anirudh Ravichander, Shweta Mohan',
            imageUrl:
                'https://images.unsplash.com/photo-1459749411175-04bf5292ceea?w=400'),
      ],
    ),
    const Album(
      id: 'album-10',
      title: "Doctor",
      imageUrl:
          'https://images.unsplash.com/photo-1459749411175-04bf5292ceea?w=400',
      songs: const [
        Song(
            id: 'doctor-1',
            title: 'Kadhaipoma',
            artist: 'Anirudh Ravichander',
            imageUrl:
                'https://images.unsplash.com/photo-1459749411175-04bf5292ceea?w=400'),
        Song(
            id: 'doctor-2',
            title: 'Machi Boys',
            artist: 'Anirudh Ravichander',
            imageUrl:
                'https://images.unsplash.com/photo-1487180142328-054b783fc471?w=400'),
      ],
    ),
    const Album(
      id: 'album-11',
      title: "Pushpa (Tamil)",
      imageUrl:
          'https://images.unsplash.com/photo-1487180142328-054b783fc471?w=400',
      songs: const [
        Song(
            id: 'pushpa-1',
            title: 'Srivalli',
            artist: 'Javed Ali, Devi Sri Prasad',
            imageUrl:
                'https://images.unsplash.com/photo-1487180142328-054b783fc471?w=400'),
        Song(
            id: 'pushpa-2',
            title: 'Saami Saami',
            artist: 'Mounika Yadav, Devi Sri Prasad',
            imageUrl:
                'https://images.unsplash.com/photo-1511379938547-c1f69419868d?w=400'),
      ],
    ),
    const Album(
      id: 'album-12',
      title: "Maamannan",
      imageUrl:
          'https://images.unsplash.com/photo-1511379938547-c1f69419868d?w=400',
      songs: const [
        Song(
            id: 'maamannan-1',
            title: 'Chithiram Pesudhadi',
            artist: 'A.R. Rahman',
            imageUrl:
                'https://images.unsplash.com/photo-1511379938547-c1f69419868d?w=400'),
        Song(
            id: 'maamannan-2',
            title: 'Con Damaadi Kaadhal',
            artist: 'A.R. Rahman',
            imageUrl:
                'https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=400'),
      ],
    ),
    const Album(
      id: 'album-13',
      title: "Varisu",
      imageUrl:
          'https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=400',
      songs: const [
        Song(
            id: 'varisu-1',
            title: 'Ranjithame',
            artist: 'Thalapathy Vijay, MMT Manasi',
            imageUrl:
                'https://images.unsplash.com/photo-1487180142328-054b783fc471?w=400'),
        Song(
            id: 'varisu-2',
            title: 'Soul Sagar',
            artist: 'Thaman S',
            imageUrl:
                'https://images.unsplash.com/photo-1518609878373-06d740f60d8b?w=400'),
      ],
    ),
    const Album(
      id: 'album-14',
      title: "Sarpatta Parambarai",
      imageUrl:
          'https://images.unsplash.com/photo-1518609878373-06d740f60d8b?w=400',
      songs: const [
        Song(
            id: 'sarpatta-1',
            title: 'Chennai City Gangsta',
            artist: 'Santhosh Narayanan',
            imageUrl:
                'https://images.unsplash.com/photo-1518609878373-06d740f60d8b?w=400'),
        Song(
            id: 'sarpatta-2',
            title: 'Meesaya Mutham',
            artist: 'Santhosh Narayanan',
            imageUrl:
                'https://images.unsplash.com/photo-1507838153414-b4b713384a76?w=400'),
      ],
    ),
    const Album(
      id: 'album-15',
      title: "Kabali",
      imageUrl:
          'https://images.unsplash.com/photo-1522075469751-3a6694fb2f61?w=400',
      songs: const [
        Song(
            id: 'kabali-1',
            title: 'Neruppu Da',
            artist: 'Santhosh Narayanan, Arivu',
            imageUrl:
                'https://images.unsplash.com/photo-1522075469751-3a6694fb2f61?w=400'),
        Song(
            id: 'kabali-2',
            title: 'Maya Nadhi',
            artist: 'Santhosh Narayanan',
            imageUrl:
                'https://images.unsplash.com/photo-1446057032654-9d8885b7a391?w=400'),
      ],
    ),
  ];

  final List<Artist> _artists = const [
    Artist(
        id: 'artist-1',
        name: 'A.R. Rahman',
        imageUrl:
            'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=400'),
    Artist(
        id: 'artist-2',
        name: 'Anirudh Ravichander',
        imageUrl:
            'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=400'),
    Artist(
        id: 'artist-3',
        name: 'Yuvan Shankar Raja',
        imageUrl:
            'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=400'),
    Artist(
        id: 'artist-4',
        name: 'Harris Jayaraj',
        imageUrl:
            'https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?w=400'),
    Artist(
        id: 'artist-5',
        name: 'Ilaiyaraaja',
        imageUrl:
            'https://images.unsplash.com/photo-1507679799987-c73779587ccf?w=400'),
    Artist(
        id: 'artist-6',
        name: 'Santhosh Narayanan',
        imageUrl:
            'https://images.unsplash.com/photo-1522075469751-3a6694fb2f61?w=400'),
  ];

  List<Song> _recentlyPlayed = const [
    Song(
        id: 'recent-1',
        title: 'Hayyoda',
        artist: 'Anirudh Ravichander, Priya Mali',
        imageUrl:
            'https://images.unsplash.com/photo-1516280440614-37939bbacd6a?w=400'),
    Song(
        id: 'recent-2',
        title: 'Kaavaaalaa',
        artist: 'Shilpa Rao, Anirudh Ravichander',
        imageUrl:
            'https://images.unsplash.com/photo-1487180142328-054b783fc471?w=400'),
    Song(
        id: 'recent-3',
        title: 'Pathala Pathala',
        artist: 'Kamal Haasan, Anirudh Ravichander',
        imageUrl:
            'https://images.unsplash.com/photo-1459749411175-04bf5292ceea?w=400'),
  ];

  List<Song> _favorites = const [
    Song(
        id: 'fav-1',
        title: 'New York Nagaram',
        artist: 'A.R. Rahman',
        isFavorite: true,
        imageUrl:
            'https://images.unsplash.com/photo-1446057032654-9d8885b7a391?w=400'),
    Song(
        id: 'fav-2',
        title: 'Moongil Thottam',
        artist: 'A.R. Rahman, Abhay Jodhpurkar',
        isFavorite: true,
        imageUrl:
            'https://images.unsplash.com/photo-1511379938547-c1f69419868d?w=400'),
    Song(
        id: 'fav-3',
        title: 'Poo Nee Poo',
        artist: 'Anirudh Ravichander, Mohit Chauhan',
        isFavorite: true,
        imageUrl:
            'https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=400'),
    Song(
        id: 'fav-4',
        title: 'Aathangara Marame',
        artist: 'A.R. Rahman',
        isFavorite: true,
        imageUrl:
            'https://images.unsplash.com/photo-1501386761578-eac5c94b800a?w=400'),
    Song(
        id: 'fav-5',
        title: 'Vaseegara',
        artist: 'Bombay Jayashri',
        isFavorite: true,
        imageUrl:
            'https://images.unsplash.com/photo-1518609878373-06d740f60d8b?w=400'),
  ];

  @override
  Future<List<String>> getLanguages() async {
    await Future.delayed(_latency);
    return const [
      'Tamil',
      'English',
      'Telugu',
      'Malayalam',
      'Hindi',
      'Kannada'
    ];
  }

  @override
  Future<List<Song>> getTrendingSongs() async {
    await Future.delayed(_latency);
    return List.unmodifiable(_trending);
  }

  @override
  Future<List<Album>> getPopularAlbums() async {
    await Future.delayed(_latency);
    return List.unmodifiable(_albums);
  }

  @override
  Future<List<Artist>> getArtists() async {
    await Future.delayed(_latency);
    return List.unmodifiable(_artists);
  }

  @override
  Future<List<Song>> getRecentlyPlayed() async {
    await Future.delayed(_latency);
    return List.unmodifiable(_recentlyPlayed);
  }

  @override
  Future<List<Song>> getFavorites() async {
    await Future.delayed(_latency);
    return List.unmodifiable(_favorites);
  }

  @override
  Future<List<Album>> searchAlbums(String query) async {
    await Future.delayed(const Duration(milliseconds: 250));
    final String q = query.trim().toLowerCase();
    if (q.isEmpty) return const [];

    return _albums.where((a) => a.title.toLowerCase().contains(q)).toList();
  }

  @override
  Future<Song> toggleFavorite(String songId) async {
    await Future.delayed(const Duration(milliseconds: 150));

    // Find the real song wherever it currently lives, so we never fabricate
    // a fake "Unknown Track" placeholder when a song isn't already in
    // _favorites/_recentlyPlayed (e.g. a Trending or Search-result song
    // being favorited for the first time).
    Song? source;
    for (final list in [
      _favorites,
      _recentlyPlayed,
      _trending,
      ..._albums.map((a) => a.songs)
    ]) {
      final match = list.where((s) => s.id == songId);
      if (match.isNotEmpty) {
        source = match.first;
        break;
      }
    }

    if (source == null) {
      // Truly unknown id — fail safe rather than fabricating fake song data.
      throw Exception('Song not found: $songId');
    }

    final Song updated = source.copyWith(isFavorite: !source.isFavorite);

    // Keep the favorites list in sync: add when newly favorited, update in
    // place if already present, remove when unfavorited.
    if (updated.isFavorite) {
      if (!_favorites.any((s) => s.id == songId)) {
        _favorites = [..._favorites, updated];
      } else {
        _favorites =
            _favorites.map((s) => s.id == songId ? updated : s).toList();
      }
    } else {
      _favorites = _favorites.where((s) => s.id != songId).toList();
    }

    // Reflect the new favorite status anywhere else the song appears too,
    // so Recently Played tiles stay visually in sync.
    _recentlyPlayed =
        _recentlyPlayed.map((s) => s.id == songId ? updated : s).toList();

    return updated;
  }

  @override
  Future<List<Song>> search(String query) async {
    await Future.delayed(const Duration(milliseconds: 250));
    final String q = query.trim().toLowerCase();
    if (q.isEmpty) return const [];

    final all = <Song>{..._trending, ..._recentlyPlayed, ..._favorites};
    return all
        .where(
          (s) =>
              s.title.toLowerCase().contains(q) ||
              s.artist.toLowerCase().contains(q),
        )
        .toList();
  }
}
