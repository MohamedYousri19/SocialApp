import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/moduoles/SocialApp/ChatsDetails/ChatsDetailsScreen.dart';
import 'package:to_do_app/moduoles/SocialApp/Followers/FollowersScreen.dart';
import 'package:to_do_app/moduoles/SocialApp/Following/FollowingScreen.dart';
import '../../../Models/SocialApp/PostModel.dart';
import '../../../Models/SocialApp/Social_User_Model.dart';
import '../../../Shared/Components/Components.dart';
import '../../../Shared/styles/Colors.dart';
import '../../../Shared/styles/icon_broken.dart';
import '../../../layout/SocialAppLayout/cubit/cubit.dart';
import '../../../layout/SocialAppLayout/cubit/states.dart';
import '../CommentScreen/CommentsScreen.dart';
import '../Likes/Likes.dart';

class ReceiverProfileScreen extends StatelessWidget {
  final UserDataModel userModel ;
  const ReceiverProfileScreen({super.key , required this.userModel});

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<SocialCubit,SocialStates>(
      listener: (BuildContext context, SocialStates state) {  },
      builder: (BuildContext context, SocialStates state) {
        var cubit =SocialCubit.get(context) ;
        var controller = TextEditingController() ;
        return  ConditionalBuilder(
            condition: true ,
            builder: (context) => Scaffold(
              appBar: AppBar(
                leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: const Icon(IconBroken.Arrow___Left)),
                title: Text('${userModel.username}\'s Profile' , style: const TextStyle(fontSize: 17.0),),
                actions: const [
                  Icon(IconBroken.Profile),
                  SizedBox(width: 10.0,)
                ],
              ),
              body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 180.0,
                        child: Stack(
                          alignment: AlignmentDirectional.bottomCenter,
                          children: [
                            Align(
                              alignment: AlignmentDirectional.topCenter,
                              child: Container(
                                clipBehavior: Clip.antiAlias,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),
                                child: Image(
                                  image: NetworkImage(
                                      '${userModel.cover}'
                                  ),
                                  fit: BoxFit.cover,
                                  height: 150.0,
                                  width: double.infinity,
                                ),
                              ),
                            ),
                            CircleAvatar(
                              radius: 55.0,
                              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 50,
                                backgroundImage: NetworkImage('${userModel.image}'),
                              ),
                            )
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Text('${userModel.username}',style: Theme.of(context).textTheme.bodyLarge,),
                          Text('${userModel.bio}',style: Theme.of(context).textTheme.bodySmall,),
                        ],
                      ),
                      const SizedBox(height: 10.0,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: InkWell(
                              child:
                              Column(
                                children: [
                                  Text('${SocialCubit.get(context).myPosts.length}',style: Theme.of(context).textTheme.bodyLarge,),
                                  Text('Posts',style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold,color: Colors.grey),),
                                ],
                              ),
                              onTap: (){},
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              child:
                              Column(
                                children: [
                                  Text('${SocialCubit.get(context).myFollowers.length}',style: Theme.of(context).textTheme.bodyLarge),
                                  Text('Followers',style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold,color: Colors.grey),),
                                ],
                              ),
                              onTap: (){
                                SocialCubit.get(context).getFollowers(Id: userModel.uId!);
                                NavigateTo(context, FollowersScreen());
                              },
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              child:
                              Column(
                                children: [
                                  Text('${SocialCubit.get(context).myFollowing.length}',style: Theme.of(context).textTheme.bodyLarge),
                                  Text('Following',style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold,color: Colors.grey),),
                                ],
                              ),
                              onTap: (){
                                SocialCubit.get(context).getFollowing(Id: userModel.uId!);
                                NavigateTo(context, FollowingScreen());
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10.0,),
                      ListView.builder(
                        shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context,index) => followers(context, index),
                        itemCount: 1,
                      ),
                      const SizedBox(height: 10.0,),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context,index) =>  SocialCubit.get(context).myPosts.isEmpty ? const Center(child: Image(image: AssetImage('assets/images/empty.png'), width: 200.0, ),) :  buildPostItem(cubit.myPosts[index],context , index , controller)   ,
                        itemCount: cubit.myPosts.length,
                        separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 15.0,),
                      )
                    ],
                  ),
                ),
              ),
            ),
            fallback: (context) => const Center(child: CircularProgressIndicator())
        );
      },
    );
  }
  Widget buildPostItem(PostDataModel model,context , index , TextEditingController controller ) =>
      Card(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 5.0,
    margin: const EdgeInsets.symmetric(horizontal: 15.0),
    color: Colors.white,
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 25.0,
                backgroundImage: NetworkImage('${model.image}'),
              ),
              const SizedBox(
                width: 7.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text('${model.username}'),
                      const SizedBox(
                        width: 2.0,
                      ),
                      const Icon(
                        CupertinoIcons.check_mark_circled_solid,
                        size: 14,
                        color: defaultColor,
                      )
                    ],
                  ),
                  Text(
                    '${model.dateTime}',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: Colors.grey[600]),
                  )
                ],
              ),
              const Spacer(),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.more_horiz_rounded))
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Container(
              height: 1,
              width: double.infinity,
              color: Colors.grey,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                '${model.text}',
                style: const TextStyle(height: 1.2),
              ),
            ],
          ),
          // Container(
          //   width: double.infinity,
          //   padding: EdgeInsets.zero,
          //   child: Wrap(
          //     children: [
          //       Container(
          //         height: 20,
          //         child: MaterialButton(
          //           minWidth: 1,
          //           padding: EdgeInsetsDirectional.only(end: 5.0),
          //           onPressed: () {},
          //           child: Text(
          //             '#SoftWare',
          //             style: TextStyle(color: defaultColor),
          //           ),
          //         ),
          //       ),
          //       Container(
          //         height: 20,
          //         child: MaterialButton(
          //           minWidth: 1,
          //           padding: EdgeInsetsDirectional.only(end: 5.0),
          //           onPressed: () {},
          //           child: Text(
          //             '#Flutter Developer',
          //             style: TextStyle(color: defaultColor),
          //           ),
          //         ),
          //       ),
          //       Container(
          //         height: 20,
          //         child: MaterialButton(
          //           minWidth: 1,
          //           padding: EdgeInsetsDirectional.only(end: 5.0),
          //           onPressed: () {},
          //           child: Text(
          //             '#SoftWare_development',
          //             style: TextStyle(color: defaultColor),
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          if(model.postImage != '')
            Padding(
              padding: const EdgeInsetsDirectional.only(top: 10.0),
              child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0)
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Image(image: NetworkImage('${model.postImage}') , fit: BoxFit.cover,)
              ) ,
            ),
          const SizedBox(height: 7.0,),
          Row(
            children: [
              Expanded(
                  child: InkWell(
                    onTap: () {
                      NavigateTo(context, const LikesScreen());
                      SocialCubit.get(context).getLikePost(SocialCubit.get(context).postsId[index]);
                    },
                    child: Row(
                      children: [
                        const Icon(
                          IconBroken.Heart,
                          size: 23.0,
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        Text('${SocialCubit.get(context).likes[index]}')
                      ],
                    ),
                  )),
              Expanded(
                  child: InkWell(
                    onTap: () {
                      SocialCubit.get(context).getCommentsPost(SocialCubit.get(context).postsId[index]);
                      NavigateTo(context,  CommentsScreen(postsId: SocialCubit.get(context).postsId,));
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          IconBroken.Chat,
                          size: 23.0,
                        ),
                        SizedBox(width: 5.0,),
                        Text('Comments')
                      ],
                    ),
                  ))
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Container(
              height: 1,
              width: double.infinity,
              color: Colors.grey,
            ),
          ),
          Row(
            children: [
              CircleAvatar(
                radius: 25.0,
                backgroundImage: NetworkImage('${SocialCubit.get(context).userModel!.image}'),
              ),
              const SizedBox(
                width: 7.0,
              ),
              InkWell(
                  onTap: (){
                    SocialCubit.get(context).getCommentsPost(SocialCubit.get(context).postsId[index]);
                    NavigateTo(context, CommentsScreen(postsId: SocialCubit.get(context).postsId,));
                  },
                  child: Container(
                      padding: const EdgeInsets.all(10.0),
                      child: const Text('Write a Comment')
                  )
              ),
              const Spacer(),
              //   Expanded(
              //   child: Container(
              //     padding: EdgeInsetsDirectional.symmetric(horizontal: 5.0),
              //     child: default_TextField(
              //         valdate: (){},
              //         isShow: false,
              //         type: TextInputType.text,
              //       hintText: 'Comment...',
              //       submit: (value){
              //           print(value) ;
              //           SocialCubit.get(context).addComment(SocialCubit.get(context).postsId[index], value.toString());
              //       }
              //     ),
              //   ),
              // ),
              InkWell(
                onTap: (){
                  SocialCubit.get(context).likePost(SocialCubit.get(context).postsId[index]);
                },
                child: const Row(
                  children: [
                    Icon(IconBroken.Heart),
                    SizedBox(width: 3.0,),
                    Text('Like')
                  ],
                ),
              )
            ],
          )
        ],
      ),
    ),
  );
  Widget followers(context ,index) => Row(
    children: [
      Expanded(
        child:
        SocialCubit.get(context).myFollowers.isEmpty?  Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: defaulButton(function: (){
            SocialCubit.get(context).addFollower(name: userModel.username!, image: userModel.image!, uId: userModel.uId!);
          }, name: 'Follow' ,),
        ) :
        SocialCubit.get(context).myFollowers[index].uId== SocialCubit.get(context).userModel!.uId?
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: defaulButton(function: (){}, name: 'Following',),
        ) :  Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: defaulButton(function: (){
            SocialCubit.get(context).addFollower(name: userModel.username!, image: userModel.image!, uId: userModel.uId!);
          }, name: 'Follow' ,),
        ),

      ),
      Expanded(child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: defaulButton(function: (){
          NavigateTo(context, ChatsDetailsScreen(userDataModel: userModel));
        }, name: 'Send Message' , ),
      )),
    ],
  );
}
