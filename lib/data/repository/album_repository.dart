import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/album.dart';
import '../models/photo.dart';

class AlbumRepository {
  final _albumsUrl = 'https://jsonplaceholder.typicode.com/albums';
  final _photosUrl = 'https://jsonplaceholder.typicode.com/photos';

  Future<List<Album>> fetchAlbums() async {
    final res = await http.get(Uri.parse(_albumsUrl));
    if (res.statusCode == 200) {
      return (json.decode(res.body) as List)
          .map((e) => Album.fromJson(e))
          .toList();
    } else {
      throw Exception('Failed to load albums');
    }
  }

  Future<Photo?> fetchFirstPhoto(int albumId) async {
    final res = await http.get(Uri.parse(_photosUrl));
    if (res.statusCode == 200) {
      final photos = (json.decode(res.body) as List)
          .map((e) => Photo.fromJson(e))
          .where((photo) => photo.albumId == albumId)
          .toList();
      return photos.isNotEmpty ? photos.first : null;
    } else {
      throw Exception('Failed to load photos');
    }
  }
}
