// import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../presentation/screens/album_detail_screen.dart';
import '../presentation/screens/album_list_screen.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const AlbumListScreen(),
    ),
    GoRoute(
      path: '/detail/:id',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return AlbumDetailScreen(albumId: id);
      },
    ),
  ],
);
