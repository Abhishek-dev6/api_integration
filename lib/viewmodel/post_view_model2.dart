import 'dart:convert';

//import 'package:api_example/model/modelclass.dart';
import 'package:api_integration/model/modelclass.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

class PostViewModel2 extends ChangeNotifier {
  Post?post;
  bool isLoading=false;
  String messsage="";
  final String baseurl="https://jsonplaceholder.typicode.com/posts/1";
  void _setLoading(bool value){
    isLoading=value;
    notifyListeners();
  }
  //GET------FETCH THE DATA
  Future <void> fetchPost() async{
    _setLoading(true);
    try{
      final response=await http.get(Uri.parse(baseurl));
      if (response.statusCode==200){
        post=Post.fromJson(json.decode(response.body));
        messsage="GET SUCCESSFUL";
      }else{
        messsage="Failed to fetch data";
      }
    }catch(e){
      messsage="Erroe:$e";
    }
    _setLoading(true);
  }
  Future<void> CreatePost() async{
    _setLoading(true);
    try{
      final response=await http.put(Uri.parse(baseurl),
      headers: {'content-Type':'application/json'},
      body: json.encode({
        'id':1,
        'title':'Updated title from provider',
        'body':'Updated body from provider',
        'UserId':1,
      })
      );
      if(response.statusCode==200){
        post=Post.fromJson(json.decode(response.body));
        messsage="PUT Successful";

      }else{
        messsage="Failed to update";
      }
    }catch(e){
      messsage="Error:$e";
    }
    _setLoading(false);
  }
  Future<void> deletePost() async{
    _setLoading(true);
     try{
    final response=await http.delete(Uri.parse(baseurl));
    if(response.statusCode==200){
      post=null;
      messsage="Delete successful";
    }else{
      messsage="failed to delete";
    }
  }catch(e){
    messsage="Error$e";
  }
  _setLoading(false);
  }
}