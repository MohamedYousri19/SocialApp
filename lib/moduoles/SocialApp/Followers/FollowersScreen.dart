import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:to_do_app/Models/SocialApp/FolloweModel.dart';
import 'package:to_do_app/Models/SocialApp/likes.dart';
import 'package:to_do_app/layout/SocialAppLayout/cubit/cubit.dart';
import 'package:to_do_app/layout/SocialAppLayout/cubit/states.dart';

class FollowersScreen extends StatelessWidget {
  FollowersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (BuildContext context, Object? state) {  },
      builder: (BuildContext context, state) {
        var cubit = SocialCubit.get(context) ;
        return Scaffold(
            appBar: AppBar(
              leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: const Icon(IconBroken.Arrow___Left)),
              title: const Text('Followers'),
            ),
            body: ConditionalBuilder(
              condition: cubit.myFollowers.isNotEmpty  ,
              builder: (context) => ListView.separated(
                  itemBuilder: (context,index) => buildItem(context , cubit.myFollowers[index]),
                  separatorBuilder: (context,index) => const SizedBox(height: 1,),
                  itemCount: cubit.myFollowers.length
              ),
              fallback: (context) => const  Center(
                child: Image(image: AssetImage('assets/images/empty.png'), width: 200.0, ),
              ),
            )
        );
      },
    );
  }
  Widget buildItem(context,FollowerModel model) => Padding(
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
            ],
          ),
          const SizedBox(height: 5.0,),
          Container(height: 1.0,color: Colors.grey, width: double.infinity,),
        ]
    ),
  ) ;
}
