import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/Network/Local/Cach_Helper.dart';
import 'package:to_do_app/Network/Remote/dio_helper.dart';
import 'package:to_do_app/Shared/Components/Components.dart';
import 'package:to_do_app/layout/ShopLayout/cubit/states.dart';
import 'package:to_do_app/layout/todoApp/cubit/cubit.dart';
import 'package:to_do_app/moduoles/SocialApp/ChatsDetails/ChatsDetailsScreen.dart';
import 'Shared/Components/Constants.dart';
import 'Shared/styles/Themes.dart';
import 'Shared/bolck_observer.dart';
import 'firebase_options.dart';
import 'layout/NewsApp/Cubit/cubit.dart';
import 'layout/ShopLayout/cubit/cubit.dart';
import 'layout/SocialAppLayout/SocialLayout.dart';
import 'layout/SocialAppLayout/cubit/cubit.dart';
import 'moduoles/SocialApp/SocialLogin/SocialLoginScreen.dart';


Future<void> FirebaseBackgroundMessage(RemoteMessage message)async {
  print('on background message') ;
  print(message.data.toString()) ;
  ShowToast(text: 'on background message', backgroundColor: Colors.grey);
}


void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  var token = await FirebaseMessaging.instance.getToken() ;
  print('token') ;
  print(token) ;
  FirebaseMessaging.onMessage.listen((event) {
    print('on message') ;
    print(event.data.toString());
    ShowToast(text: 'on message', backgroundColor: Colors.grey) ;
  });

  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print('on opened app message') ;
    print(event.data.toString());
    ShowToast(text: 'on message opened app', backgroundColor: Colors.grey) ;
  });

  FirebaseMessaging.onBackgroundMessage(FirebaseBackgroundMessage) ;

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CachHelper.init();
  Widget widget ;
  //dynamic onBoarding = CachHelper.getData(key: 'onBoarding');
  //token = CachHelper.getData(key: 'token');
  dynamic isDark = CachHelper.getData(key: 'isDark');
  uId = CachHelper.getData(key: 'uId');
 // print(token) ;
  //print('isDark') ;
 // print(isDark) ;
  print(uId) ;

  if(uId != null){
    widget = const SocialLayout() ;
  }else{
    widget = const SocialLoginScreen() ;
  }

  // if(onBoarding != null){
  //   if(token != null ){
  //     widget = const ShopLayOut();
  //   }else{
  //     widget = const ShopLogin() ;
  //   }
  // }else{
  //   widget =
  //   const OnBoardingScreen() ;
  // }
 //print('onBoarding');
  //print(onBoarding);

  runApp( MyApp(startWidget: widget, isDark: isDark,));
}

class MyApp extends StatelessWidget {
  final Widget startWidget ;
  final dynamic isDark ;
  MyApp({
    super.key,
    required this.startWidget,
    required this.isDark
});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) =>  NewsCubit()..getBusiness(),),
        BlocProvider(create: (context) =>  ShopCubit()..getHomeData()..getCategoriesData()..getFavoritesData()..getUserData()..changeAppMode(
          fromShared: isDark
        )),
        BlocProvider(create: (BuildContext context)=> AppCupit()),
        BlocProvider(create: (BuildContext context)=> SocialCubit()..getUserData()..getPosts()),
      ],
      child: BlocConsumer<ShopCubit,ShopStates>(
        listener: (context,state){},
        builder: (context,state){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme:lightTheme,
            darkTheme: darkTheme ,
            themeMode: ShopCubit.get(context).isDark ? ThemeMode.dark: ThemeMode.light ,
            home: Directionality(
                textDirection: TextDirection.ltr,
                child: startWidget,
            ),
          );
        },
      ),
    );
  }
}