import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:temp/presentation/router/app_router_names.dart';
import 'package:temp/presentation/styles/colors.dart';
import 'package:temp/presentation/widgets/buttons/elevated_button.dart';
import 'package:temp/presentation/widgets/logo_name.dart';

import '../../../data/local/cache_helper.dart';
import '../../../data/models/onbaording/onbaording_list_of_data.dart';

class OnBoardScreens extends StatefulWidget {
  const OnBoardScreens({Key? key}) : super(key: key);

  @override
  State<OnBoardScreens> createState() => _OnBoardScreensState();
}

class _OnBoardScreensState extends State<OnBoardScreens> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentIndex = 0;

  final myData = OnBoardingData().myData;

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_currentIndex < 2) _currentIndex++;
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentIndex,
          duration: const Duration(seconds: 1),
          curve: Curves.easeIn,
        );
      }
    });
  }

  void navigateToHomeScreen(context) async {
    await CacheHelper.saveDataSharedPreference(key: 'onBoardDone', value: true);
    Navigator.pushReplacementNamed(context, AppRouterNames.rHomeRoute);
  }

  void onPressNext() {
    if (_currentIndex < 2) {
      _currentIndex++;
      _pageController.animateToPage(
        _currentIndex,
        duration: const Duration(seconds: 1),
        curve: Curves.easeIn,
      );
    } else {
      navigateToHomeScreen(context);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.ltr,
        child: PageView.builder(
          controller: _pageController,
          onPageChanged: (value) => setState(() => _currentIndex = value),
          itemCount: myData.length,
          itemBuilder: (context, index) {
            return Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.sp),
                child: Column(
                  children: [
                    const Spacer(),
                    Expanded(
                      flex: 2,
                      child: Align(
                        alignment: Alignment.topRight,
                        child: TextButton(
                          onPressed: () => navigateToHomeScreen(context),
                          child: Text('Skip',
                              style: textTheme.bodyText2
                                  ?.copyWith(letterSpacing: 2)),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child:
                          Image.asset(myData[index].img, fit: BoxFit.contain),
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Welcome to ', style: textTheme.headline3),
                                const LogoName(),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(
                              myData[index].description,
                              style: textTheme.subtitle2,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              myData.length,
                                  (index) => Container(
                                margin: EdgeInsets.only(right: 4.sp),
                                height: 1.2.h,
                                width: _currentIndex == index ? 12.w : 3.w,
                                decoration: BoxDecoration(
                                  color: _currentIndex == index
                                      ? AppColor.primaryColor
                                      : AppColor.grey,
                                  borderRadius: BorderRadius.circular(20.0.sp),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 3.h),
                          CustomElevatedButton(
                            onPressed: () => onPressNext(),
                            text: myData[index].buttonTitle,
                            borderRadius: 6.sp,
                            width: 80.w,
                            height: 6.h,
                          ),
                        ],
                      ),
                    ),
                    const Spacer()
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
