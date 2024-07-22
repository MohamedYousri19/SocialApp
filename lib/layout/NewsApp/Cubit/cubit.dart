import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/layout/NewsApp/Cubit/states.dart';
import 'package:flutter/material.dart';
import '../../../Network/Remote/dio_helper.dart';
import '../../../moduoles/NewsApp/busines_screen/Business_screen.dart';
import '../../../moduoles/NewsApp/science_screen/Science_screen.dart';
import '../../../moduoles/NewsApp/sports_screen/Sports_Screen.dart';

class NewsCubit extends Cubit<NewsStates>{
  NewsCubit(): super(NewsInitialize());
  static NewsCubit get(context) => BlocProvider.of(context) ;
  int CurrentIndex = 0 ;
  List<String> titles = [
    'Business News',
    'Science News',
    'Sports News',
  ] ;
  List<Widget> screens = [
    Business_Screen(),
    Science_Screen(),
    Sports_Screen(),
  ] ;
  List<BottomNavigationBarItem> bottomItem =[
    const BottomNavigationBarItem(
      icon: Icon(Icons.monetization_on_outlined),
      label: 'Business',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.science),
      label: 'Science',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.sports_basketball),
      label: 'Sports',
    ),
  ] ;

  void ChangeCurrentIndex(int index){
    CurrentIndex = index ;
    if(CurrentIndex == 1) getScience() ;
    if(CurrentIndex == 2) getSports() ;
    emit(NewsChangeCurrentIndex()) ;
  }
  List<dynamic> business = [] ;
  void getBusiness(){
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country':'in',
          'apiKey':'d50f0e513f80449d979f9d24bcf9d084',
        }
    ).then((value) => {
      business = value.data['articles'] ,
      print(business.toString()),
      emit(NewsGetBusinessSuccessState())
    }).catchError((error){
      print(error.toString());
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }

  List<dynamic> Science = [] ;
  void getScience(){
    emit(NewsGetScienceLoadingState());
    if(Science.length == 0){
      DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'country':'in',
            'category':'science',
            'apiKey':'d50f0e513f80449d979f9d24bcf9d084',
          }
      ).then((value) => {
        Science = value.data['articles'] ,
        print(Science.toString()),
        emit(NewsGetScienceSuccessState())
      }).catchError((error){
        print(error.toString());
        emit(NewsGetScienceErrorState(error.toString()));
      });
    }else{emit(NewsGetScienceSuccessState());}
  }

  List<dynamic> Sports = [] ;
  void getSports(){
    emit(NewsGetSportsLoadingState());
    if(Sports.length == 0 ){
      DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'country':'in',
            'category':'sports',
            'apiKey':'d50f0e513f80449d979f9d24bcf9d084',
          }
      ).then((value) => {
        Sports = value.data['articles'] ,
        print(Sports.toString()),
        emit(NewsGetSportsSuccessState())
      }).catchError((error){
        print(error.toString());
        emit(NewsGetSportsErrorState(error.toString()));
      });
    }else{emit(NewsGetSportsSuccessState());}
  }

  List<dynamic> search = [] ;
  void getSearch(dynamic value){
    search = [] ;
    emit(NewsGetSearchLoadingState());
    DioHelper.getData(
        url: 'v2/everything',
        query: {
          'q':'$value',
          'apiKey':'d50f0e513f80449d979f9d24bcf9d084',
        }
    ).then((value) => {
      emit(NewsGetSearchSuccessState1()),
      search = value.data['articles'] ,
      print(search.toString()),
      emit(NewsGetSearchSuccessState()),
    }).catchError((error){
      print(error.toString());
      emit(NewsGetSearchErrorState(error.toString()));
    });
  }
  void delteContent(){
    search = [] ;
    emit(NewsDelete()) ;
  }
}