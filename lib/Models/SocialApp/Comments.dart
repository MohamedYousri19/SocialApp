class CommentsDataModel {
  String? image ;
  String? username ;
  String? uId ;
  String? text ;

  CommentsDataModel.FromJson(Map<String,dynamic> json){
    image = json['image'];
    uId = json['uId'];
    username = json['username'];
    text = json['text'];
  }

  CommentsDataModel({
    this.text,
    this.image,
    this.uId,
    this.username,

  });

  Map<String,dynamic> toMap(){
    return{
      'text' : text,
      'image' : image,
      'uId' : uId,
      'username' : username,
    };
  }
}