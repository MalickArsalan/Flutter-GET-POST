import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:fetch_data/Models/albums.dart';
import 'package:fetch_data/Views/addAlbum.dart';
import 'package:fetch_data/Routes/mainRoute.dart';

Future<List<Album>> fetchAlbum(http.Client client) async {
  final response =
      await http.get('https://jsonplaceholder.typicode.com/albums');

  if (response.statusCode == 200) {
    return compute(parseAlbums, response.body);
  } else {
    throw Exception('Failed to load album');
  }
}

List<Album> parseAlbums(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Album>((json) => Album.fromJson(json)).toList();
}

class AlbumsList extends StatefulWidget {
  @override
  _AlbumsListState createState() => _AlbumsListState();
}

class _AlbumsListState extends State<AlbumsList> {
  final appTitle = 'GET Demo';
  //final _albums = <Album>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appTitle),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Album>>(
        future: fetchAlbum(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.hasError);
          //print(snapshot.data.length);
          return snapshot.hasData
              ? buildAlbumList(albums: snapshot.data)
              : Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MainRouter(AddAlbum()));
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.black.withOpacity(0.3),
      ),
    );
  }

  Widget buildAlbumList({List<Album> albums}) {
    // print(albums[99].title);
    return ListView.builder(
      padding: EdgeInsets.all(8.0),
      itemBuilder: (context, i) {
        if (i.isOdd) return Divider(); /*2*/

        final index = i ~/ 2; /*3*/

        return (index <= 99) ? _buildRow(albums[index]) : null;
      },
    );
  }

  Widget _buildRow(Album album) {
    return ListTile(
      title: Text(
        (album.id).toString() + '.' + album.title,
        style: TextStyle(fontSize: 18.0),
      ),
    );
  }
}
