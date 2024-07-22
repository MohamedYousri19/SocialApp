import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Moduoles/counter/cubit/cubit.dart';
import '../../Moduoles/counter/cubit/states.dart';

class Counter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CounterCubit(),
      child: BlocConsumer<CounterCubit,CounterState>(
        listener: (context,state){},
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(
              title: const Text('Counter'),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: (){
                          CounterCubit.get(context).plus();
                        },
                        icon: Icon(Icons.add)
                    ),
                    Text('${CounterCubit.get(context).counter}'),
                    IconButton(
                        onPressed: (){
                          CounterCubit.get(context).minus();
                        },
                        icon: Icon(Icons.remove)
                    )
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
