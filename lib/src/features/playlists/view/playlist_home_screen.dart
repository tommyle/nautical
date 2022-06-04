import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nautical/src/shared/extensions.dart';

import '../../../shared/classes/classes.dart';
import '../../../shared/providers/providers.dart';
import '../../../shared/views/views.dart';

class PlaylistHomeScreen extends StatelessWidget {
  const PlaylistHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    PlaylistsProvider playlistProvider = PlaylistsProvider();
    List<Playlist> playlists = playlistProvider.playlists;
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          primary: false,
          appBar: AppBar(
            centerTitle: false,
            title: Text(
              'Projects',
              style: context.displaySmall,
            ),
            toolbarHeight: kToolbarHeight * 2,
          ),
          body: Column(
            children: [
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(15),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: (constraints.maxWidth ~/ 175).toInt(),
                    childAspectRatio: 0.70,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemCount: playlists.length,
                  itemBuilder: (context, index) {
                    final playlist = playlists[index];
                    return GestureDetector(
                      child: ImageTile(
                        image: playlist.cover.image,
                        title: playlist.title,
                        subtitle: playlist.description,
                      ),
                      onTap: () =>
                          GoRouter.of(context).go('/playlists/${playlist.id}'),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
