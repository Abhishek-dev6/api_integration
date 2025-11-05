import 'package:api_integration/viewmodel/post_view_model2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Postscreen extends StatelessWidget {
  const Postscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ViewModel=Provider.of<PostViewModel2>(context);
    return Scaffold(
      appBar: AppBar(title: Text("API with provider")),
      body: Column(
        children: [
          if(ViewModel.isLoading)
          const CircularProgressIndicator()
          else if(ViewModel.post!=null)
          Column(
            children: [
              Text("ID:${ViewModel.post!.title}"),
              Text("Title:${ViewModel.post!.title}"),
              Text("Body:${ViewModel.post!.body}")
            ],
          )
          else 
          Text("No data available"),SizedBox(height: 20,),
          Text(ViewModel.messsage),SizedBox(height: 20,),
          ElevatedButton(onPressed: ViewModel.fetchPost, child: Text("Get Post")),SizedBox(height: 20,),
          ElevatedButton(onPressed: ViewModel.CreatePost, child: Text("Create"),),SizedBox(height: 20,),
           ElevatedButton(onPressed: ViewModel.deletePost, child: Text("Delete"),),SizedBox(height: 20,),

        ],
      ),

    );
  }
}