import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/models/album.dart';
import '../data/models/photo.dart';
import '../data/repository/album_repository.dart';

abstract class AlbumEvent {}
class FetchAlbums extends AlbumEvent {}

abstract class AlbumState {}
class AlbumLoading extends AlbumState {}
class AlbumLoaded extends AlbumState {
  final List<Album> albums;
  final Map<int, Photo?> photos;
  AlbumLoaded(this.albums, this.photos);
}
class AlbumError extends AlbumState {
  final String message;
  AlbumError(this.message);
}

class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
  final AlbumRepository repository;
  AlbumBloc(this.repository) : super(AlbumLoading()) {
    on<FetchAlbums>((event, emit) async {
      emit(AlbumLoading());
      try {
        final albums = await repository.fetchAlbums();
        final Map<int, Photo?> photos = {};
        for (var album in albums) {
          photos[album.id] = await repository.fetchFirstPhoto(album.id);
        }
        emit(AlbumLoaded(albums, photos));
      } catch (e) {
        emit(AlbumError(e.toString()));
      }
    });
  }
}
