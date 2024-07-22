class FollowerModel {
  String? image ;
  String? username ;
  String? uId ;
  String? dateTime ;

  FollowerModel.FromJson(Map<String,dynamic> json){
    image = json['image'];
    uId = json['uId'];
    username = json['username'];
    dateTime = json['dateTime'];
  }

  FollowerModel({
    this.image,
    this.uId,
    this.username,
    this.dateTime,
  });

  Map<String,dynamic> toMap(){
    return{
      'image' : image,
      'uId' : uId,
      'username' : username,
      'dateTime' : dateTime,
    };
  }
}