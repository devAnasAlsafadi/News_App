import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/news_layout/cubit/cubit.dart';
import 'package:news_app/layout/news_layout/cubit/states.dart';
import 'package:news_app/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();

  SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state){},
      builder: (context,state){
        var list = NewsCubit.get(context).listsSearch;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  maxLines: 1,
                  onTap: () {},
                  controller: searchController,
                  onChanged: (value) {
                    NewsCubit.get(context).getSearchData(value);
                  },
                  decoration: InputDecoration(
                      labelText: "Search",
                      prefix: Icon(Icons.search),
                      border: OutlineInputBorder()
                  ),
                ),
              ),
              Expanded(child: ArticleBulider(list)),
            ],
          ),
        );
      },
    );
  }
}
