import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/Shared/Components/Components.dart';
import 'package:to_do_app/Shared/styles/colors.dart';
import 'package:to_do_app/layout/SocialAppLayout/cubit/cubit.dart';
import 'package:to_do_app/layout/SocialAppLayout/cubit/states.dart';

import '../../../Shared/styles/icon_broken.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (BuildContext context, Object? state) {},
      builder: (BuildContext context, state) {
        var userModel = SocialCubit.get(context).userModel;
        var profileImage = SocialCubit.get(context).profileImage;
        var coverImage = SocialCubit.get(context).coverImage;
        var nameController = TextEditingController();
        var bioController = TextEditingController();
        var phoneController = TextEditingController();

        nameController.text = SocialCubit.get(context).userModel!.username! ;
        bioController.text = SocialCubit.get(context).userModel!.bio! ;
        phoneController.text = SocialCubit.get(context).userModel!.phone! ;
        return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(IconBroken.Arrow___Left_2),
              ),
              title: const Text('Edit Profile'),
              titleSpacing: 0.5,
              actions: [
                Container(
                  width: 70.0,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0)
                  ),
                  child: MaterialButton(
                    focusColor: defaultColor,
                    color: defaultColor,
                      onPressed: (){
                      SocialCubit.get(context).UpdateData(phone: phoneController.text, name: nameController.text, bio: bioController.text);
                      },
                    child: Text('Edit',style: TextStyle(fontWeight: FontWeight.w500 , fontSize: 20.0,color: Colors.white),),
                  ),
                )
                ,
                const SizedBox(width: 10,)
              ],
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    if( state is SocialUploadProfileImageLoadingState || state is SocialUploadImageCoverLoadingState || state is SocialUpdateDataLoadingState)
                    const LinearProgressIndicator(),
                    SizedBox(height: 10.0,),
                    Container(
                      height: 180.0,
                      child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          Align(
                            alignment: AlignmentDirectional.topCenter,
                            child: Stack(
                              alignment: AlignmentDirectional.topEnd,
                              children: [
                                Container(
                                  clipBehavior: Clip.antiAlias,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.0),
                                    ),
                                  ),
                                  child: Image(
                                    image:  coverImage == null ? NetworkImage('${userModel!.cover}') : Image.file(coverImage).image,
                                    fit: BoxFit.cover,
                                    height: 150.0,
                                    width: double.infinity,
                                  ),
                                ),
                                CircleAvatar(
                                  radius: 20.0,
                                    child: IconButton(
                                      color: Colors.white,
                                        onPressed: (){
                                        SocialCubit.get(context).getCoverImage();
                                        },
                                        icon: const Icon(IconBroken.Camera,color: Colors.white,)
                                    )
                                )
                              ],
                            ),
                          ),
                          CircleAvatar(
                            radius: 55.0,
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            child: Stack(
                              alignment: AlignmentDirectional.bottomEnd,
                              children: [
                                CircleAvatar(
                                  radius: 50,
                                backgroundImage: profileImage == null ? NetworkImage('${userModel!.image}') : Image.file(profileImage).image
                                ),
                                CircleAvatar(
                                    radius: 20.0,
                                    child: IconButton(
                                        color: Colors.white,
                                        onPressed: (){
                                          SocialCubit.get(context).getProfileImage();
                                        },
                                        icon: const Icon(IconBroken.Camera,color: Colors.white,)
                                    )
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 10.0,),
                    Row(
                      children: [
                        if(SocialCubit.get(context).profileImage != null )
                        Expanded(
                          child: defaulButton(function: (){
                            SocialCubit.get(context).uploadProfileImage(phone: phoneController.text, name: nameController.text, bio: bioController.text);
                          }, name: 'Edit Profile IMage' ,),
                        ),
                        SizedBox(width: 5.0,),
                        if(SocialCubit.get(context).coverImage != null )
                        Expanded(
                          child: defaulButton(function: (){
                            SocialCubit.get(context).uploadCoverImage(phone: phoneController.text, name: nameController.text, bio: bioController.text);
                          },name: 'Edit Cover IMage',),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0,),
                    default_TextField(
                        titleController: nameController,
                        valdate: (String value){
                          if(value.isEmpty){
                            return 'Name Must Not be Empty';
                          }
                        },
                        prefixIcon: IconBroken.User,
                        isShow: false,
                        type: TextInputType.name,
                      hintText: 'Name'
                    ),
                    const SizedBox(height: 10.0,),
                    default_TextField(
                        titleController: bioController,
                        valdate: (String value){
                          if(value.isEmpty){
                            return 'Bio Must Not be Empty';
                          }
                        },
                        prefixIcon: IconBroken.Info_Circle,
                        isShow: false,
                        type: TextInputType.text,
                        hintText: 'Bio....'
                    ),
                    const SizedBox(height: 10.0,),
                    default_TextField(
                        titleController: phoneController,
                        valdate: (String value){
                          if(value.isEmpty){
                            return 'Phone Must Not be Empty';
                          }
                        },
                        prefixIcon: IconBroken.Call,
                        isShow: false,
                        type: TextInputType.text,
                        hintText: 'Phone'
                    ),
                  ],
                ),
              ),
            ));
      },
    );
    ;
  }
}
