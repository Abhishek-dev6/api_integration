// import 'package:api_example/model/products_model.dart';
// import 'package:api_example/viewmodel/products_viewmodel.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../viewmodel/products_viewmodel.dart';
// import '../model/products_model.dart';

// class ProductScreen extends StatefulWidget {
//   const ProductScreen({super.key});

//   @override
//   State<ProductScreen> createState() => _ProductScreenState();
// }

// class _ProductScreenState extends State<ProductScreen> {
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _colorController = TextEditingController();
//   final TextEditingController _priceController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     Future.microtask(() =>
//     Provider.of<ProductsViewmodel>(context, listen: false).getProducts());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Product Manager")),
//       body: Consumer<ProductsViewmodel>(
//         builder: (context,vm,child) {
//           if (vm.isLoading) {
//             return const Center(child: CircularProgressIndicator());
//           }
//           if (vm.product.isEmpty) {
//             return const Center(child: Text("No products found."));
//           }

//           return ListView.builder(
//             itemCount: vm.product.length,
//             itemBuilder: (context, index) {
//               final Products  = vm.product[index];
//               return Card(
//                 margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                 child: ListTile(
//                   title: Text(Products.name??""),
//                   subtitle: Text(
//                     "Color: ${Products.color ?? "N/A"} | Price: ${Products.price?.toStringAsFixed(2) ?? "N/A"}",
//                   ),
//                   trailing: IconButton(
//                     icon: const Icon(Icons.delete, color: Colors.red),
//                     onPressed: Products.id != null
//                         ? () => vm.deleteProduct(Products.id??"")

//                   )
//                 ),
//               );
//             },
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => _showAddDialog(context),
//         child: const Icon(Icons.add),
//       ),
//     );
//   }

//   void _showAddDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (_) {
//         return AlertDialog(
//           title: const Text("Add New Product"),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextField(
//                 controller: _nameController,
//                 decoration: const InputDecoration(labelText: "Product Name"),
//               ),
//               TextField(
//                 controller: _colorController,
//                 decoration: const InputDecoration(labelText: "Color"),
//               ),
//               TextField(
//                 controller: _priceController,
//                 keyboardType: TextInputType.number,
//                 decoration: const InputDecoration(labelText: "Price"),
//               ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 final name = _nameController.text.trim();
//                 final color = _colorController.text.trim();
//                 final price = double.tryParse(_priceController.text) ?? 0;

//                 if (name.isNotEmpty) {
//                   Provider.of<ProductsViewmodel>(context, listen: false)
//                       .addproducts(name, color, price);
//                   Navigator.pop(context);
//                 }
//               },
//               child: const Text("Add"),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

import 'package:api_integration/model/products_model.dart';
import 'package:api_integration/viewmodel/products_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _colorController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(
      () =>
          Provider.of<ProductsViewmodel>(context, listen: false).fetchProducts(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Product Manager")),
      body: Consumer<ProductsViewmodel>(
        builder: (context, vm, child) {
          if (vm.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (vm.product.isEmpty) {
            return const Center(child: Text("No products found."));
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: vm.product.length,
                  itemBuilder: (context, index) {
                    final product = vm.product[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      child: ListTile(
                        title: Text(product.name ?? ""),
                        subtitle: Text(
                          "Color: ${product.data?.dataColor ?? "N/A"} | Price: ${product.data?.dataPrice?.toStringAsFixed(2) ?? "N/A"}",
                        ),
                        trailing:Wrap(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                if (product.id != null) {
                                  vm.deleteProduct(product.id!);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text("Product ID not found")),
                                  );
                                }
                              },
                            ),ElevatedButton(onPressed: (){
                              context.read<ProductsViewmodel>().updateproduct(1,"Updated product name",99.99);
                            }, child: Text("Update"))
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("Add New Product"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: "Product Name"),
              ),
              TextField(
                controller: _colorController,
                decoration: const InputDecoration(labelText: "Color"),
              ),
              TextField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Price"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                final name = _nameController.text.trim();
                final color = _colorController.text.trim();
                final price = double.tryParse(_priceController.text) ?? 0;

                if (name.isNotEmpty) {
                  Provider.of<ProductsViewmodel>(
                    context,
                    listen: false,
                  ).addproducts(name, color, price);
                  Navigator.pop(context);
                }
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }
}
