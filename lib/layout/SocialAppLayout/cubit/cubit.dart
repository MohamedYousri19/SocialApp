import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:to_do_app/Models/SocialApp/Comments.dart';
import 'package:to_do_app/Models/SocialApp/FolloweModel.dart';
import 'package:to_do_app/Models/SocialApp/MessageModel.dart';
import 'package:to_do_app/Models/SocialApp/PostModel.dart';
import 'package:to_do_app/Models/SocialApp/Social_User_Model.dart';
import 'package:to_do_app/Models/SocialApp/likes.dart';
import 'package:to_do_app/Network/Local/Cach_Helper.dart';
import 'package:to_do_app/layout/SocialAppLayout/cubit/states.dart';
import 'package:to_do_app/moduoles/SocialApp/Chats/ChatsScreen.dart';
import 'package:to_do_app/moduoles/SocialApp/Feeds/FeedsScreen.dart';
import 'package:to_do_app/moduoles/SocialApp/Settings/SettingsScreen.dart';
import 'package:to_do_app/moduoles/SocialApp/Users/UsersScreen.dart';
import '../../../Shared/Components/Components.dart';
import '../../../Shared/Components/Constants.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);
  UserDataModel? userModel;

  Future<void> getUserData() async {
    emit(SocialGetUserLoadingState());
    print('uId');
    print(uId);
    FirebaseFirestore.instance
        .collection('users')
        .doc(CachHelper.getData(key: 'uId'))
        .get()
        .then((value) =>
    {
      userModel = UserDataModel.FromJson(value.data()!),
      print(value.data()),
      emit(SocialGetUserSuccessState()),
    })
        .catchError((error) {
          if (kDebugMode) {
            print(error.toString());
            print("error.toString()");
          }
      emit(SocialGetUserErrorState(error.toString()));
    });
  }

  int currentIndex = 0;

  List<Widget> screens = [
    const FeedsScreen(),
    const ChatsScreen(),
    Container(),
    const UsersScreen(),
    const SettingsScreen()
  ];

  List<String> titles = [
    'Home',
    'Chats',
    '',
    'Users',
    'Profile',
  ];

  void changeBottomNav(int index) {
    if(index == 0){
      getPosts() ;
    }
    if(index == 1){
      getAllUsers() ;
    }
    if(index == 3){
      getAllUsers() ;
    }
    if(index == 4){
      getMyPosts(Id: userModel!.uId!);
      getFollowers(Id: userModel!.uId!) ;
      getFollowing(Id: userModel!.uId!) ;
    }
    if (index == 2) {
      emit(SocialAddPostState());
    } else {
      currentIndex = index;
      emit(SocialChangeNavState());
    }
  }

  File? profileImage;

  Future getProfileImage() async {
    final pickedFile =
    await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(SocialPickedImageSuccessState());
    } else {
      print('No image selected.');
      emit(SocialPickedImageErrorState());
    }
  }

  File? coverImage;

  Future getCoverImage() async {
    final pickedFile =
    await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(SocialPickedImageCoverSuccessState());
    } else {
      print('No image selected.');
      emit(SocialPickedImageCoverErrorState());
    }
  }


  Future<void> uploadProfileImage({
    required String phone,
    required String name,
    required String bio,
  }) async {
    emit(SocialUploadProfileImageLoadingState());
    await FirebaseStorage.instance
        .ref()
        .child('users/${Uri
        .file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) =>
    {
      value.ref
          .getDownloadURL()
          .then((value) =>
      {
        print(value),
        UpdateData(phone: phone, name: name, bio: bio, image: value),
        emit(SocialUploadProfileImageSuccessState()),
      })
          .catchError((error) {
        print(error.toString());
        emit(SocialUploadProfileImageErrorState());
      })
    })
        .catchError((error) {
      print(error.toString());
      emit(SocialUploadProfileImageErrorState());
    });
  }


  void uploadCoverImage({
    required String phone,
    required String name,
    required String bio,
  }) {
    emit(SocialUploadImageCoverLoadingState());
    FirebaseStorage.instance
        .ref()
        .child('users/${Uri
        .file(coverImage!.path)
        .pathSegments
        .last}')
        .putFile(coverImage!)
        .then((value) =>
    {
      value.ref
          .getDownloadURL()
          .then((value) =>
      {
        print(value),
        UpdateData(phone: phone, name: name, bio: bio, cover: value),
        emit(SocialUploadImageCoverSuccessState()),
      })
          .catchError((error) {
        print(error.toString());
        emit(SocialUploadImageCoverErrorState());
      })
    })
        .catchError((error) {
      print(error.toString());
      emit(SocialUploadImageCoverErrorState());
    });
  }

  void UpdateData({
    required String phone,
    required String name,
    required String bio,
    String? image,
    String? cover,
  }) {
    emit(SocialUpdateDataLoadingState());
    UserDataModel model1 = UserDataModel(
      uId: userModel!.uId,
      username: name,
      email: userModel!.email,
      image: image ?? userModel!.image,
      bio: bio,
      phone: phone,
      cover: cover ?? userModel!.cover,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .update(model1.toMap()).then((value) =>
    {
      getUserData(),
      ShowToast(text: 'Data edited Successfully', backgroundColor: Colors.green)
    }).catchError((error) {
      print(error.toString());
      ShowToast(
          text: 'Data Not edited Successfully', backgroundColor: Colors.red);
      emit(SocialUpdateDataErrorState());
    });
  }

  File? PostImage;

  Future getPostImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      PostImage = File(pickedFile.path);
      emit(SocialPickedPostImageSuccessState());
    } else {
      print('No image selected.');
      emit(SocialPickedPostImageErrorState());
    }
  }

  void uploadPostImage({
    required String text,
  }) {
    emit(SocialUploadPostImageLoadingState());
    FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(PostImage!.path).pathSegments.last}')
        .putFile(PostImage!)
        .then((value) =>
    {
      value.ref
          .getDownloadURL()
          .then((value) =>
      {
        print(value),
        createNewPost(text: text, postImage: value),
        emit(SocialUploadPostImageSuccessState()),
      })
          .catchError((error) {
        print(error.toString());
        emit(SocialUploadPostImageErrorState());
      })
    })
        .catchError((error) {
      print(error.toString());
      emit(SocialUploadImageCoverErrorState());
    });
  }


  void createNewPost({
    required String text,
    String? postImage,

  }) {
    emit(SocialCreateNewPostLoadingState());
    PostDataModel model1 = PostDataModel(
      username: userModel!.username,
      image: userModel!.image,
      uId: userModel!.uId,
      text: text,
      dateTime: DateTime.now().toString(),
      postImage: postImage ?? '',
      cover: userModel!.cover,
      bio: userModel!.bio,
    );

    FirebaseFirestore.instance
        .collection('posts')
        .add(model1.toMap()).then((value) =>
    {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('myPosts')
        .add(model1.toMap())
        .then((value) => {
      emit(SocialCreateNewPostSuccessState()),
    })
        .catchError((error){
      emit(SocialCreateNewPostErrorState());
    }),
      emit(SocialCreateNewPostSuccessState()),
    }).catchError((error) {
      print(error.toString());
      emit(SocialCreateNewPostErrorState());
    });
  }

  List<PostDataModel> posts = [];
  List postsId = [];
  List likes = [];

  Future<void> getPosts() async {
    emit(SocialGetPostsLoadingState());
    posts = [];
    likes = [];
    postsId = [];
    FirebaseFirestore.instance
        .collection('posts')
        .orderBy('dateTime')
        .get()
        .then((value) =>
    {
      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) =>
        {
          likes.add(value.docs.length),
          postsId.add(element.id),
          posts.add(PostDataModel.FromJson(element.data())),
          print(likes),
          print('postsId'),
          print(postsId),
        emit(SocialGetPostsSuccessState()),
        }).catchError((error) {
          emit(SocialGetPostsErrorState(error.toString()));
        });
        emit(SocialGetPostsSuccessState());
      }),

    })
        .catchError((error) {
      print(error.toString());
      emit(SocialGetPostsErrorState(error.toString()));
    });
  }

  List<PostDataModel> myPosts = [] ;
  void getMyPosts({
    required String Id ,
}){
    emit(SocialGetMyPostsLoadingState());
    myPosts = [] ;
    FirebaseFirestore.instance
        .collection('users')
        .doc(Id)
        .collection('myPosts')
        .get().then((value) =>
    {
      value.docs.forEach((element) {
        myPosts.add(PostDataModel.FromJson(element.data()));
        emit(SocialGetMessageSuccessState());
      }),
      emit(SocialGetMessageSuccessState()),
    })
        .catchError((error){
          emit(SocialGetMessageErrorState());
    });
  }


  void likePost(String postId) {
    emit(SocialLikePostLoadingState());
    likesDataModel model1 = likesDataModel(
      like: true,
      uId: userModel!.uId,
      username: userModel!.username,
      image: userModel!.image,
    );
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uId)
        .set(model1.toMap())
        .then((value) =>
    {
      emit(SocialLikePostSuccessState()),
    })
        .catchError((error) {
      print(error.toString());
      emit(SocialLikePostErrorState());
    });
  }

  List<likesDataModel> userLikes = [];

  void getLikePost(String postId) {
    userLikes = [] ;
    emit(SocialGetLikePostLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .get()
        .then((value) => {
          value.docs.forEach((element) {
            userLikes.add(likesDataModel.FromJson(element.data()));
            emit(SocialGetLikePostSuccessState());
          })
    }).catchError((error) {
      emit(SocialGetLikePostErrorState());
    });
  }


  void addComment(String commentsId , text) {
    emit(SocialCommentLoadingState());
    CommentsDataModel model1 = CommentsDataModel(
      text: text,
      uId: userModel!.uId,
      username: userModel!.username,
      image: userModel!.image,
    );
    FirebaseFirestore.instance
        .collection('posts')
        .doc(commentsId)
        .collection('comments')
        .add(model1.toMap())
        .then((value) =>
    {
      ShowToast(text: 'Comment Added Successfully', backgroundColor: Colors.black),
      emit(SocialCommentSuccessState()),
    })
        .catchError((error) {
      print(error.toString());
      emit(SocialCommentErrorState());
    });
  }

  List<CommentsDataModel> Comments = [];

  void getCommentsPost(String postId) {
    Comments = [] ;
    emit(SocialGetCommentPostLoadingState());
    FirebaseFirestore.instance
        .collection('posts').doc(postId).collection('comments').get().then((value) =>
    {
      value.docs.forEach((element) {
        Comments.add(CommentsDataModel.FromJson(element.data()));
        emit(SocialGetCommentPostSuccessState());
      }),
    emit(SocialGetCommentPostSuccessState()),
    }).catchError((error){
      emit(SocialGetCommentPostErrorState());
    });
  }


  void deleteImage(){
    PostImage = null ;
    emit(SocialDeleteImageState());
  }

  List<UserDataModel> allUsers = [];

  Future<void> getAllUsers() async {
    allUsers = [] ;
    emit(SocialGetAllUsersLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((value) =>
    {
      value.docs.forEach((element) {
        if(element.data()['uId'] != userModel!.uId){
          allUsers.add(UserDataModel.FromJson(element.data()));
        }
        print(allUsers);
        emit(SocialGetAllUsersSuccessState());
      }),
    emit(SocialGetAllUsersSuccessState()),
    })
        .catchError((error) {
      print(error.toString());
      emit(SocialGetAllUsersErrorState(error.toString()));
    });
  }

  void SendMessage({
    required String receiverId,
    required String text,
}){
    MessageModel message = MessageModel(
      receiverId: receiverId,
      message: text,
      dateTime: DateTime.now().toString(), 
      senderId: userModel!.uId,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(message.toMap())
        .then((value) => {
          emit(SocialSendMessageSuccessState()),
    })
        .catchError((error){
          emit(SocialSendMessageErrorState());
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel!.uId)
        .collection('messages')
        .add(message.toMap())
        .then((value) => {
      emit(SocialSendMessageSuccessState()),
    })
        .catchError((error){
      emit(SocialSendMessageErrorState());
    });
  }
  List<MessageModel> messages = [] ;
  void getMessages({
    required String receiverId,
  }){
    messages = [] ;
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
          messages = [] ;
          event.docs.forEach((element) {
            messages.add(MessageModel.FromJson(element.data()));
          });
          emit(SocialGetMessageSuccessState());
    });
  }

  void addFollower({
    required String name,
    required String image,
    required String uId,
}){
   var FollwerModel1 = FollowerModel(
    username:name ,
    image: image,
    uId: uId,
    dateTime: DateTime.now().toString(),
    );

   var FollwerModel2 = FollowerModel(
     username:userModel!.username ,
     image: userModel!.image,
     uId: userModel!.uId,
     dateTime: DateTime.now().toString(),
   );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('Following')
        .doc(uId)
        .set(FollwerModel1.toMap())
        .then((value) => {
          emit(SocialSendFollowerSuccessState()),
    })
        .catchError((error){
          emit(SocialSendFollowerErrorState());
    });

   FirebaseFirestore.instance
       .collection('users')
       .doc(uId)
       .collection('Followers')
       .doc(userModel!.uId)
       .set(FollwerModel2.toMap())
       .then((value) => {
     emit(SocialSendFollowerSuccessState()),
   })
       .catchError((error){
     emit(SocialSendFollowerErrorState());
   });;
}

List<FollowerModel> myFollowers = [] ;
void getFollowers({
    required String Id,
}){
  emit(SocialGetFollowerLoadingState());
  myFollowers = [] ;
    FirebaseFirestore.instance
        .collection('users')
        .doc(Id)
        .collection('Followers')
        .get().then((value) =>
    {
      value.docs.forEach((element) {
        myFollowers.add(FollowerModel.FromJson(element.data()));
        emit(SocialGetFollowerSuccessState());
      })
    }).catchError((error){
      emit(SocialGetFollowerErrorState());
    });
}

  List<FollowerModel> myFollowing = [] ;
  void getFollowing({
    required String Id,
  }){
    emit(SocialGetFollowingLoadingState());
    myFollowing = [] ;
    FirebaseFirestore.instance
        .collection('users')
        .doc(Id)
        .collection('Following')
        .get().then((value) =>
    {
      value.docs.forEach((element) {
        myFollowing.add(FollowerModel.FromJson(element.data()));
        emit(SocialGetFollowerSuccessState());
      })
    }).catchError((error){
      emit(SocialGetFollowingErrorState());
    });
  }
}
