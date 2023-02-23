import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget buildArticleItem(item,context)=>
    Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Container(
            height: 120,
            width: 120,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image:DecorationImage(
                    image: NetworkImage('${item['urlToImage']}'),
                    fit: BoxFit.cover
                )


            ),
          ),
          SizedBox(width: 10.0,),
          Expanded(
            child: Container(
              height: 120,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${item['title']}',
                    maxLines: 4,
                    style: Theme.of(context).textTheme.bodyText1
                  ),
                  SizedBox(height: 10,),
                  Text(
                    '${item['publishedAt']}',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey
                    ),
                  ),

                ],
              ),
            ),
          )
        ],
      ),
    );
Widget ArticleBulider(list)=>ConditionalBuilder(
  condition:list.length>0 ,
  builder:(context) =>ListView.separated(
    physics: BouncingScrollPhysics(),
    itemBuilder: (context ,index)=>buildArticleItem(list[index],context),
    separatorBuilder: (context,index)=>Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(height: 1,color: Colors.grey[700],),
    ),
    itemCount:list.length,
  ) ,
  fallback:(context) =>Center(child: CircularProgressIndicator()),
);
void navigateTo(context, Widget widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context)=> widget));