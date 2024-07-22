import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do_app/layout/ShopLayout/cubit/cubit.dart';
import 'package:to_do_app/layout/ShopLayout/cubit/states.dart';

class Cach_Data extends StatelessWidget {
  late Database database;

  List<Map> newtasks = [];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ShopCubit.get(context) ;
          return Scaffold(
              appBar: AppBar(
                title: const Text('Cache Data'),
              ),
              body:ConditionalBuilder(
                  condition: cubit.homeModel != null ,
                  builder: (context) =>  Column(
                    children: [
                      Image(
                          image: CachedNetworkImageProvider('${cubit.homeModel!.data!.products[0].image}'))
                    ],
                  ) ,
                  fallback: (context) => Center(child: CircularProgressIndicator())
              )
            //ListView.separated(
              //     itemBuilder: (context, index) =>build_list_news(list,context),
              //     separatorBuilder:(context, index) => SizedBox(height: 20.0,),
              //     itemCount: list.length
              // )
              );
        });
  }
}
