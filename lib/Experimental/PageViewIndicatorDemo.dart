import 'package:flutter/material.dart';
import 'package:page_view_indicator/page_view_indicator.dart';
import 'package:weather_some/Experimental/PageViewDemo.dart';

class PageViewIndicatorDemo extends StatelessWidget {
  static const length = 5;
  final pageIndexNotifier = ValueNotifier<int>(0);
  final bodyBackgroundColor = Colors.purple;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: bodyBackgroundColor,
        appBar: AppBar(
          title: Text('Page View Indicator'),
          backgroundColor: bodyBackgroundColor,
        ),
        body: Stack(
          alignment: FractionalOffset.bottomCenter,
          children: <Widget>[
            PageView.builder(
                physics: BouncingScrollPhysics(),
                onPageChanged: (index) => pageIndexNotifier.value = index,
                itemCount: length,
                itemBuilder: (context, index) {
                  Widget selectedPageView;

                  if (index == 0) {
                    selectedPageView = MyPage1Widget();
                  } else if (index == 1) {
                    selectedPageView = MyPage2Widget();
                  } else if (index == 2) {
                    selectedPageView = MyPage3Widget();
                  } else {
                    selectedPageView = Container(
                      decoration: BoxDecoration(color: Colors.accents[index]),
                      child: Center(
                          child:
                              Text('Page View : ${pageIndexNotifier.value}')),
                    );
                  }

                  return selectedPageView;
                }

                //   return Container(
                //     decoration: BoxDecoration(color: Colors.accents[index]),
                //     child: Center(
                //         child: Text('Page View : ${pageIndexNotifier.value}')),
                //   );
                // },
                ),
            _buildCircularIndicator(),
            // _buildCircularIndicator2(),
            // _buildIconIndicator(),
          ],
        ),
      ),
    );
  }

  PageViewIndicator _buildCircularIndicator() {
    return PageViewIndicator(
      pageIndexNotifier: pageIndexNotifier,
      length: length,
      normalBuilder: (animationController, index) => Circle(
        size: 8.0,
        color: Colors.white60,
      ),
      highlightedBuilder: (animationController, index) => ScaleTransition(
        scale: CurvedAnimation(
          parent: animationController,
          curve: Curves.ease,
        ),
        child: Circle(
          size: 14.0,
          // color: Colors.accents.elementAt((index + length) * length),
          color: Colors.white,
        ),
      ),
    );
  }

  PageViewIndicator _buildCircularIndicator2() {
    return PageViewIndicator(
      pageIndexNotifier: pageIndexNotifier,
      length: length,
      normalBuilder: (animationController, index) => Circle(
        size: 8.0,
        color: Colors.black87,
      ),
      highlightedBuilder: (animationController, index) => ScaleTransition(
        scale: CurvedAnimation(
          parent: animationController,
          curve: Curves.ease,
        ),
        child: Circle(
          size: 8.0,
          color: Colors.white,
        ),
      ),
    );
  }

  PageViewIndicator _buildIconIndicator() {
    return PageViewIndicator(
      pageIndexNotifier: pageIndexNotifier,
      length: length,
      normalBuilder: (animationController, index) => ScaleTransition(
        scale: CurvedAnimation(
          parent: animationController,
          curve: Curves.ease,
        ),
        child: Icon(Icons.favorite, color: Colors.black87),
      ),
      highlightedBuilder: (animationController, index) => ScaleTransition(
        scale: CurvedAnimation(
          parent: animationController,
          curve: Curves.ease,
        ),
        child: Icon(Icons.star, color: Colors.white),
      ),
    );
  }
}

// void main() => runApp(PageViewIndicatorDemo());
