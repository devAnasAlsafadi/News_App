import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/news_layout/cubit/cubit.dart';
import '../../layout/news_layout/cubit/states.dart';
import '../../shared/components/components.dart';

class SportsScreen extends StatelessWidget {
  const SportsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var  cubit = NewsCubit.get(context);
    return BlocConsumer<NewsCubit , NewsStates>(
      listener: (context , state){},
      builder: (context , state){
        return ArticleBulider(cubit.listsSports);
      },
    );
  }
}
