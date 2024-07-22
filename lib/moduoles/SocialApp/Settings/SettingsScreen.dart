import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:to_do_app/Shared/Components/Components.dart';
import 'package:to_do_app/Shared/styles/Colors.dart';
import 'package:to_do_app/layout/SocialAppLayout/cubit/cubit.dart';
import 'package:to_do_app/layout/SocialAppLayout/cubit/states.dart';
import 'package:to_do_app/moduoles/SocialApp/AddPost/AddPostScreen.dart';
import 'package:to_do_app/moduoles/SocialApp/Edit_Profile/Edit_Profile.dart';
import 'package:to_do_app/moduoles/SocialApp/Following/FollowingScreen.dart';

import '../../../Models/SocialApp/PostModel.dart';
import '../CommentScreen/CommentsScreen.dart';
import '../Followers/FollowersScreen.dart';
import '../Likes/Likes.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<SocialCubit,SocialStates>(
      listener: (BuildContext context, SocialStates state) {  },
      builder: (BuildContext context, SocialStates state) {
        var cubit =SocialCubit.get(context) ;
        var userModel = SocialCubit.get(context).userModel ;
        var controller = TextEditingController() ;
        return  ConditionalBuilder(
            condition: userModel != null ,
            builder: (context) => SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      height: 180.0,
                      child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          Align(
                            alignment: AlignmentDirectional.topCenter,
                            child: Container(
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                              child: Image(
                                image: NetworkImage(
                                    '${userModel!.cover}'
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
                        Text('${userModel.username}',style: Theme.of(context).textTheme.bodyText1,),
                        Text('${userModel.bio}',style: Theme.of(context).textTheme.caption,),
                      ],
                    ),
                    SizedBox(height: 10.0,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: InkWell(
                            child:
                            Column(
                              children: [
                                Text('${cubit.myPosts.length}',style: Theme.of(context).textTheme.bodyText1,),
                                Text('Posts',style: Theme.of(context).textTheme.caption?.copyWith(fontWeight: FontWeight.bold,color: Colors.grey),),
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
                                Text('${SocialCubit.get(context).myFollowers.length}',style: Theme.of(context).textTheme.bodyText1),
                                Text('Followers',style: Theme.of(context).textTheme.caption?.copyWith(fontWeight: FontWeight.bold,color: Colors.grey),),
                              ],
                            ),
                            onTap: (){
                              NavigateTo(context, FollowersScreen());
                            },
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            child:
                            Column(
                              children: [
                                Text('${SocialCubit.get(context).myFollowing.length}',style: Theme.of(context).textTheme.bodyText1),
                                Text('Following',style: Theme.of(context).textTheme.caption?.copyWith(fontWeight: FontWeight.bold,color: Colors.grey),),
                              ],
                            ),
                            onTap: (){
                              NavigateTo(context, FollowingScreen());
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0,),
                    Row(
                      children: [
                        Expanded(child: OutlinedButton(onPressed: (){
                          NavigateTo(context, const AddPostScreen());
                        }, child: Text('Add Posts',style: Theme.of(context).textTheme.subtitle1?.copyWith(color: defaultColor,fontWeight: FontWeight.bold),))),
                        IconButton(
                            color: defaultColor,
                            onPressed: (){
                              NavigateTo(context, EditProfileScreen());
                            },
                            icon: Icon(IconBroken.Edit,color: defaultColor,size: 27.0,)
                        )
                      ],
                    ),
                    SizedBox(height: 20.0,),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context,index) => cubit.myPosts.isEmpty ? const Center(
                        child: Image(image: AssetImage('assets/images/empty.png'), width: 200.0, ),
                      )  : buildPostItem(cubit.myPosts[index],context , index , controller) ,
                      itemCount: cubit.myPosts.length,
                      separatorBuilder: (BuildContext context, int index) => SizedBox(height: 15.0,),
                    )
                  ],
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
    margin: EdgeInsets.symmetric(horizontal: 15.0),
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
              SizedBox(
                width: 7.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text('${model.username}'),
                      SizedBox(
                        width: 2.0,
                      ),
                      Icon(
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
                        .caption
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
                style: TextStyle(height: 1.2),
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
          SizedBox(height: 7.0,),
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
                child: Row(
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
}
