import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/classes/classes.dart';
import '../../../shared/extensions.dart';
import '../../../shared/playback/bloc/bloc.dart';
import '../../../shared/views/image_clipper.dart';
import '../../../shared/views/views.dart';

class PlaylistSongs extends StatelessWidget {
  const PlaylistSongs(
      {super.key, required this.playlist, required this.constraints});

  final Playlist playlist;
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    return AdaptiveTable<Song>(
      items: playlist.songs,
      breakpoint: 1024,
      columns: const [
        DataColumn(
          label: Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text('Upvotes'),
          ),
        ),
        DataColumn(
          label: Text('Project name'),
        ),
        DataColumn(
          label: Text('When'),
        ),
        DataColumn(
          label: Text('Mint Link'),
        ),
        DataColumn(
          label: Text('Description'),
        ),
      ],
      rowBuilder: (context, index) => DataRow.byIndex(
        index: index,
        cells: [
          DataCell(
            HoverableSongPlayButton(
              hoverMode: HoverMode.overlay,
              song: playlist.songs[index],
              child: Center(
                child: Text(
                  (index + 1).toString(),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          DataCell(
            Row(children: [
              Padding(
                padding: const EdgeInsets.all(2),
                child: ClippedImage(playlist.songs[index].image.image),
              ),
              const SizedBox(width: 10),
              Text(playlist.songs[index].title),
            ]),
          ),
          DataCell(
            SizedBox(
              width: 100,
              child: Text('June 04, 07:00'),
            ),
          ),
          DataCell(
            SizedBox(
              width: 120,
              child: Text(
                'Check on Twitter',
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
            ),
          ),
          DataCell(
            SizedBox(
              width: 300,
              child: Text(
                'Description of the drop goes here',
                maxLines: 2,
              ),
            ),
          ),
        ],
      ),
      itemBuilder: (song, index) {
        return ListTile(
          onTap: () => BlocProvider.of<PlaybackBloc>(context).add(
            PlaybackEvent.changeSong(song),
          ),
          leading: ClippedImage(song.image.image),
          title: Text(song.title),
          subtitle: Text(song.length.toHumanizedString()),
        );
      },
    );
  }
}
