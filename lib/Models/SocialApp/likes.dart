class likesDataModel {
  String? image ;
  String? username ;
  String? uId ;
  bool? like ;

  likesDataModel.FromJson(Map<String,dynamic> json){
    image = json['image'];
    uId = json['uId'];
    username = json['username'];
    like = json['like'];
  }

  likesDataModel({
    this.like,
    this.image,
    this.uId,
    this.username,

  });

  Map<String,dynamic> toMap(){
    return{
      'like' : like,
      'image' : image,
      'uId' : uId,
      'username' : username,
    };
  }
}