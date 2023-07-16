import 'package:bootcamp_flutter/features/auth/screens/login_screen.dart';
import 'package:bootcamp_flutter/features/home/home_screen.dart';
import 'package:bootcamp_flutter/themes/palette.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  static const routeName = "/onboardingScreen";

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final List<Slide> slides = [
    Slide(
      backgroundImageUrl: 'assets/images/background.png',
      imageUrl: 'assets/images/slide1_image.png',
      title: "Welcome to Bütçe'm!",
      description:
          "Bütçe'm is an application to simplify personal financial management. With Bütçe'm you can manage your money better than ever.",
    ),
    Slide(
      backgroundImageUrl: 'assets/images/background.png',
      imageUrl: 'assets/images/slide2_image.png',
      title: "What can you do?",
      description:
          "Using Bütçe'm, you can control your budget, save money and finally reach your financial aim.",
    ),
    Slide(
      backgroundImageUrl: 'assets/images/background.png',
      imageUrl: 'assets/images/slide3_image.png',
      title: 'For who?',
      description:
          "This application, which is suitable to use for everyone, is also an excellent option for those who are new to financial management.",
    ),
    Slide(
      backgroundImageUrl: 'assets/images/background.png',
      imageUrl: 'assets/images/slide4_image.png',
      title: 'Are you ready to start?',
      description:
          "Welcome to Bütçe'm! Follow your incomes and outcomes to complete your financial aims now.",
    ),
  ];

  SwiperController controller = SwiperController();
  int currentIndex = 0;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void goToNextSlide() {
    if (currentIndex < slides.length - 1) {
      setState(() {
        currentIndex++;
      });
      controller.next();
    }
  }

  void goToPreviousSlide() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
      });
      controller.previous();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.background,
      body: Stack(children: [
        Swiper(
          controller: controller,
          itemCount: slides.length,
          index: currentIndex,
          onIndexChanged: (int index) {
            setState(() {
              currentIndex = index;
            });
          },
          pagination: SwiperPagination(),
          itemBuilder: (BuildContext context, int index) {
            return SlideItem(
              backgroundImageUrl: slides[index].backgroundImageUrl,
              imageUrl: slides[index].imageUrl,
              title: slides[index].title,
              description: slides[index].description,
            );
          },
        ),
        Positioned(
          bottom: 30,
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  if (currentIndex == 0)
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: IconButton(
                                onPressed: goToNextSlide,
                                icon: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Palette.categoryBackground,
                                  size: 35,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (0 < currentIndex && currentIndex < slides.length - 1)
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: IconButton(
                                  onPressed: goToPreviousSlide,
                                  icon: Icon(
                                    Icons.arrow_back_ios,
                                    color: Palette.categoryBackground,
                                    size: 35,
                                  )),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: IconButton(
                              onPressed: goToNextSlide,
                              icon: Icon(
                                Icons.arrow_forward_ios,
                                color: Palette.categoryBackground,
                                size: 35,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (currentIndex == slides.length - 1)
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: IconButton(
                                  onPressed: goToPreviousSlide,
                                  icon: Icon(
                                    Icons.arrow_back_ios,
                                    color: Palette.categoryBackground,
                                    size: 35,
                                  )),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: TextButton(
                              onPressed: () async {
                                final prefs =
                                    await SharedPreferences.getInstance();
                                prefs.setBool("showHome", true);

                                if (mounted) {
                                  Navigator.of(context)
                                      .pushNamed(LoginScreen.routeName);
                                }
                              },
                              child: Text(
                                'Finish',
                                style: TextStyle(
                                  color: Palette.categoryBackground,
                                  fontSize: 22,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}

class Slide {
  final String backgroundImageUrl;
  final String imageUrl;
  final String title;
  final String description;

  Slide({
    required this.backgroundImageUrl,
    required this.imageUrl,
    required this.title,
    required this.description,
  });
}

class SlideItem extends StatelessWidget {
  final String backgroundImageUrl;
  final String imageUrl;
  final String title;
  final String description;

  SlideItem({
    required this.backgroundImageUrl,
    required this.imageUrl,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(backgroundImageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                height: 350,
                child: Image(image: AssetImage(imageUrl)),
              ),
            ]),
            SizedBox(
              height: 35,
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 16),
            Text(
              description,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
