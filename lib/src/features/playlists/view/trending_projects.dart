import 'package:flutter/material.dart';
import 'package:nautical/src/shared/views/link_text.dart';

import '../../../shared/classes/classes.dart';
import '../../../shared/views/image_clipper.dart';
import '../../../shared/views/views.dart';

class TrendingProjects extends StatelessWidget {
  const TrendingProjects(
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
          label: Text('Rank'),
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
      rowBuilder: (context, index) {
        final song = playlist.songs[index];

        return DataRow.byIndex(
          index: index,
          cells: [
            DataCell(
              Text('${index + 1}'),
            ),
            DataCell(
              Row(children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 12,
                    bottom: 12,
                  ),
                  child: ClippedImage(song.image.image),
                ),
                const SizedBox(width: 12),
                Text(song.title),
              ]),
            ),
            DataCell(
              SizedBox(
                width: 80,
                child: Text(song.formattedDate),
              ),
            ),
            DataCell(
              SizedBox(
                width: 80,
                child: LinkText(
                  linkTitle: 'Mint',
                  linkAddress: 'https://www.fluttertemplates.com',
                ),
              ),
            ),
            DataCell(
              SizedBox(
                width: 300,
                child: Text(
                  song.description,
                  maxLines: 2,
                ),
              ),
            ),
          ],
        );
      },
      itemBuilder: (song, index) {
        return ListTile(
          onTap: () => {},
          leading: ClippedImage(song.image.image),
          title: Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: LinkText(
              linkTitle: '${song.title}',
              linkAddress: 'https://www.fluttertemplates.com',
            ),
          ),
          subtitle: Text('${song.formattedDate} -  ${song.description}'),
        );
      },
    );
  }
}
