class Post{
  final int id;
  final String title;
  final String body;
  Post({required this.id,required this.title,required this.body});
 factory Post.fromJson(Map<String,dynamic>Json){
  return Post(id: Json['id'], title: Json['title'], body: Json['body']);
 }
 Map<String,dynamic>toJson(){
  return{
    'id':id,
    'title':title,
    'body':body,
  };
 }
}