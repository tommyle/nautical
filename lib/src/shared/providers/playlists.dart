import 'dart:math';
import 'package:collection/collection.dart';
import 'package:faker/faker.dart';

import '../classes/classes.dart';

class PlaylistsProvider {
  List<Playlist> get playlists => _randomPlaylists;
  Playlist get newReleases => randomPlaylist(numSongs: 20);
  Playlist get topSongs => randomPlaylist(numSongs: 20);

  static List<MyArtistImage> images() {
    return [
      const MyArtistImage(
          image: 'assets/images/collections/akumu/akumu_1.png',
          sourceLink: 'https://unsplash.com/photos/60GsdOMRFGc',
          sourceName: 'Karsten Winegeart'),
      const MyArtistImage(
          image: 'assets/images/collections/boki/boki_1.png',
          sourceLink: 'https://unsplash.com/photos/AlBgcDfDG_s',
          sourceName: 'Carlos Alfonso'),
      const MyArtistImage(
          image: 'assets/images/collections/cheebs/cheebs_1.png',
          sourceLink: 'https://unsplash.com/photos/wkgv7I2VTzM',
          sourceName: 'Alexandra Fuller'),
      const MyArtistImage(
          image: 'assets/images/collections/chums/chums_1.png',
          sourceLink: 'https://unsplash.com/photos/CnEEF5eJemQ',
          sourceName: 'Karsten Winegeart'),
      const MyArtistImage(
          image: 'assets/images/collections/dragonz/dragonz_1.png',
          sourceLink: 'https://unsplash.com/photos/NTyBbu66_SI',
          sourceName: 'Jared Rice'),
      const MyArtistImage(
          image: 'assets/images/collections/flower/flower_1.png',
          sourceLink: 'https://unsplash.com/photos/XOhI_kW_TaM',
          sourceName: 'Nathan Dumlao'),
      const MyArtistImage(
          image: 'assets/images/collections/monkez/monkez_1.gif',
          sourceLink: 'https://unsplash.com/photos/BhfE1IgcsA8',
          sourceName: 'Jordan Whitfield'),
      const MyArtistImage(
          image: 'assets/images/collections/akumu/akumu_2.png',
          sourceLink: 'https://unsplash.com/photos/-moT-Deiw1M',
          sourceName: 'Humble Lamb'),
      const MyArtistImage(
          image: 'assets/images/collections/boki/boki_2.png',
          sourceLink: 'https://unsplash.com/photos/BY_KyTwTKq4',
          sourceName: 'dimitri.photography'),
    ];
  }

  Playlist? getPlaylist(String id) {
    return playlists.firstWhereOrNull((playlist) => playlist.id == id);
  }

  static Playlist randomPlaylist({int numSongs = 15}) {
    return Playlist(
      id: faker.guid.guid(),
      title: faker.company.name(),
      description: faker.lorem.sentence(),
      songs: List.generate(numSongs, (index) => randomSong()),
      cover: images()[Random().nextInt(images().length - 1)],
    );
  }

  static Playlist randomLengthPlaylist({int maxSongs = 15}) {
    final int songCount = Random().nextInt(maxSongs) + 1;

    return PlaylistsProvider.randomPlaylist(numSongs: songCount);
  }

  static Song randomSong() {
    return Song(
      faker.company.name(),
      faker.person.name(),
      images()[Random().nextInt(images().length)],
      faker.date.dateTime(),
      faker.lorem.sentence(),
    );
  }

  static final List<Playlist> _randomPlaylists =
      List.generate(10, (index) => randomLengthPlaylist());
}
