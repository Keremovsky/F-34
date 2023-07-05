import 'package:bootcamp_flutter/features/finance/screens/expense_screen.dart.dart';
import 'package:bootcamp_flutter/features/finance/screens/income_screen.dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bootcamp_flutter/themes/palette.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bootcamp_flutter/core/constants/constants.dart';
import 'package:pie_chart/pie_chart.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static final routeName = "/homeScreen";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends ConsumerState<HomeScreen> {
  GlobalKey<ScaffoldState> _key = GlobalKey();
  final dataMap = <String, double>{
    "Goal": 62.5,
  };

  final colorList = <Color>[
    Palette.pieChartColor,
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
      key: _key,
      backgroundColor: Palette.background,
      appBar: AppBar(
        forceMaterialTransparency: true,
        toolbarHeight: 100.h,
        leading: Row(
          children: [
            Container(
              child: InkWell(
                onTap: () {
                  _key.currentState?.openDrawer();
                },
                child: ImageIcon(
                  const AssetImage("assets/icons/side_menu.png"),
                  size: 40.h,
                ),
              ),
            ),
          ],
        ),
        actions: <Widget>[
          Container(
            height: 100.h,
            width: 100.w,
            child: const Image(image: AssetImage(Constants.appLogo)),
          ),
          SizedBox(
            width: 140.w,
          ),
          InkWell(
            onTap: () {},
            child: Container(
              height: 50.h,
              width: 50.w,
              child: const CircleAvatar(
                backgroundImage: AssetImage(Constants.profilePicture),
                radius: 50,
              ),
            ),
          ),
          Container(padding: const EdgeInsets.all(10.0)),
        ],
      ),
      drawer: Drawer(
        backgroundColor: Palette.sideMenuBackground,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Center(
                child: Container(
                  height: 150.h,
                  width: 150.w,
                  child: const Image(image: AssetImage(Constants.appLogo)),
                ),
              ),
            ),
            ListTile(
              title: Text(
                'Enter Income',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold),
              ),
              onTap: () =>
                  Navigator.of(context).pushNamed(IncomeScreen.routeName),
            ),
            const Divider(color: Colors.black),
            ListTile(
              title: Text(
                'Enter Outcome',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold),
              ),
              onTap: () =>
                  Navigator.of(context).pushNamed(ExpenseScreen.routeName),
            ),
            const Divider(color: Colors.black),
            ListTile(
              title: Text(
                'Save Money',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold),
              ),
              onTap: () => {},
            ),
            const Divider(color: Colors.black),
            ListTile(
              title: Text(
                'Update Goal',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold),
              ),
              onTap: () => {},
            ),
            const Divider(color: Colors.black),
            ListTile(
              title: Text(
                'Log Out',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold),
              ),
              onTap: () => {},
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 20.h,
          ),
          Center(
            child: Container(
              height: 120.h,
              width: 300.h,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Palette.textFieldBackground,
              ),
              child: Text(
                "Avaliable in Wallet\n...... TL",
                style: TextStyle(color: Colors.black, fontSize: 25.sp),
              ),
            ),
          ),
          SizedBox(
            height: 50.h,
          ),
          Center(
            child: Container(
              height: 120.h,
              width: 300.h,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Palette.textFieldBackground,
              ),
              child: Text(
                "Total Saving\n...... TL",
                style: TextStyle(color: Colors.black, fontSize: 25.sp),
              ),
            ),
          ),
          SizedBox(
            height: 50.h,
          ),
          Center(
            child: Container(
              height: 120.h,
              width: 300.h,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Palette.textFieldBackground,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Goal:......\nRemaining: %62.5",
                    style: TextStyle(color: Colors.black, fontSize: 20.sp),
                  ),
                  PieChart(
                    dataMap: dataMap,
                    baseChartColor: Palette.background,
                    colorList: colorList,
                    initialAngleInDegree: 270,
                    legendOptions: const LegendOptions(
                      showLegendsInRow: false,
                      showLegends: false,
                    ),
                    chartValuesOptions: const ChartValuesOptions(
                      showChartValueBackground: false,
                      showChartValues: false,
                      showChartValuesInPercentage: false,
                    ),
                    totalValue: 100,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
