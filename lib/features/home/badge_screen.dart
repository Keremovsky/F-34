import 'package:bootcamp_flutter/themes/palette.dart';
import 'package:flutter/material.dart';

class BadgeScreen extends StatefulWidget {
  static const routeName = "/badgeScreen";
  const BadgeScreen({super.key});

  @override
  State<BadgeScreen> createState() => _BadgeScreenState();
  
}

class _BadgeScreenState extends State<BadgeScreen> {
  @override

  List<Badge> badges_bronze = [
  Badge("Bronze Target Badge", "assets/images/badge_bronze.png", "You have completed a goal."),
  Badge("Bronze Target Badge", "assets/images/badge_bronze.png", "You must complete a goal."),
  ];

  List<Badge> badges_silver = [
  Badge("Silver Target Badge", "assets/images/badge_silver.png", "You have completed five goals."),
  Badge("Silver Target Badge", "assets/images/badge_silver.png", "You must complete five goals."),
  ];

  List<Badge> badges_gold = [
  Badge("Gold Target Badge", "assets/images/badge_gold.png", "You have completed ten goals."),
  Badge("Gold Target Badge", "assets/images/badge_gold.png", "You must complete ten goals."),
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.background,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: 65,),
              Container(
                child: Text(
                  "BADGES",
                  style: TextStyle(
                    fontSize: 25,
                    color: Palette.categoryText,
                    fontWeight: FontWeight.bold
                  ),
                  )
              ),
              Row(children: <Widget>[
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                    child: const Divider(
                      color: Colors.black,
                      height: 25,
                    ),
                  ),
                ),
              ]),
              Row(
                children: [
                  //if ( tamamlanan_hedef == 0 )
                  Expanded(
                    child: BadgeItem(
                      name: badges_bronze[1].name,
                      imageUrl: badges_bronze[1].imageUrl,
                      description: badges_bronze[1].description,
                      )
                  ),
                  //else
                  //Expanded(
                    //child: BadgeItem(
                      //name: badges_bronze[0].name,
                      //imageUrl: badges_bronze[0].imageUrl,
                      //description: badges_bronze[0].description,
                      //)
                  //)
                ],
              ),
              SizedBox(height: 8,),
              Row(
                children: [
                  //if ( tamamlanan_hedef < 5 )
                  Expanded(
                    child: BadgeItem(
                      name: badges_silver[1].name,
                      imageUrl: badges_silver[1].imageUrl,
                      description: badges_silver[1].description,
                      )
                  ),
                  //else
                  //Expanded(
                    //child: BadgeItem(
                      //name: badges_silver[0].name,
                      //imageUrl: badges_silver[0].imageUrl,
                      //description: badges_silver[0].description,
                      //)
                  //)
                ],
              ),
              SizedBox(height: 8,),
              Row(
                children: [
                  //if ( tamamlanan_hedef < 10 )
                  Expanded(
                    child: BadgeItem(
                      name: badges_gold[1].name,
                      imageUrl: badges_gold[1].imageUrl,
                      description: badges_gold[1].description,
                      )
                  ),
                  //else
                  //Expanded(
                    //child: BadgeItem(
                      //name: badges_gold[0].name,
                      //imageUrl: badges_gold[0].imageUrl,
                      //description: badges_gold[0].description,
                      //)
                  //)
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}

class Badge {
  final String name;
  final String imageUrl;
  final String description;

  Badge(
    this.name,
    this.imageUrl,
    this.description,
    );
}

class BadgeItem extends StatelessWidget {
  final String name;
  final String imageUrl;
  final String description;

  BadgeItem({
    required this.name,
    required this.imageUrl,
    required this.description,
  });


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Palette.textFieldBackground,
      ),
      child:Column(
        children: [
          SizedBox(height: 20,),
          Row(
            children: [
              Expanded(
                child: Align(
                  child: Row(
                    children: [
                      SizedBox(width: 20,),
                      Container(
                        height: 100,
                        child: Image(image: AssetImage(imageUrl)),
                      ),
                      SizedBox(width: 20,),
                      Column(
                        children: [
                          Text(
                            name,
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 10,),
                          Text(
                            description,
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20,)
        ],
      ),
    );
  }
}


