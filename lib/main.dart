import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'data/repository/album_repository.dart';
import 'logic/album_bloc.dart';
import 'routes/app_router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final albumRepo = AlbumRepository();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Album App',
      routerConfig: appRouter,
      theme: ThemeData(primarySwatch: Colors.blue),
      builder: (context, child) {
        return RepositoryProvider.value(
          value: albumRepo,
          child: BlocProvider(
            create: (_) => AlbumBloc(albumRepo)..add(FetchAlbums()),
            child: child!,
          ),
        );
      },
    );
  }
}