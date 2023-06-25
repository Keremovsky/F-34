import 'package:bootcamp_flutter/themes/palette.dart';
import 'package:flutter/material.dart';

class profileScreen extends StatefulWidget {
  const profileScreen({super.key});
  
  @override
  State<profileScreen> createState() => _profileScreenState();

  
}

class _profileScreenState extends State<profileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.background,
      appBar: AppBar(
        backgroundColor: Palette.background,
        actions: [
          IconButton(
            onPressed: (){},
            icon: const Icon(Icons.edit,),
          ),
        ]
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.only(top:20), //kaldırılabilir
              width: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Palette.background,Palette.buttonText],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  )
              ),
              child: SizedBox(
                
                height: 220,
                width: 220,
                child: InkWell(
                  onTap: () {


                  },
                  child: const CircleAvatar(
                    child: Text('sss'),
                  ),
                ),
              ),
            ),
          Text(
            'ad-soyad'
          ),



          ]
        ),
        ),
      );
  }
}
