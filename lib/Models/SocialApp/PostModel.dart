class PostDataModel {
  String? image ;
  String? username ;
  String? uId ;
  String? text ;
  String? postImage ;
  String? dateTime ;
  String? cover ;
  String? bio ;

  PostDataModel.FromJson(Map<String,dynamic> json){
    image = json['image'];
    uId = json['uId'];
    username = json['username'];
    text = json['text'];
    postImage = json['postImage'];
    dateTime = json['dateTime'];
    cover = json['cover'];
    bio = json['bio'];
  }

  PostDataModel({
    this.postImage,
    this.image,
    this.uId,
    this.username,
    this.text,
    this.dateTime,
    this.cover,
    this.bio,
  });

  Map<String,dynamic> toMap(){
    return{
      'postImage' : postImage,
      'image' : image,
      'uId' : uId,
      'username' : username,
      'text' : text,
      'dateTime' : dateTime,
      'cover' : cover,
      'bio' : bio,

    };
  }
}