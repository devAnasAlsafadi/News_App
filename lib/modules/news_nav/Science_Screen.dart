import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/news_layout/cubit/cubit.dart';
import 'package:news_app/layout/news_layout/cubit/states.dart';

import '../../shared/components/components.dart';

class ScienceScreen extends StatelessWidget {
  const ScienceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var  cubit = NewsCubit.get(context);
    return BlocConsumer<NewsCubit , NewsStates>(
      listener: (context , state){},
      builder: (context , state){
        return ArticleBulider(cubit.listsScience);
      },
    );
  }
}
