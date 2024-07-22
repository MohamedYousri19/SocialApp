import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:to_do_app/Shared/Components/Components.dart';
import 'package:to_do_app/layout/SocialAppLayout/cubit/states.dart';
import '../../moduoles/SocialApp/AddPost/AddPostScreen.dart';
import 'cubit/cubit.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (BuildContext context, state) {
        if(state is SocialAddPostState){
          NavigateTo(context, AddPostScreen());
        }
      },
      builder: (BuildContext context, Object? state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.titles[cubit.currentIndex]),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(IconBroken.Notification)
              ),
              IconButton(
                  onPressed: () {},
                  icon: Icon(IconBroken.Search)
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeBottomNav(index);
              },
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(IconBroken.Home), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(IconBroken.Chat), label: 'Chats'),
                BottomNavigationBarItem(
                    icon: Icon(IconBroken.Paper_Upload), label: 'Post'),
                BottomNavigationBarItem(
                    icon: Icon(IconBroken.User), label: 'Users'),
                BottomNavigationBarItem(
                    icon: Icon(IconBroken.Profile), label: 'Profile'),
              ]),
        );
      },
    );
  }
}
