import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app/layout/news_layout/News_Home.dart';
import 'package:news_app/layout/news_layout/cubit/cubit.dart';
import 'package:news_app/layout/news_layout/cubit/states.dart';
import 'package:news_app/observe_cubit.dart';
import 'package:news_app/shared/network/local/cach_helper.dart';
import 'package:news_app/shared/network/remote/DioHelper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  bool? isDark = CacheHelper.getData(key: "isMode");

  runApp(MyApp(isDark=false));
}

class MyApp extends StatelessWidget {

  final bool isDark;
  MyApp(this.isDark);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create:(context)=> NewsCubit()..getScienceData()..getSportsData()..getBusinessData()..changeMode(fromShared: isDark),
      child: BlocConsumer<NewsCubit,NewsStates>(
        listener: (context,state){},
        builder: (context,state)
         {
           return  MaterialApp(
               debugShowCheckedModeBanner: false,
               theme: ThemeData(
                 primarySwatch: Colors.deepOrange,
                 scaffoldBackgroundColor: Colors.white,
                 appBarTheme: AppBarTheme(
                     backgroundColor: Colors.white,
                     elevation: 0.0,
                     systemOverlayStyle: SystemUiOverlayStyle(
                       statusBarColor: Colors.white,
                       statusBarIconBrightness: Brightness.dark,

                     ),
                     titleTextStyle: TextStyle(
                       color: Colors.black,
                       fontSize: 20,
                       fontWeight: FontWeight.bold,

                     ),
                     iconTheme: IconThemeData(
                         color:Colors.black
                     )
                 ),
                 textTheme: TextTheme(
                     bodyText1: TextStyle(
                         fontWeight: FontWeight.w600,
                         fontSize: 18,
                         color: Colors.black
                     )
                         ),
                 bottomNavigationBarTheme: BottomNavigationBarThemeData(
                   backgroundColor:Colors.white,
                   unselectedItemColor: Colors.grey,
                   elevation: 20,

                 ),

               ),
               darkTheme: ThemeData(
                   scaffoldBackgroundColor: HexColor('333739'),
                   primarySwatch: Colors.deepOrange,
                   appBarTheme: AppBarTheme(
                       backgroundColor:  HexColor('333739'),
                       elevation: 0.0,
                       systemOverlayStyle: SystemUiOverlayStyle(
                         statusBarColor:  HexColor('333739'),
                         statusBarIconBrightness: Brightness.light,
                       ),
                       iconTheme: IconThemeData(
                           color:Colors.white
                       )
                   ),
                   bottomNavigationBarTheme: BottomNavigationBarThemeData(
                     backgroundColor:  HexColor('333739'),
                     unselectedItemColor: Colors.grey,
                     elevation: 20,

                   ),
                   textTheme: TextTheme(
                       bodyText1: TextStyle(
                           fontSize: 18,
                           color: Colors.white,
                           fontWeight: FontWeight.w600
                       )
                   )
               ),
               themeMode: NewsCubit.get(context).isMode?ThemeMode.dark:ThemeMode.light,
               home:NewsHome()
           );
         }
      ),
    );
  }
}
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//
//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.
//
//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;
//
//   void _incrementCounter() {
//     setState(() {
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _counter without calling setState(), then the build method would not be
//       // called again, and so nothing would appear to happen.
//       _counter++;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           // Column is also a layout widget. It takes a list of children and
//           // arranges them vertically. By default, it sizes itself to fit its
//           // children horizontally, and tries to be as tall as its parent.
//           //
//           // Invoke "debug painting" (press "p" in the console, choose the
//           // "Toggle Debug Paint" action from the Flutter Inspector in Android
//           // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
//           // to see the wireframe for each widget.
//           //
//           // Column has various properties to control how it sizes itself and
//           // how it positions its children. Here we use mainAxisAlignment to
//           // center the children vertically; the main axis here is the vertical
//           // axis because Columns are vertical (the cross axis would be
//           // horizontal).
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headline4,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
