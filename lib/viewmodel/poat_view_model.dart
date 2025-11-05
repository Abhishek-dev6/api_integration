import 'dart:convert';
//import 'package:api_example/model/post_model.dart';
import 'package:api_integration/model/modelclass.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Post_View_Model extends ChangeNotifier{
  List <Post> _posts=[];
  bool _isLoading=false;
  String? _errormessage;
  
  List <Post> get posts=>_posts;
  bool get isLoading=>_isLoading;
  String? get errormessage=>_errormessage;

Future <void> fetchposts() async{
  print("fetch started");
  _isLoading=true;
  _errormessage=null;
  notifyListeners();
  final url=Uri.parse('https://jsonplaceholder.typicode.com/posts');
  print("sending get request to:$url");
  try{
  final response = await http.get(url);
  print("Response status:${response.statusCode}");
  if (response.statusCode==200){
    List data=jsonDecode(response.body);
    print("object");
    _posts=data.map((e)=>Post.fromJson(e)).toList();
  }else{
    _errormessage='Failed to load posts';
  }
  }catch(e){
    _errormessage='Error:$e';
  }
  _isLoading=false;
  notifyListeners();
  print("fetch completed");
}
}
