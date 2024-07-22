import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/layout/NewsApp/Cubit/cubit.dart';
import 'package:to_do_app/layout/NewsApp/Cubit/states.dart';
import 'package:to_do_app/layout/todoApp/cubit/cubit.dart';
import '../../Shared/Components/Components.dart';
import '../../moduoles/NewsApp/search/Search_Screen.dart';


class News_layout extends StatelessWidget {
  const News_layout({super.key});
  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<NewsCubit,NewsStates>(
      listener:(context,state){} ,
      builder:(context,state){
        NewsCubit cubit = NewsCubit.get(context) ;
        return  Scaffold(
          appBar: AppBar(
            title: Text(cubit.titles[cubit.CurrentIndex]),
            actions: [
              IconButton(
                  onPressed: (){
                    NavigateTo(context, SearchScreen()) ;
                  },
                  icon: const Icon(CupertinoIcons.search),
              ),
              IconButton(
                  onPressed: (){
                    AppCupit.get(context).changeAppMode();
                  },
                  icon: const Icon(Icons.brightness_4_outlined)
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.CurrentIndex,
            onTap: (index){
              cubit.ChangeCurrentIndex(index);
            },
            items: cubit.bottomItem,
          ),
          body: cubit.screens[cubit.CurrentIndex]
        );
      } ,
    );
  }
}
