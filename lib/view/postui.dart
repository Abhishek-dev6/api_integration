//import 'package:api_example/model/modelclass.dart';
import 'package:api_integration/viewmodel/view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Postscreen extends StatefulWidget {
  const Postscreen({super.key});

  @override
  State<Postscreen> createState() => _PostscreenState();
}

class _PostscreenState extends State<Postscreen> {
  late PostViewModel viewModel;
  @override
  void initState() {  
    viewModel = context.read<PostViewModel>();
    WidgetsBinding.instance.addPostFrameCallback((v){
      viewModel.fetchPosts();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final viewmodel = Provider.of<PostViewModel>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Provider Api Example")),
      body:
          viewmodel.isLoading
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                itemCount: viewmodel.posts.length,
                itemBuilder: (context, index) {
                  final post = viewmodel.posts[index];
                  return ListTile(
                    title: Text(post.title),
                    subtitle: Text(post.body),
                  );
                },
              ),
      floatingActionButton: FloatingActionButton(
        onPressed: viewmodel.fetchPosts,
        child: Icon(Icons.download),
      ),
    );
  }
}
