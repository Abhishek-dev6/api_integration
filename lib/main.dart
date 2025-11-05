import 'package:api_integration/view/employee_view.dart';
import 'package:api_integration/view/post_screen.dart';
import 'package:api_integration/view/post_screen2.dart';
// import 'package:api_example/view/product_view.dart';
import 'package:api_integration/viewmodel/employee_view_model.dart';
//import 'package:api_example/view/postui.dart';
import 'package:api_integration/viewmodel/poat_view_model.dart';
import 'package:api_integration/viewmodel/post_view_model2.dart';
import 'package:api_integration/viewmodel/products_viewmodel.dart';
import 'package:api_integration/view/product_view.dart';
import 'package:api_integration/viewmodel/products_viewmodel.dart';
//import 'package:api_example/viewmodel/view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProductsViewmodel() ,
      child: MaterialApp(home:ProductScreen() ),
    );
  }
}
