class MessageModel {
  String? senderId ;
  String? receiverId ;
  String? message ;
  String? dateTime ;


  MessageModel.FromJson(Map<String,dynamic> json){
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    message = json['message'];
    dateTime = json['dateTime'];
  }

  MessageModel({
    this.senderId,
    this.receiverId,
    this.message,
    this.dateTime,
  });

  Map<String,dynamic> toMap(){
    return{
      'senderId' : senderId,
      'receiverId' : receiverId,
      'message' : message,
      'dateTime' : dateTime,

    };
  }
}