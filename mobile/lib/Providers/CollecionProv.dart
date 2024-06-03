import 'package:flutter/material.dart';

class CollectionProvider extends ChangeNotifier {
  List<String> _favs = [];
  List<String> get favs => _favs;
  List<String> _likes = [];
  List<String> get likes => _likes;

  void AddFav(newIdTailor) {
    _favs.add(newIdTailor);
  }

  void GetFavs(context, client) {
    print("in get favsssssssss");
    if (client != null) {
      print("in get favsssssssss enter if");
      for (var tailor in client.favorites!) {
        _favs.add(tailor["_id"]);
        // Provider.of<CollectionProvider>(context, listen: false)
        //     .AddFav(tailor["_id"]);
      }
    }
    notifyListeners();
  }

  void GetLikes(context, likes) {
    print("in get likes");

    print("in get likes enter if below likes ");
    for (var post in likes) {
      _likes.add(post["_id"]);
    }
    notifyListeners();
  }

  void addOrdeletLike(PostId) {
    if (_likes.contains(PostId)) {
      _likes.remove(PostId);
    } else {
      _likes.add(PostId);
    }
    notifyListeners();
  }

  void addOrdeletFav(TailorId) {
    if (_favs.contains(TailorId)) {
      _favs.remove(TailorId);
    } else {
      _favs.add(TailorId);
    }
    notifyListeners();
  }
}
