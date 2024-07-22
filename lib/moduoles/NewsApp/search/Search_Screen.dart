import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Shared/Components/Components.dart';
import '../../../layout/NewsApp/Cubit/cubit.dart';
import '../../../layout/NewsApp/Cubit/states.dart';

class SearchScreen extends StatelessWidget
{
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state)
      {
        var list = NewsCubit.get(context).search;

        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children:
            [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: default_TextField(
                  titleController: searchController,
                  type: TextInputType.text,
                  // Changed: (value)
                  // {
                  //   NewsCubit.get(context).getSearch(value);
                  // },
                  valdate: (String value)
                  {
                    if(value.isEmpty)
                    {
                      return 'search must not be empty';
                    }
                    return null;
                  },
                  hintText: 'Search',
                  prefixIcon: Icons.search, isShow: false,
                ),
              ),
              Expanded(child: ListView.separated(
                  itemBuilder: (context,index) => build_list_news(list[index], context),
                  separatorBuilder: (context,index) => line(),
                  itemCount: list.length
              )),
            ],
          ),
        );
      },
    );
  }
}
