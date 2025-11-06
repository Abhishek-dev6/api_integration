import 'dart:convert';
import 'package:http/http.dart' as http;

class  ProductsServices {
  

Future<void> updateproduct(int id,Map <String,dynamic> updateData) async{
  final url=Uri.parse('https://api.restful-api.dev/objects/$id');
  final response=await http.put(
    url,headers:{'COntent-Type':'application/json'},
    body:jsonEncode(updateData),
  );
  if(response.statusCode==200){
    print("product updated successfully");
    print(response.body);
  }else{
    print("failed to update");
  }
}}