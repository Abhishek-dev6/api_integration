//import 'package:api_example/model/post_model.dart';
import 'package:api_integration/viewmodel/poat_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:api_example/model/post_model.dart';  

class programe2 extends StatefulWidget {
  const programe2({super.key});

  @override
  State<programe2> createState() => _programe2State();
}

class _programe2State extends State<programe2> {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<Post_View_Model>(context);
    return Scaffold(
      appBar: AppBar(title: Text("MVVM provider API Example")),
      body: Center(
        child:
            viewModel.isLoading
                ? const CircularProgressIndicator()
                : Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        viewModel.fetchposts();
                      },
                      child: Text("Load posts"),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: viewModel.posts.length,
                        itemBuilder: (context, index) {
                          final post = viewModel.posts[index];
                          return Card(
                            child: ListTile(
                              title: Text(post.title),
                              subtitle: Text(post.body),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
      ),
    );
  }
}
