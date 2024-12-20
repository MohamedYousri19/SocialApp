import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/Models/SocialApp/PostModel.dart';
import 'package:to_do_app/Shared/Components/Components.dart';
import 'package:to_do_app/Shared/styles/colors.dart';
import 'package:to_do_app/layout/SocialAppLayout/cubit/cubit.dart';
import 'package:to_do_app/layout/SocialAppLayout/cubit/states.dart';
import 'package:to_do_app/moduoles/SocialApp/CommentScreen/CommentsScreen.dart';
import 'package:to_do_app/moduoles/SocialApp/Likes/Likes.dart';

import '../../../Shared/styles/icon_broken.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (BuildContext context, SocialStates state) {  },
      builder: (BuildContext context, SocialStates state) {
        var cubit = SocialCubit.get(context);
        Future<void> refresh() async{
          await cubit.getPosts();
        }
        var controller = TextEditingController() ;
        return  RefreshIndicator(
          onRefresh: () {
            return refresh();
          },
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics:  BouncingScrollPhysics(),
            child: Column(
              children: [
                Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 20.0,
                  margin: const EdgeInsets.all(8.0),
                  child: Stack(
                    alignment: AlignmentDirectional.bottomStart,
                    children: [
                      const Image(
                        image: NetworkImage(
                          'https://img.freepik.com/free-photo/front-view-young-woman-shows-empty-hand-with-elegance_140725-37664.jpg?t=st=1716657827~exp=1716661427~hmac=b40c4a5cc7ee82038db3a7191926f58d6f29d7e2d81e32ba8abe924dadcf3956&w=740',
                        ),
                        fit: BoxFit.cover,
                        height: 200.0,
                        width: double.infinity,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Communicate with friends',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10,),
                ConditionalBuilder(
                  condition: SocialCubit.get(context).userModel != null   ,
                  builder:  (context) => ConditionalBuilder(
                      condition: SocialCubit.get(context).posts.isNotEmpty,
                      builder: (context) =>  ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context,index) => buildPostItem(cubit.posts[index],context , index , controller ),
                        itemCount: cubit.posts.length,
                        separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 15.0,),
                      ),
                      fallback: (context) =>  const Center ( child: Image(image: AssetImage('assets/images/empty.png')))
                  ),
                  fallback: (context) => const Center(
                    child:CircularProgressIndicator(),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }


  Widget buildPostItem(PostDataModel model,context,index,TextEditingController controller) => Card(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 5.0,
    margin: const EdgeInsets.symmetric(horizontal: 15.0),
    color: Colors.white,
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
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
                        .bodySmall
                        ?.copyWith(color: Colors.grey[600]),
                  )
                ],
              ),
              Spacer(),
              IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.more_horiz_rounded))
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
          Column(
            children: [
              Text(
               '${model.text}',
               style: TextStyle(height: 1.2 ,),
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
                         Icon(
                          IconBroken.Heart,
                          size: 23.0,
                           color:  Colors.red ,
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
              Expanded(child: buildInputItem(context, index)),
              //Expanded(
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
              ),
            ],
          )
        ],
      ),
    ),
  );
  Widget buildInputItem(context , index) => Row(
    children: [
      Expanded(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.grey[600],
                borderRadius: BorderRadius.circular(13.0)
            ),
            child: TextFormField(
              onFieldSubmitted: (value){
                SocialCubit.get(context).addComment(SocialCubit.get(context).postsId[index], value.toString());
              },
                keyboardType: TextInputType.text,
                cursorColor: Colors.grey,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Write a Comment ...',
                  hintStyle: const TextStyle(
                      color: Colors.white, fontSize: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(13.0),
                    borderSide: const BorderSide(
                        color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.grey,),
                    borderRadius: BorderRadius.circular(13.0),
                  ),
                )
            ),
          )
      ),
    ],
  );
}
