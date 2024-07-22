import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Moduoles/counter/cubit/states.dart';

class CounterCubit extends Cubit<CounterState>{
  CounterCubit(): super(CounterInitialState());
  static CounterCubit get(context) => BlocProvider.of(context) ;
  int counter = 1 ;

  void minus(){
    counter -- ;
    emit(CounterMinusState());
  }

  void plus(){
    counter ++ ;
    emit(CounterPlusState());
  }
}