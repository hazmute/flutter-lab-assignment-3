import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/album_bloc.dart';

class AlbumDetailScreen extends StatelessWidget {
  final int albumId;
  const AlbumDetailScreen({super.key, required this.albumId});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AlbumBloc>();
    final state = bloc.state;
    if (state is AlbumLoaded) {
      final album = state.albums.firstWhere((a) => a.id == albumId);
      final photo = state.photos[album.id];
      return Scaffold(
        appBar: AppBar(title: Text('Album Detail')),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Image.network(photo?.url ?? 'https://placehold.co/600x400'),
              const SizedBox(height: 16),
              Text('Album ID: ${album.id}'),
              Text('User ID: ${album.userId}'),
              Text('Title: ${album.title}'),
            ],
          ),
        ),
      );
    }
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
