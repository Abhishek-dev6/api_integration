import 'dart:convert';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;

class  ProductsServices {
  

Future<void> updateproduct(int id,Map<String,dynamic> updateData,String name,double price) async{
  final url=Uri.parse('https://api.restful-api.dev/products/$id');
  final body=jsonEncode({
    "name":name,
    "data":{
      "price":price,
      "color":"red"

    }
  });
  final response=await http.put(
    url,headers:{'COntent-Type':'application/json'},
    body:body,
  );
  if(response.statusCode==200){
    print("product updated successfully");
    print(response.body);
  }else{
    print("failed to update");
  }
}}