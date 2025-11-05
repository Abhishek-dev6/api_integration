import 'dart:convert';
//import 'dart:math';
//import 'package:api_example/model/modelclass.dart';
import 'package:api_integration/model/modelclass.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PostViewModel extends ChangeNotifier {
  List<Post> posts = [];
  bool isLoading = false;
  Future<void> fetchPosts() async {
    print("Entered in fetch posts");
    isLoading = true;
    notifyListeners();
    try {
      final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
      final response = await http.get(url);
      if (response.statusCode == 200) {
         print("Entered in fetch posts status code 200");
        final List data = jsonDecode(response.body);
        posts = data.map((e) => Post.fromJson(e)).toList();
      } else {
        print('failed to load Posts');
      }
    } catch (e) {
      print("Exception occured in fetch posts $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
