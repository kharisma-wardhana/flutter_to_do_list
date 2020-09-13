import 'dart:io';

import 'package:dicoding_todo/models/OnboardData.dart';
import 'package:dicoding_todo/screens/home.dart';
import 'package:dicoding_todo/theme.dart';
import 'package:dicoding_todo/widgets/SlideTlie.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Onboard extends StatefulWidget {
  @override
  _OnboardState createState() => _OnboardState();
}

class _OnboardState extends State<Onboard> {
  int slideIndex = 0;
  PageController pageController;
  List<OnboardData> onboardSlide = new List<OnboardData>();

  @override
  void initState() {
    super.initState();
    onboardSlide = getOnboardData();
    pageController = new PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            width: double.infinity,
            decoration: BoxDecoration(color: kPrimaryColor),
            child: PageView(
              controller: pageController,
              onPageChanged: (index) {
                setState(() {
                  slideIndex = index;
                });
              },
              children: <Widget>[
                SlideTile(
                  imagePath: onboardSlide[0].getImgPath(),
                  title: onboardSlide[0].getTitle(),
                  desc: onboardSlide[0].getDesc(),
                ),
                SlideTile(
                  imagePath: onboardSlide[1].getImgPath(),
                  title: onboardSlide[1].getTitle(),
                  desc: onboardSlide[1].getDesc(),
                ),
                SlideTile(
                  imagePath: onboardSlide[2].getImgPath(),
                  title: onboardSlide[2].getTitle(),
                  desc: onboardSlide[2].getDesc(),
                ),
              ],
            )),
      ),
      bottomSheet: (slideIndex != 2)
          ? Container(
              margin: EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      pageController.animateToPage(2,
                          duration: Duration(milliseconds: 400),
                          curve: Curves.linear);
                    },
                    splashColor: kPrimaryColor,
                    child: Text(
                      "SKIP",
                      style: TextStyle(
                          color: kPrimaryColor, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        for (int i = 0; i < 3; i++)
                          i == slideIndex
                              ? _buildPageIndicator(true)
                              : _buildPageIndicator(false),
                      ],
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      print("this is slideIndex: $slideIndex");
                      pageController.animateToPage(slideIndex + 1,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.linear);
                    },
                    splashColor: kPrimaryColor,
                    child: Text(
                      "NEXT",
                      style: TextStyle(
                          color: kPrimaryColor, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            )
          : InkWell(
              onTap: () {
                print("Get Started Now");
                Future<bool> saveFirstOpen = _savePref();
                saveFirstOpen.then((value) {
                  if (value) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => Home()));
                  }
                });
              },
              child: Container(
                height: Platform.isIOS ? 70 : 60,
                color: kSecondaryColor,
                alignment: Alignment.center,
                child: Text(
                  "GET STARTED NOW",
                  style:
                      TextStyle(color: kTextColor, fontWeight: FontWeight.w600),
                ),
              ),
            ),
    );
  }

  Future<bool> _savePref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool('first_login', true);
  }

  Widget _buildPageIndicator(bool isCurrentPage) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.0),
      height: isCurrentPage ? 10.0 : 6.0,
      width: isCurrentPage ? 10.0 : 6.0,
      decoration: BoxDecoration(
        color: isCurrentPage ? kPrimaryColor : Colors.grey[600],
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
