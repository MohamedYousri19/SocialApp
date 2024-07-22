import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:to_do_app/Models/SocialApp/Comments.dart';
import 'package:to_do_app/Shared/styles/Colors.dart';
import 'package:to_do_app/layout/SocialAppLayout/cubit/cubit.dart';
import 'package:to_do_app/layout/SocialAppLayout/cubit/states.dart';

class CommentsScreen extends StatelessWidget {
  List<dynamic> postsId ;
  CommentsScreen({super.key , required this.postsId});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (BuildContext context, Object? state) {  },
      builder: (BuildContext context, state) {
        var CommentController = TextEditingController() ;
        return Scaffold(
              appBar: AppBar(
                leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(IconBroken.Arrow___Left)),
                title: const Text('Comments'),
                actions: const [
                  Icon(IconBroken.Chat),
                  SizedBox(width: 10.0,)
                ],
              ),
              body: ConditionalBuilder(
              condition: SocialCubit.get(context).Comments.isNotEmpty,
              builder: (context) => Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                          itemBuilder: (context,index) => buildItem(context , SocialCubit.get(context).Comments[index]),
                          separatorBuilder: (context,index) => SizedBox(height: 5.0,),
                          itemCount:  SocialCubit.get(context).Comments.length
                      ),
                    ),
                  ],
                ),
              ),
              fallback:  (context) =>  Center(
                child: Image(image: AssetImage('assets/images/empty.png'), width: 200.0, ),
              ),
            )
        );
      },
    );
  }
  Widget buildItem(context , CommentsDataModel model) => Card(
    color: Colors.grey[600],
    child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 25.0,
                backgroundImage: NetworkImage('${model.image}'),
              ),
              SizedBox(
                width: 7.0,
              ),
              Text('${model.username}' , style: TextStyle(fontSize: 20.0 , fontWeight: FontWeight.w600,color: Colors.white),)
            ],
          ),
          SizedBox(height: 10.0,),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    style: TextStyle(height: 1.3,color: Colors.white,fontSize: 17.0,fontWeight: FontWeight.w500),
                    '${model.text}',
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    ),
  );
}
