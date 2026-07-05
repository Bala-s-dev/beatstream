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
            'https://c.saavncdn.com/187/Jailer-Tamil-2023-20230728081443-500x500.jpg'),
    Song(
        id: 'trend-2',
        title: 'Leo Das Badass',
        artist: 'Anirudh Ravichander',
        imageUrl:
            'https://c.saavncdn.com/544/Badass-From-Leo-Tamil-2023-20230928162246-500x500.jpg'),
    Song(
        id: 'trend-3',
        title: 'Naa Ready',
        artist: 'Anirudh Ravichander, Thalapathy Vijay',
        imageUrl:
            'https://c.saavncdn.com/386/Naa-Ready-From-Leo-Tamil-2023-20230622174435-500x500.jpg'),
    Song(
        id: 'trend-4',
        title: 'Manasilaayo',
        artist: 'Anirudh Ravichander, Malaysia Vasudevan (AI)',
        imageUrl:
            'https://c.saavncdn.com/130/Manasilaayo-From-Vettaiyan-Tamil-2024-20240909141500-500x500.jpg'),
    Song(
        id: 'trend-5',
        title: 'Whistle Podu',
        artist: 'Yuvan Shankar Raja, Thalapathy Vijay',
        imageUrl:
            'https://c.saavncdn.com/874/Whistle-Podu-From-The-Greatest-Of-All-Time-Tamil-2024-20240416201003-500x500.jpg'),
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
            'https://c.saavncdn.com/206/Spark-From-The-Greatest-Of-All-Time-Tamil-2024-20240803121017-500x500.jpg'),
    Song(
        id: 'trend-8',
        title: 'Chilla Chilla',
        artist: 'Anirudh Ravichander, Ghibran',
        imageUrl:
            'https://c.saavncdn.com/blob/842/Thunivu-Tamil-2022-20230217151809-500x500.jpg'),
    Song(
        id: 'trend-9',
        title: 'Ranjithame',
        artist: 'Thalapathy Vijay, MMT Manasi',
        imageUrl:
            'https://c.saavncdn.com/183/Ranjithame-From-Vaarasudu-Telugu-Telugu-2022-20221203121007-500x500.jpg'),
    Song(
        id: 'trend-10',
        title: 'Pathala Pathala',
        artist: 'Kamal Haasan, Anirudh Ravichander',
        imageUrl:
            'https://c.saavncdn.com/973/Vikram-Tamil-2022-20220515182605-500x500.jpg'),

    // --- Romantic & Melodic ---
    Song(
        id: 'trend-11',
        title: 'Hayyoda',
        artist: 'Anirudh Ravichander, Priya Mali',
        imageUrl:
            'https://c.saavncdn.com/033/Hayyoda-From-Jawan-Tamil-2023-20230814014351-500x500.jpg'),
    Song(
        id: 'trend-12',
        title: 'Kaavaaalaa',
        artist: 'Shilpa Rao, Anirudh Ravichander',
        imageUrl:
            'https://c.saavncdn.com/183/Kaavaalaa-From-Jailer-Tamil-2023-20230708073100-500x500.jpg'),
    Song(
        id: 'trend-13',
        title: 'Kaatulae Kaatulae',
        artist: 'Ilaiyaraaja, Shreya Ghoshal',
        imageUrl:
            'https://c.saavncdn.com/137/96-Original-Motion-Picture-Soundtrack-Tamil-2018-20250905072505-500x500.jpg'),
    Song(
        id: 'trend-14',
        title: 'Golden Sparrow',
        artist: 'Sublahshini, GV Prakash',
        imageUrl:
            'https://c.saavncdn.com/934/Golden-Sparrow-From-Nilavuku-En-Mel-Ennadi-Kobam-Tamil-2024-20260206163424-500x500.jpg'),
    Song(
        id: 'trend-15',
        title: 'Anbennum Khanavin',
        artist: 'Anirudh Ravichander, Lothika',
        imageUrl:
            'https://c.saavncdn.com/213/Anbenum-From-Leo-Tamil-2023-20231011165155-500x500.jpg'),
    Song(
        id: 'trend-16',
        title: 'Megham Karukatha',
        artist: 'Dhanush, Santhosh Narayanan',
        imageUrl:
            'https://c.saavncdn.com/383/Megham-Karukatha-From-Thiruchitrambalam-Tamil-2022-20220715184158-500x500.jpg'),
    Song(
        id: 'trend-17',
        title: 'Katchi Sera',
        artist: 'Sai Abhyankkar',
        imageUrl:
            'https://c.saavncdn.com/118/Katchi-Sera-From-Think-Indie-Tamil-2024-20251026074526-500x500.jpg'),
    Song(
        id: 'trend-18',
        title: 'Nira',
        artist: 'Sid Sriram',
        imageUrl:
            'https://i.scdn.co/image/ab67616d0000b2730a70212f255134eb6073cf90'),
    Song(
        id: 'trend-19',
        title: 'Bodhai Kaname',
        artist: 'Anirudh Ravichander, Shashaa Tirupati',
        imageUrl:
            'https://m.media-amazon.com/images/I/41Uv4YMGj6L._UXNaN_FMjpg_QL85_.jpg'),
    Song(
        id: 'trend-20',
        title: 'Ordinary Person',
        artist: 'Anirudh Ravichander',
        imageUrl:
            'https://c.saavncdn.com/916/Ordinary-Person-From-Leo-Tamil-2023-20231023221744-500x500.jpg'),

    // --- High Energy & Global Beats ---
    Song(
        id: 'trend-21',
        title: 'Enjoy Enjaami',
        artist: 'Dhee, Arivu, Santhosh Narayanan',
        imageUrl:
            'https://c.saavncdn.com/941/Enjoy-Enjaami-feat-Arivu--Tamil-2021-20210521093818-500x500.jpg'),
    Song(
        id: 'trend-22',
        title: 'Tum Tum',
        artist: 'Sri Vardhini, Aditi Bhavaraju',
        imageUrl:
            'https://c.saavncdn.com/117/Tum-Tum-From-Enemy-Tamil-Tamil-2021-20260107193516-500x500.jpg'),
    Song(
        id: 'trend-23',
        title: 'Arabic Kuthu',
        artist: 'Anirudh Ravichander, Jonita Gandhi',
        imageUrl:
            'https://c.saavncdn.com/629/Arabic-Kuthu-Halamithi-Habibo-From-Beast--Tamil-2022-20220223183836-500x500.jpg'),
    Song(
        id: 'trend-24',
        title: 'Jalabulanjangu',
        artist: 'Anirudh Ravichander',
        imageUrl:
            'https://c.saavncdn.com/105/Jalabulajangu-From-Don--Tamil-2021-20220124145351-500x500.jpg'),
    Song(
        id: 'trend-25',
        title: 'Rowdy Baby',
        artist: 'Dhanush, Dhee',
        imageUrl:
            'https://c.saavncdn.com/276/Maari-2-Tamil-2018-20260203193952-500x500.jpg'),
    Song(
        id: 'trend-26',
        title: 'Vaathi Coming',
        artist: 'Anirudh Ravichander',
        imageUrl:
            'https://c.saavncdn.com/968/Vaathi-Coming-From-Master--Tamil-2020-20200310125849-500x500.jpg'),
    Song(
        id: 'trend-27',
        title: 'Rakita Rakita',
        artist: 'Dhanush, Santhosh Narayanan',
        imageUrl:
            'https://c.saavncdn.com/909/Rakita-Rakita-Rakita-From-Jagame-Thandhiram--Tamil-2020-20200728022720-500x500.jpg'),
    Song(
        id: 'trend-28',
        title: 'Verithanam',
        artist: 'Thalapathy Vijay, A.R. Rahman',
        imageUrl:
            'https://c.saavncdn.com/162/Bigil-Tamil-2019-20191017202521-500x500.jpg'),
    Song(
        id: 'trend-29',
        title: 'Sodakku',
        artist: 'Anthony Daasan, Anirudh Ravichander',
        imageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTYh8xVnYl_gLMh_3I5gL39vZj7uCcr75eBQ8qs3PEbyLbrkT3mZmtphu4&s=10'),
    Song(
        id: 'trend-30',
        title: 'Aaluma Doluma',
        artist: 'Anirudh Ravichander, Badshah',
        imageUrl:
            'https://c.saavncdn.com/323/Vedalam-Tamil-2015-20260120201356-500x500.jpg'),
  ];

  final List<Album> _albums = [
    const Album(
      id: 'album-1',
      title: "Leo",
      imageUrl:
          'https://c.saavncdn.com/415/Leo-Original-Motion-Picture-Soundtrack-English-2023-20231019170311-500x500.jpg',
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
                'https://c.saavncdn.com/544/Badass-From-Leo-Tamil-2023-20230928162246-500x500.jpg'),
        Song(
            id: 'leo-3',
            title: 'Ordinary Person',
            artist: 'Anirudh Ravichander',
            imageUrl:
                'https://c.saavncdn.com/916/Ordinary-Person-From-Leo-Tamil-2023-20231023221744-500x500.jpg'),
      ],
    ),
    const Album(
      id: 'album-2',
      title: "Vikram",
      imageUrl:
          'https://c.saavncdn.com/973/Vikram-Tamil-2022-20220515182605-500x500.jpg',
      songs: const [
        Song(
            id: 'vikram-1',
            title: 'Once Upon a Time',
            artist: 'Anirudh Ravichander',
            imageUrl:
                'https://c.saavncdn.com/666/Vikram-Hitlist-Telugu-2022-20220607175939-500x500.jpg'),
        Song(
            id: 'vikram-2',
            title: 'Pathala Pathala',
            artist: 'Kamal Haasan, Anirudh Ravichander',
            imageUrl:
                'https://c.saavncdn.com/904/Pathala-Pathala-From-Vikram-Tamil-2022-20220511165924-500x500.jpg'),
      ],
    ),
    const Album(
      id: 'album-3',
      title: "Jailer",
      imageUrl:
          'https://c.saavncdn.com/187/Jailer-Tamil-2023-20230728081443-500x500.jpg',
      songs: const [
        Song(
            id: 'jailer-1',
            title: 'Hukum - Thalaivar Alappara',
            artist: 'Anirudh Ravichander',
            imageUrl:
                'https://c.saavncdn.com/959/Hukum-Thalaivar-Alappara-From-Jailer-Tamil-2023-20230717071502-500x500.jpg'),
        Song(
            id: 'jailer-2',
            title: 'Kaavaalaa',
            artist: 'Shilpa Rao, Anirudh Ravichander',
            imageUrl:
                'https://c.saavncdn.com/183/Kaavaalaa-From-Jailer-Tamil-2023-20230708073100-500x500.jpg'),
      ],
    ),
    const Album(
      id: 'album-4',
      title: "The Greatest of All Time (GOAT)",
      imageUrl:
          'https://c.saavncdn.com/368/Thalapathy-Is-The-G-O-A-T-Hindi-2024-20240903191004-500x500.jpg',
      songs: const [
        Song(
            id: 'goat-1',
            title: 'Spark',
            artist: 'Yuvan Shankar Raja, Javi',
            imageUrl:
                'https://c.saavncdn.com/220/Spark-From-Thalapathy-Is-The-G-O-A-T-Hindi-2024-20240803121025-500x500.jpg'),
        Song(
            id: 'goat-2',
            title: 'Whistle Podu',
            artist: 'Yuvan Shankar Raja, Thalapathy Vijay',
            imageUrl:
                'https://c.saavncdn.com/445/Whistle-Podu-From-Thalapathy-Is-The-G-O-A-T-Hindi-2024-20240724171033-500x500.jpg'),
      ],
    ),
    const Album(
      id: 'album-5',
      title: "Vettaiyan",
      imageUrl:
          'https://c.saavncdn.com/803/Vettaiyan-Original-Motion-Picture-Soundtrack-Tamil-2024-20241014154253-500x500.jpg',
      songs: const [
        Song(
            id: 'vettaiyan-1',
            title: 'Manasilaayo',
            artist: 'Anirudh Ravichander, Malaysia Vasudevan (AI)',
            imageUrl:
                'https://c.saavncdn.com/130/Manasilaayo-From-Vettaiyan-Tamil-2024-20240909141500-500x500.jpg'),
        Song(
            id: 'vettaiyan-2',
            title: 'Rathamada',
            artist: 'Anirudh Ravichander',
            imageUrl:
                'https://c.saavncdn.com/508/Uchathila-From-Vettaiyan-Tamil-2024-20241011123236-500x500.jpg'),
      ],
    ),
    const Album(
      id: 'album-6',
      title: "Ponniyin Selvan: Part 1",
      imageUrl:
          'https://c.saavncdn.com/113/Ponniyin-Selvan-Part-1-Tamil-2022-20260330193159-500x500.jpg',
      songs: const [
        Song(
            id: 'ps1-1',
            title: 'Chola Chola',
            artist: 'A.R. Rahman',
            imageUrl:
                'https://c.saavncdn.com/113/Ponniyin-Selvan-Part-1-Tamil-2022-20260330193159-500x500.jpg'),
        Song(
            id: 'ps1-2',
            title: 'Ponni Nadhi',
            artist: 'A.R. Rahman',
            imageUrl:
                'https://c.saavncdn.com/812/Ponni-Nadhi-From-Ponniyin-Selvan-Part-1-Tamil-2022-20260122133313-500x500.jpg'),
      ],
    ),
    const Album(
      id: 'album-7',
      title: "Ponniyin Selvan: Part 2",
      imageUrl:
          'https://c.saavncdn.com/958/Ponniyin-Selvan-Part-2-Tamil-2023-20260225163158-500x500.jpg',
      songs: const [
        Song(
            id: 'ps2-1',
            title: 'Veera Raja Veera',
            artist: 'A.R. Rahman',
            imageUrl:
                'https://c.saavncdn.com/editorial/PonniyinSelvanPart2_20230418093732.jpg'),
        Song(
            id: 'ps2-2',
            title: 'Sol Papa Sol',
            artist: 'A.R. Rahman',
            imageUrl:
                'https://c.saavncdn.com/613/Aga-Naga-From-Ponniyin-Selvan-Part-2-Tamil-2023-20260122133314-500x500.jpg'),
      ],
    ),
    const Album(
      id: 'album-8',
      title: "Master",
      imageUrl:
          'https://c.saavncdn.com/118/Master-Telugu--Telugu-2021-20210324170733-500x500.jpg',
      songs: const [
        Song(
            id: 'master-1',
            title: 'Vaathi Coming',
            artist: 'Anirudh Ravichander',
            imageUrl:
                'https://c.saavncdn.com/968/Vaathi-Coming-From-Master--Tamil-2020-20200310125849-500x500.jpg'),
        Song(
            id: 'master-2',
            title: 'Kutti Story',
            artist: 'Anirudh Ravichander',
            imageUrl:
                'https://c.saavncdn.com/596/Kutti-Story-From-Master--Tamil-2020-20200214125442-500x500.jpg'),
        Song(
            id: 'master-3',
            title: 'Andha Kanna Paathaakaa',
            artist: 'Anirudh Ravichander',
            imageUrl:
                'https://i1.behindwoods.com/tamil-movies-cinema-news-16/images/master-kutti-story-lyric-thalapathy-vijay-anirudh-ravichander-lokesh-kanagaraj-new-home-mob-index.png'),
      ],
    ),
    const Album(
      id: 'album-9',
      title: "Thiruchitrambalam",
      imageUrl:
          'https://c.saavncdn.com/238/Thiruchitrambalam-Tamil-2022-20220927091058-500x500.jpg',
      songs: const [
        Song(
            id: 'thiru-1',
            title: 'Chellamma',
            artist: 'Anirudh Ravichander, Anthony Daasan',
            imageUrl:
                'https://c.saavncdn.com/383/Megham-Karukatha-From-Thiruchitrambalam-Tamil-2022-20220715184158-500x500.jpg'),
        Song(
            id: 'thiru-2',
            title: 'Nee Yaaro',
            artist: 'Anirudh Ravichander, Shweta Mohan',
            imageUrl:
                'https://c.saavncdn.com/editorial/ThiruchitrambalamTamil_20220829093337.jpg'),
      ],
    ),
    const Album(
      id: 'album-10',
      title: "Doctor",
      imageUrl:
          'https://c.saavncdn.com/312/Doctor-Tamil-2021-20211005133149-500x500.jpg',
      songs:  [
        Song(
            id: 'doctor-1',
            title: 'Kadhaipoma',
            artist: 'Anirudh Ravichander',
            imageUrl:
                'https://c.saavncdn.com/890/Doctor-Original-Background-Score--Tamil-2021-20211018163318-500x500.jpg'),
        Song(
            id: 'doctor-2',
            title: 'Machi Boys',
            artist: 'Anirudh Ravichander',
            imageUrl:
                'https://c.saavncdn.com/513/Nenjame-From-Doctor--Tamil-2020-20200820100702-500x500.jpg'),
      ],
    ),
    const Album(
      id: 'album-11',
      title: "Pushpa (Tamil)",
      imageUrl:
          'https://c.saavncdn.com/blob/060/Pushpa-The-Rise-Tamil-2021-20211218130419-500x500.jpg',
      songs: [
        Song(
            id: 'pushpa-1',
            title: 'Srivalli',
            artist: 'Javed Ali, Devi Sri Prasad',
            imageUrl:
                'https://c.saavncdn.com/632/Pushpa-Pushpa-From-Pushpa-2-The-Rule-Tamil-Tamil-2024-20240501161051-500x500.jpg'),
        Song(
            id: 'pushpa-2',
            title: 'Saami Saami',
            artist: 'Mounika Yadav, Devi Sri Prasad',
            imageUrl:
                'https://c.saavncdn.com/632/Pushpa-Pushpa-From-Pushpa-2-The-Rule-Tamil-Tamil-2024-20240501161051-500x500.jpg'),
      ],
    ),
    const Album(
      id: 'album-12',
      title: "Maamannan",
      imageUrl:
          'https://c.saavncdn.com/265/Maamannan-Original-Motion-Picture-Soundtrack-Tamil-2023-20230601164218-500x500.jpg',
      songs: [
        Song(
            id: 'maamannan-1',
            title: 'Chithiram Pesudhadi',
            artist: 'A.R. Rahman',
            imageUrl:
                'https://c.saavncdn.com/editorial/Maamannan_20230530102946.jpg'),
        Song(
            id: 'maamannan-2',
            title: 'Con Damaadi Kaadhal',
            artist: 'A.R. Rahman',
            imageUrl:
                'https://c.saavncdn.com/265/Maamannan-Original-Motion-Picture-Soundtrack-Tamil-2023-20230601164218-500x500.jpg'),
      ],
    ),
    const Album(
      id: 'album-13',
      title: "Varisu",
      imageUrl:
          'https://c.saavncdn.com/910/Varisu-Hindi-2023-20230315204637-500x500.jpg',
      songs: [
        Song(
            id: 'varisu-1',
            title: 'Ranjithame',
            artist: 'Thalapathy Vijay, MMT Manasi',
            imageUrl:
                'https://c.saavncdn.com/152/Ranjithame-From-Varisu-Tamil-2022-20221105151002-500x500.jpg'),
        Song(
            id: 'varisu-2',
            title: 'Soul Sagar',
            artist: 'Thaman S',
            imageUrl:
                'https://c.saavncdn.com/152/Ranjithame-From-Varisu-Tamil-2022-20221105151002-500x500.jpg'),
      ],
    ),
    const Album(
      id: 'album-14',
      title: "Sarpatta Parambarai",
      imageUrl:
          'https://c.saavncdn.com/456/Vambula-Thumbula-From-Sarpatta-Parambarai--Tamil-2021-20210728195923-500x500.jpg',
      songs: [
        Song(
            id: 'sarpatta-1',
            title: 'Chennai City Gangsta',
            artist: 'Santhosh Narayanan',
            imageUrl:
                'https://c.saavncdn.com/456/Vambula-Thumbula-From-Sarpatta-Parambarai--Tamil-2021-20210728195923-500x500.jpg'),
        Song(
            id: 'sarpatta-2',
            title: 'Meesaya Mutham',
            artist: 'Santhosh Narayanan',
            imageUrl:
                'https://c.saavncdn.com/456/Vambula-Thumbula-From-Sarpatta-Parambarai--Tamil-2021-20210728195923-500x500.jpg'),
      ],
    ),
    const Album(
      id: 'album-15',
      title: "Kabali",
      imageUrl:
          'https://c.saavncdn.com/506/Kabali-Original-Motion-Picture-Soundtrack-Tamil-2016-20250905072302-500x500.jpg',
      songs: const [
        Song(
            id: 'kabali-1',
            title: 'Neruppu Da',
            artist: 'Santhosh Narayanan, Arivu',
            imageUrl:
                'https://c.saavncdn.com/537/Kabali-Original-Motion-Picture-Soundtrack-Hindi-2016-20250910160546-500x500.jpg'),
        Song(
            id: 'kabali-2',
            title: 'Maya Nadhi',
            artist: 'Santhosh Narayanan',
            imageUrl:
                'https://c.saavncdn.com/537/Kabali-Original-Motion-Picture-Soundtrack-Hindi-2016-20250910160546-500x500.jpg'),
      ],
    ),
  ];

  final List<Artist> _artists = const [
    Artist(
        id: 'artist-1',
        name: 'A.R. Rahman',
        imageUrl:
            'https://c.saavncdn.com/artists/AR_Rahman_002_20210120084455_500x500.jpg'),
    Artist(
        id: 'artist-2',
        name: 'Anirudh Ravichander',
        imageUrl:
            'https://c.saavncdn.com/artists/Anirudh_Ravichander_003_20260121134149_500x500.jpg'),
    Artist(
        id: 'artist-3',
        name: 'Yuvan Shankar Raja',
        imageUrl:
            'https://c.saavncdn.com/artists/Yuvan_Shankar_Raja_002_20180802174245_500x500.jpg'),
    Artist(
        id: 'artist-4',
        name: 'Harris Jayaraj',
        imageUrl:
            'https://c.saavncdn.com/artists/Harris_Jayaraj_002_20230718071330_500x500.jpg'),
    Artist(
        id: 'artist-5',
        name: 'Ilaiyaraaja',
        imageUrl:
            'https://c.saavncdn.com/806/Ilaiyaraaja-Non-Stop-Hits-Tamil-2024-20241017131003-500x500.jpg'),
    Artist(
        id: 'artist-6',
        name: 'Santhosh Narayanan',
        imageUrl:
            'https://c.saavncdn.com/016/Best-of-Santhosh-Narayanan-Tamil-Tamil-2023-20230608124452-500x500.jpg'),
  ];

  List<Song> _recentlyPlayed = const [
    Song(
        id: 'recent-1',
        title: 'Hayyoda',
        artist: 'Anirudh Ravichander, Priya Mali',
        imageUrl:
            'https://c.saavncdn.com/033/Hayyoda-From-Jawan-Tamil-2023-20230814014351-500x500.jpg'),
    Song(
        id: 'recent-2',
        title: 'Kaavaaalaa',
        artist: 'Shilpa Rao, Anirudh Ravichander',
        imageUrl:
            'https://c.saavncdn.com/183/Kaavaalaa-From-Jailer-Tamil-2023-20230708073100-500x500.jpg'),
    Song(
        id: 'recent-3',
        title: 'Pathala Pathala',
        artist: 'Kamal Haasan, Anirudh Ravichander',
        imageUrl:
            'https://c.saavncdn.com/904/Pathala-Pathala-From-Vikram-Tamil-2022-20220511165924-500x500.jpg'),
        Song(
        id: 'recent-4',
        title: 'Ranjithame',
        artist: 'Thalapathy Vijay, MMT Manasi',
        imageUrl:
            'https://c.saavncdn.com/153/Ranjithame-From-Varisu-Hindi-2023-20230217195125-500x500.jpg'),
  ];

  List<Song> _favorites = const [
    Song(
        id: 'fav-1',
        title: 'New York Nagaram',
        artist: 'A.R. Rahman',
        isFavorite: true,
        imageUrl:
            'https://c.saavncdn.com/106/Jillunu-Oru-Kadhal-2006-500x500.jpg'),
    Song(
        id: 'fav-2',
        title: 'Moongil Thottam',
        artist: 'A.R. Rahman, Abhay Jodhpurkar',
        isFavorite: true,
        imageUrl:
            'https://c.saavncdn.com/922/Kadal-Tamil-2012-20190822132814-500x500.jpg'),
    Song(
        id: 'fav-3',
        title: 'Poo Nee Poo',
        artist: 'Anirudh Ravichander, Mohit Chauhan',
        isFavorite: true,
        imageUrl:
            'https://c.saavncdn.com/106/Jillunu-Oru-Kadhal-2006-500x500.jpg'),
    Song(
        id: 'fav-4',
        title: 'Aathangara Marame',
        artist: 'A.R. Rahman',
        isFavorite: true,
        imageUrl:
            'https://c.saavncdn.com/327/Musical-Legends-Tamil-2018-20201124160441-500x500.jpg'),
    Song(
        id: 'fav-5',
        title: 'Manasilaayo',
        artist: 'Anirudh Ravichander, Malaysia Vasudevan (AI)',
        isFavorite: true,
        imageUrl:
            'https://c.saavncdn.com/130/Manasilaayo-From-Vettaiyan-Tamil-2024-20240909141500-500x500.jpg'),
    Song(
        id: 'fav-6',
        title: 'Rathamada',
        artist: 'Anirudh Ravichander',
        isFavorite: true,
        imageUrl:
            'https://c.saavncdn.com/508/Uchathila-From-Vettaiyan-Tamil-2024-20241011123236-500x500.jpg'),
    Song(
        id: 'fav-7',
        title: 'Vaathi Coming',
        artist: 'Anirudh Ravichander',
        imageUrl:
            'https://c.saavncdn.com/968/Vaathi-Coming-From-Master--Tamil-2020-20200310125849-500x500.jpg'),
    Song(
        id: 'fav-8',
        title: 'Kutti Story',
        artist: 'Anirudh Ravichander',
        imageUrl:
            'https://c.saavncdn.com/596/Kutti-Story-From-Master--Tamil-2020-20200214125442-500x500.jpg'),
    Song(
        id: 'fav-9',
        title: 'Andha Kanna Paathaakaa',
        artist: 'Anirudh Ravichander',
        imageUrl:
            'https://i1.behindwoods.com/tamil-movies-cinema-news-16/images/master-kutti-story-lyric-thalapathy-vijay-anirudh-ravichander-lokesh-kanagaraj-new-home-mob-index.png'),
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
  Future<List<Song>> getSongsByArtist(String artistName) async {
    await Future.delayed(const Duration(milliseconds: 250));
    final String name = artistName.trim().toLowerCase();
    if (name.isEmpty) return const [];

    final allSongs = <Song>{
      ..._trending,
      ..._recentlyPlayed,
      ..._favorites,
      for (final album in _albums) ...album.songs,
    };

    return allSongs
        .where((s) => s.artist.toLowerCase().contains(name))
        .toList();
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
