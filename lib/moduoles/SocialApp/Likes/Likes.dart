import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:to_do_app/Models/SocialApp/likes.dart';
import 'package:to_do_app/layout/SocialAppLayout/cubit/cubit.dart';
import 'package:to_do_app/layout/SocialAppLayout/cubit/states.dart';

class LikesScreen extends StatelessWidget {
  const LikesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (BuildContext context, Object? state) {  },
      builder: (BuildContext context, state) {
        var cubit = SocialCubit.get(context) ;
        return Scaffold(
            appBar: AppBar(
              leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: const Icon(IconBroken.Arrow___Left)),
              title: const Text('Likes'),
            ),
            body: ConditionalBuilder(
                condition: cubit.userLikes.isNotEmpty  ,
                builder: (context) => ListView.separated(
                    itemBuilder: (context,index) => buildItem(context , cubit.userLikes[index]),
                    separatorBuilder: (context,index) => const SizedBox(height: 1,),
                    itemCount: cubit.userLikes.length
                ),
                fallback: (context) => const Center(child: CircularProgressIndicator()),
            )
        );
      },
    );
  }
  Widget buildItem(context,likesDataModel model) => Padding(
    padding: const EdgeInsets.all(10.0),
    child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 35.0,
                backgroundImage: NetworkImage('${model.image}'),
              ),
              const SizedBox(width: 10.0,),
              Text('${model.username}',style: const TextStyle(fontSize: 20.0 , fontWeight: FontWeight.w500),),
              const Spacer(),
              const Icon(IconBroken.Heart,color: Colors.red,)
            ],
          ),
          const SizedBox(height: 5.0,),
          Container(height: 1.0,color: Colors.grey, width: double.infinity,),
        ]
    ),
  ) ;
}
