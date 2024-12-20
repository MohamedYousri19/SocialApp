import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:to_do_app/Shared/Components/Components.dart';
import 'package:to_do_app/layout/SocialAppLayout/cubit/cubit.dart';
import 'package:to_do_app/layout/SocialAppLayout/cubit/states.dart';
import '../../../Shared/styles/colors.dart';

class AddPostScreen extends StatelessWidget {
  const AddPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (BuildContext context, Object? state) {  },
      builder: (BuildContext context, state) {
        var cubit = SocialCubit.get(context) ;
        var model = cubit.userModel ;
        var formKey = GlobalKey<FormState>() ;
        var textController = TextEditingController() ;
        return Form(
          key: formKey,
          child: Scaffold(
            appBar:AppBar(
              leading: IconButton(
                onPressed: (){Navigator.pop(context) ;} ,
                icon: const Icon(IconBroken.Arrow___Left_2),
              ),
              title: const Text('Create Post'),
              actions: [
                OutlinedButton(onPressed: (){
                  if(cubit.PostImage != null){
                    SocialCubit.get(context).uploadPostImage(text: textController.text);
                    Navigator.pop(context);
                  }else{
                    if(textController.text.isEmpty){
                      ShowToast(text: 'SomeThing Wrong', backgroundColor: Colors.red);
                    }else{
                      SocialCubit.get(context).createNewPost(text: textController.text);
                      Navigator.pop(context);
                    }
                  };
                }, child: const Text('Post', style: TextStyle(fontSize: 20.0 , fontWeight: FontWeight.w600),)),
                const SizedBox(width: 5.0,),
              ],
            ),
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 25.0,
                          backgroundImage: NetworkImage('${model!.image}'),
                        ),
                        const SizedBox(
                          width: 7.0,
                        ),
                        Text('${model.username}'),
                      ],
                    ),
                    const SizedBox(height: 10.0,),
                    TextFormField(
                      controller: textController,
                      decoration: InputDecoration(
                        hintText: 'what is in your mind ${model.username} ?',
                        border: InputBorder.none,
                      ),
                    ),
                    const SizedBox(height: 20.0,),
                    if(cubit.PostImage != null)
                    Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        Container(
                            width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0)
                          ),
                            clipBehavior: Clip.antiAlias,
                            child: Image(image: Image.file(cubit.PostImage!).image , fit: BoxFit.cover,)
                        ),
                        InkWell(
                          onTap: (){
                            cubit.deleteImage();
                            print(cubit.PostImage) ;
                          },
                          child:
                          const CircleAvatar(
                            radius: 20.0,
                            backgroundColor: Colors.red,
                            child: Icon( IconBroken.Delete , color: Colors.white),
                          ),
                        ),
                      ],
                    ) ,
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 40.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0)
                            ),
                            child: InkWell(
                              onTap: (){
                                cubit.getPostImage() ;
                              },
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(IconBroken.Image ,  color: defaultColor,),
                                  SizedBox(width: 5.0,),
                                  Text('add photos' , style: TextStyle(color: defaultColor),)
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: (){},
                            child: Container(
                              height: 40.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0)
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('# tags' ,style: TextStyle(color: defaultColor),)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
