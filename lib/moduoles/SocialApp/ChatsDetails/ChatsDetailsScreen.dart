import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:to_do_app/Models/SocialApp/MessageModel.dart';
import 'package:to_do_app/Models/SocialApp/Social_User_Model.dart';
import 'package:to_do_app/Shared/styles/Colors.dart';
import 'package:to_do_app/layout/SocialAppLayout/cubit/cubit.dart';
import 'package:to_do_app/layout/SocialAppLayout/cubit/states.dart';
import 'package:to_do_app/moduoles/SocialApp/chat_bubble/chat_bubble_sender.dart';

import '../chat_bubble/chat_bubble_reciever.dart';

class ChatsDetailsScreen extends StatelessWidget {
  UserDataModel userDataModel ;
  ChatsDetailsScreen({super.key , required this.userDataModel});

  var messageController = TextEditingController() ;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        SocialCubit.get(context).getMessages(receiverId: userDataModel.uId.toString());
      return BlocConsumer<SocialCubit,SocialStates>(
        listener: (BuildContext context, Object? state) {  },
        builder: (BuildContext context, state) {
          return Scaffold(
              appBar: AppBar(
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 23.0,
                      backgroundImage: NetworkImage('${userDataModel.image}'),
                    ),
                    const SizedBox(width: 5.0,),
                    Text('${userDataModel.username}' , style:  const TextStyle(fontSize: 20.0),),
                  ],
                ),
                leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: const Icon(IconBroken.Arrow___Left)),
              ),
              body: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                          itemBuilder: (context,index) {
                            var message = SocialCubit.get(context).messages[index] ;
                            if(SocialCubit.get(context).userModel!.uId == message.senderId ){
                              return senderMessage(SocialCubit.get(context).messages[index]) ;
                            }else{
                              return receiverMessage(SocialCubit.get(context).messages[index]) ;
                            }
                          },
                          separatorBuilder: (context,index) {
                           return const SizedBox(height: 15.0,) ;
                          },
                          itemCount: SocialCubit.get(context).messages.length
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsetsDirectional.only(start: 10.0),
                            child: Row(
                              children: [
                                Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black,
                                              width: 1.0
                                          ),
                                          borderRadius: const BorderRadius.only(topLeft: Radius.circular(15.0), bottomLeft: Radius.circular(15.0) )
                                      ),
                                      height: 60.0,
                                      child: TextFormField(
                                          controller: messageController,
                                          cursorColor: defaultColor,
                                          style: const TextStyle(color: Colors.black , fontSize: 14.0),
                                          decoration: const InputDecoration(
                                            hintText: 'Enter Something...',
                                            hintStyle: TextStyle(
                                                color: Colors.black, fontSize: 14),
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.green,
                                                  width: 5.0
                                              ),
                                              borderRadius:BorderRadius.only(topLeft: Radius.circular(15.0), bottomLeft: Radius.circular(15.0) ),

                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.black,),
                                              borderRadius:BorderRadius.only(topLeft: Radius.circular(15.0), bottomLeft: Radius.circular(15.0) ),
                                            ),
                                          )
                                      ),
                                    )
                                ),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          focusColor: Colors.black,
                          onTap: (){
                            if(messageController.text.isEmpty){
                              print('none');
                            }else{
                              SocialCubit.get(context).SendMessage(receiverId: userDataModel.uId!, text: messageController.text);
                              messageController.clear();
                            }
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                              borderRadius:BorderRadius.only(topRight: Radius.circular(15.0), bottomRight: Radius.circular(15.0) ),
                              color: defaultColor,
                            ),
                            height: 58.0,
                            width: 70.0,
                            child:const Icon(IconBroken.Send , color: Colors.white,),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )
          ) ;
        },
      );
    },
    );
  }
  Widget senderMessage(MessageModel model) => Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      ChatBubble1(message: '${model.message}')
    ],
  );

  Widget receiverMessage(MessageModel model) => Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      ChatBubble(message: '${model.message}')
    ],
  );
}
