import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/Models/SocialApp/Social_User_Model.dart';
import 'package:to_do_app/layout/SocialAppLayout/cubit/cubit.dart';
import 'package:to_do_app/layout/SocialAppLayout/cubit/states.dart';
import 'package:to_do_app/moduoles/SocialApp/recieverProfile/ReceiverScreen.dart';
import '../../../Shared/Components/Components.dart';


class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<SocialCubit,SocialStates>(
      builder: (BuildContext context, SocialStates state) {
        var cubit = SocialCubit.get(context) ;
        return ConditionalBuilder(
          condition: cubit.allUsers.isNotEmpty,
          builder: (context) =>  ListView.separated(
              itemBuilder: (context,index) => buildListUsers(cubit.allUsers[index] as UserDataModel,context),
              separatorBuilder: (context,index) => line(),
              itemCount: cubit.allUsers.length
          ),
          fallback: (context)=> const Center(
            child: Image(image: AssetImage('assets/images/empty.png'), width: 200.0, ),
          ),
        );
      },
      listener: (BuildContext context, SocialStates state) {},
    );
  }
  Widget buildListUsers(UserDataModel model , context) =>  InkWell(
    onTap: (){
      NavigateTo(context, ReceiverProfileScreen(userModel: model));
      SocialCubit.get(context).getFollowing(Id: model.uId!);
      SocialCubit.get(context).getFollowers(Id: model.uId!);
      SocialCubit.get(context).getMyPosts(Id: model.uId!);
      },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 30.0,
                backgroundImage: NetworkImage(
                    '${model.image}'
                ),
              ),
              const SizedBox(
                width: 7.0,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('${model.username}' , style: TextStyle(fontSize: 20.0 , fontWeight: FontWeight.w600),),
                  const SizedBox(
                    width: 2.0,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
