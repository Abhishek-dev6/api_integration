//import 'package:api_example/model/products_model.dart';
//import 'package:api_example/repository/repository_products.dart';
import 'package:api_integration/model/products_model.dart';
import 'package:api_integration/repository/repository_products.dart';
import 'package:api_integration/services/products_services.dart';
import 'package:flutter/material.dart';

class ProductsViewmodel extends ChangeNotifier{
  final RepositoryProducts _repository=RepositoryProducts();
  final ProductsServices _service=ProductsServices();
  List<Products> product=[];
  bool isLoading=false;
  String message="";
  Future<void> getProducts() async{
    isLoading=true;
    notifyListeners();
    try{
      product=await _repository.fetchproducts();
      message="Products fetched successfully";
    }catch(e){
      message="Error$e";
    }
    isLoading=false;
    notifyListeners();
  }
  Future <void> addproducts(String name,String color,double price) async{
  isLoading=true;
  notifyListeners();
  try{
    final newproduct=Products(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      name:name,
    data: Data(dataColor:color,
    dataPrice:price),);
    await _repository.addproducts(newproduct);
    // await getProducts();
    product.add(newproduct);
    message="Product added successfully";
  }catch(e){
    message="Error adding product:$e";
  }
  isLoading=false;
  notifyListeners();
  }
  Future<void> deleteProduct(String id) async{
    isLoading=true;
    notifyListeners();
    try{
      await _repository.deleteProduct(id);
      product.removeWhere((item)=>item.id==id);
      message="product deleted successfully";
    }catch(e){
      message="Error:$e";
    }
    isLoading=false;
    notifyListeners();
  }
Future <void>  updateproduct(int id,String title,double price) async{
  Map<String,dynamic> updateData={
    "title":title,
    "price":price
  };
  await _service.updateproduct(id, updateData);
  notifyListeners();
}
}