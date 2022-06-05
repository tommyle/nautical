import 'package:faker/faker.dart';

import '../classes/classes.dart';

class SongsProvider {
  static SongsProvider get shared => SongsProvider();
  List<RankedSong> get songs => _songs;
}

// Separated out to avoid re-instantiating the list on every access.
final _songs = <RankedSong>[
  RankedSong(
    1,
    faker.person.name(),
    faker.company.name(),
    const MyArtistImage(
      image: 'assets/images/albums/artist6-album1.jpg',
      sourceLink: 'https://unsplash.com/photos/cTKGZJTMJQU',
      sourceName: 'Drew Dizzy Graham',
    ),
    faker.date.dateTime(),
    faker.lorem.sentence(),
  ),
  RankedSong(
    2,
    faker.person.name(),
    faker.company.name(),
    const MyArtistImage(
      image: 'assets/images/albums/artist6-album1.jpg',
      sourceLink: 'https://unsplash.com/photos/cTKGZJTMJQU',
      sourceName: 'Drew Dizzy Graham',
    ),
    faker.date.dateTime(),
    faker.lorem.sentence(),
  ),
  RankedSong(
    3,
    faker.person.name(),
    faker.company.name(),
    const MyArtistImage(
      image: 'assets/images/albums/artist6-album1.jpg',
      sourceLink: 'https://unsplash.com/photos/cTKGZJTMJQU',
      sourceName: 'Drew Dizzy Graham',
    ),
    faker.date.dateTime(),
    faker.lorem.sentence(),
  ),
];
