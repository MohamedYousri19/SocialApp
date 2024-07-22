abstract class NewsStates {}

class NewsInitialize extends NewsStates {}

class NewsBottomNave extends NewsStates {}

class NewsChangeCurrentIndex extends NewsStates {}

class NewsGetBusinessLoadingState extends NewsStates {}

class NewsGetBusinessSuccessState extends NewsStates {}

class NewsGetBusinessErrorState extends NewsStates {
  final String error ;
  NewsGetBusinessErrorState(this.error) ;
}

class NewsGetScienceLoadingState extends NewsStates {}

class NewsGetScienceSuccessState extends NewsStates {}

class NewsGetScienceErrorState extends NewsStates {

  final String error ;
  NewsGetScienceErrorState(this.error) ;
}

class NewsGetSportsLoadingState extends NewsStates {}

class NewsGetSportsSuccessState extends NewsStates {}

class NewsGetSportsErrorState extends NewsStates {
  final String error ;
  NewsGetSportsErrorState(this.error) ;
}

class NewsGetSearchLoadingState extends NewsStates {}

class NewsGetSearchSuccessState extends NewsStates {}

class NewsGetSearchSuccessState1 extends NewsStates {}

class NewsGetSearchErrorState extends NewsStates {
  final String error ;
  NewsGetSearchErrorState(this.error) ;
}
class NewsDelete extends NewsStates {}
