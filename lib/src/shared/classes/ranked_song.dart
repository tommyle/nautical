import './classes.dart';

class RankedSong extends Song {
  final int ranking;

  const RankedSong(
    this.ranking,
    String artist,
    String title,
    MyArtistImage image,
    DateTime date,
    String description,
  ) : super(
          artist,
          title,
          image,
          date,
          description,
        );
}
