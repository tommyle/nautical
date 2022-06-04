import './classes.dart';

class Song {
  final String artist;
  final String title;
  final MyArtistImage image;
  final DateTime date;
  final String description;

  const Song(
    this.title,
    this.artist,
    this.image,
    this.date,
    this.description,
  );
}
