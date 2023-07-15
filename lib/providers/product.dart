import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });

  void _setFavValue(bool newVal) {
    isFavorite = newVal;
    notifyListeners();
  }

  Future<void> toggleFavoriteStatus(String token) async {
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    print('The valur of isFav is ${isFavorite}');
    notifyListeners();
    final url = Uri.parse(
        'https://fyppractice-4a006-default-rtdb.firebaseio.com/prods/$id.json?auth=$token');
    try {
      final response = await http.patch(url,
          body: json.encode(
            {
              'isFavorite': isFavorite,
            },
          ));
        print('The status code of response is ${response.body}');
      if (response.statusCode >= 400) {
        _setFavValue(oldStatus);
      }
    } catch (error) {
      print('the error is $error');
      _setFavValue(oldStatus);
    }
  }
}
