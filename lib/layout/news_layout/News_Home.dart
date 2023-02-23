import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/news_layout/cubit/cubit.dart';
import 'package:news_app/layout/news_layout/cubit/states.dart';
import 'package:news_app/modules/search.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/network/remote/DioHelper.dart';

class NewsHome extends StatelessWidget {
  const NewsHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context , state){},
      builder: (context , state){
        var cubit = NewsCubit.get(context);
        return Scaffold(
          appBar:AppBar(
            title: Text("News App"),
            actions: [
            IconButton(icon:Icon(Icons.search_rounded),onPressed: (){
              navigateTo(context, SearchScreen());
            }),
            IconButton(icon: Icon(Icons.brightness_4_outlined),onPressed: (){
              NewsCubit.get(context).changeMode();
            }),
          ],
          ),

          body:cubit.screenList[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex:  cubit.currentIndex,
            onTap: (index){
              cubit.changeIndex(index: index);
            },
            items: cubit.bottomList,
          ),
        );
      },
    );
  }
}
