import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/news_layout/cubit/states.dart';
import 'package:news_app/modules/news_nav/Bussiness_Screen.dart';
import 'package:news_app/modules/news_nav/Science_Screen.dart';
import 'package:news_app/modules/news_nav/Setting_Screen.dart';
import 'package:news_app/modules/news_nav/Sports_Screen.dart';
import 'package:news_app/shared/network/local/cach_helper.dart';

import '../../../shared/network/remote/DioHelper.dart';

class NewsCubit extends Cubit<NewsStates>{
  NewsCubit(): super(NewsInitial());
  static NewsCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> screenList = [
    BussinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];
  List<BottomNavigationBarItem> bottomList = [
    BottomNavigationBarItem(icon:Icon(Icons.business_sharp), label: "Bussiness"),
    BottomNavigationBarItem(icon:Icon(Icons.sports_baseball),label: "Sports"),
    BottomNavigationBarItem(icon:Icon(Icons.science),label: "Science"),

  ];

  void changeIndex({required int index}){
    currentIndex = index;
    emit(NewsChangeBottomNav());
  }
  List<dynamic> listsBusiness =[];
  List<dynamic> listsSports =[];
  List<dynamic> listsScience =[];
  List<dynamic> listsSearch =[];

  void getBusinessData(){

    emit(NewsGetBusinessDataLoading());

    if(listsBusiness.length==0) {
      DioHelper.getData(url: "v2/top-headlines", query: {
        "country": "us",
        "category": "business",
        "apiKey": "6493c1a585b348798fe176315dbe435e",
      }
      ).then((value) {
        listsBusiness = value.data['articles'];
        print(listsBusiness[0]['title']);
        emit(NewsGetBusinessSuccessData());
      }).catchError((error) {
        emit(NewsGetBusinessErrorData());
        print(error.toString());
      });
    }else{
      emit(NewsGetBusinessSuccessData());
    }
  }

  void getSportsData(){

    emit(NewsGetSportsDataLoading());
    if(listsSports.length==0) {
      DioHelper.getData(url: "v2/top-headlines", query: {
        "country": "us",
        "category": "sports",
        "apiKey": "6493c1a585b348798fe176315dbe435e",
      }
      ).then((value) {
        listsSports = value.data['articles'];
        print(listsSports[0]['title']);
        emit(NewsGetSportsSuccessData());
      }).catchError((error) {
        emit(NewsGetSportsErrorData());
        print(error.toString());
      });
    }else{
      emit(NewsGetSportsSuccessData());
    }
  }
  void getScienceData(){
    emit(NewsGetScienceDataLoading());

    if(listsScience.length==0){
      DioHelper.getData(url: "v2/top-headlines", query: {
        "country": "us",
        "category": "science",
        "apiKey": "6493c1a585b348798fe176315dbe435e",
      }
      ).then((value) {
        listsScience = value.data['articles'];
        print(listsScience[0]['title']);
        emit(NewsGetScienceSuccessData());
      }).catchError((error){
        emit(NewsGetScienceErrorData());
        print(error.toString());
      });
    }else{
      emit(NewsGetScienceSuccessData());

    }

  }
  void getSearchData(String value){
    emit(NewsGetsSearchDataLoading());

      DioHelper.getData(url: "v2/everything", query: {
        "q": "$value",
        "apiKey": "6493c1a585b348798fe176315dbe435e",
      }
      ).then((value) {
        listsSearch = value.data['articles'];
        print(listsSearch[0]['title']);
        emit(NewsGetSearchSuccessData());
      }).catchError((error){
        emit(NewsGetScienceErrorData());
        print(error.toString());
      });


  }

  bool isMode =false;

  void changeMode({bool? fromShared}){
    if(fromShared !=null){
      isMode = fromShared;
    }else{
    isMode = !isMode;
    CacheHelper.putData(key: "isMode", value: isMode).then((value) {
    });
    }
    emit(ChangeDarkLightMode());
  }
}


