abstract class SocialStates {}

class SocialInitialState extends SocialStates {}

// Get User Posts

class SocialGetPostsLoadingState extends SocialStates {}

class SocialGetPostsSuccessState extends SocialStates {}

class SocialGetPostsErrorState extends SocialStates {
  final String error ;
  SocialGetPostsErrorState(this.error);
}

// Get My Posts

class SocialGetMyPostsLoadingState extends SocialStates {}

class SocialGetMyPostsSuccessState extends SocialStates {}

class SocialGetMyPostsErrorState extends SocialStates {
  final String error ;
  SocialGetMyPostsErrorState(this.error);
}

// Get User Data

class SocialGetUserLoadingState extends SocialStates {}

class SocialGetUserSuccessState extends SocialStates {}

class SocialGetUserErrorState extends SocialStates {
  final String error ;
  SocialGetUserErrorState(this.error);
}

// Get All User

class SocialGetAllUsersLoadingState extends SocialStates {}

class SocialGetAllUsersSuccessState extends SocialStates {}

class SocialGetAllUsersErrorState extends SocialStates {
  final String error ;
  SocialGetAllUsersErrorState(this.error);
}

// Change Navigate

class SocialChangeNavState extends SocialStates {}

class SocialAddPostState extends SocialStates {}

//Picked Profile image

class SocialPickedImageSuccessState extends SocialStates {}

class SocialPickedImageErrorState extends SocialStates {}

//Picked Cover Image

class SocialPickedImageCoverSuccessState extends SocialStates {}

class SocialPickedImageCoverErrorState extends SocialStates {}

// Upload Profile Image

class SocialUploadProfileImageLoadingState extends SocialStates {}

class SocialUploadProfileImageSuccessState extends SocialStates {}

class SocialUploadProfileImageErrorState extends SocialStates {}

// Upload Cover Image

class SocialUploadImageCoverLoadingState extends SocialStates {}

class SocialUploadImageCoverSuccessState extends SocialStates {}

class SocialUploadImageCoverErrorState extends SocialStates {}

// Update Data

class SocialUpdateDataErrorState extends SocialStates {}

class SocialUpdateDataLoadingState extends SocialStates {}

//Picked Post image

class SocialPickedPostImageSuccessState extends SocialStates {}

class SocialPickedPostImageErrorState extends SocialStates {}

// create New Post

class SocialCreateNewPostLoadingState extends SocialStates {}

class SocialCreateNewPostSuccessState extends SocialStates {}

class SocialCreateNewPostErrorState extends SocialStates {}


// upload Post Image

class SocialUploadPostImageLoadingState extends SocialStates {}

class SocialUploadPostImageSuccessState extends SocialStates {}

class SocialUploadPostImageErrorState extends SocialStates {}
// Like Post
class SocialLikePostLoadingState extends SocialStates {}

class SocialLikePostSuccessState extends SocialStates {}

class SocialLikePostErrorState extends SocialStates {}

// Get Likes Post
class SocialGetLikePostLoadingState extends SocialStates {}

class SocialGetLikePostSuccessState extends SocialStates {}

class SocialGetLikePostErrorState extends SocialStates {}

// Like Post
class SocialCommentLoadingState extends SocialStates {}

class SocialCommentSuccessState extends SocialStates {}

class SocialCommentErrorState extends SocialStates {}

// Get Comment Post
class SocialGetCommentLoadingState extends SocialStates {}

class SocialGetCommentSuccessState extends SocialStates {}

class SocialGetCommentErrorState extends SocialStates {}

// Get number Comments Post
class SocialGetNumberCommentLoadingState extends SocialStates {}

class SocialGetNumberCommentSuccessState extends SocialStates {}

class SocialGetNumberCommentErrorState extends SocialStates {}

// delete image
class SocialDeleteImageState extends SocialStates {}
// refresh
class SocialUpdateState extends SocialStates {}

// Get Comments Post
class SocialGetCommentPostLoadingState extends SocialStates {}

class SocialGetCommentPostSuccessState extends SocialStates {}

class SocialGetCommentPostErrorState extends SocialStates {}

// Get Comments Number Post

class SocialGetCommentNumberPostSuccessState extends SocialStates {}

class SocialGetCommentNumberPostErrorState extends SocialStates {}


// Send Messages

class SocialSendMessageSuccessState extends SocialStates {}

class SocialSendMessageErrorState extends SocialStates {}

// get Messages

class SocialGetMessageSuccessState extends SocialStates {}

class SocialGetMessageErrorState extends SocialStates {}

// Send Followers

class SocialSendFollowerSuccessState extends SocialStates {}

class SocialSendFollowerErrorState extends SocialStates {}

// get Followers

class SocialGetFollowerLoadingState extends SocialStates {}

class SocialGetFollowerSuccessState extends SocialStates {}

class SocialGetFollowerErrorState extends SocialStates {}

// get Followings

class SocialGetFollowingLoadingState extends SocialStates {}

class SocialGetFollowingSuccessState extends SocialStates {}

class SocialGetFollowingErrorState extends SocialStates {}


