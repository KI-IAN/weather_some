import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_some/Common/Animations/GeneralAnimationSettings.dart';
import 'package:weather_some/Common/Styles/GeneralStyles.dart';
import 'package:weather_some/LanguageFiles/EnglishTexts.dart';
import 'package:weather_some/Pages/AddLocation/ViewModels/AddLocationViewModel.dart';
import 'package:weather_some/Pages/AddLocation/ViewModels/LocationVMFutureProvider.dart';

class AddLocationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _buildScaffold();
  }

  Widget _buildScaffold() => Scaffold(
        backgroundColor: Colors.lightBlue[100],
        appBar: AppBar(
          title: Text(EnglishTexts.addLocation_titleBarLabel),
          backgroundColor: Colors.black38,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: null,
            ),
          ],
        ),
        body: AddLocation(),
      );
}

class AddLocation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AddLocationState();
}

class AddLocationState extends State<AddLocation> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        _buildLocationListView(),
        _buildAddLocationFAB(),
      ],
    );
  }

  GlobalKey<AnimatedListState> locationListViewKey =
      GlobalKey<AnimatedListState>();

  Widget _buildLocationListView() {
    return FutureBuilder(
      future: LocationVMFutureProvider().getAllLocations(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ChangeNotifierProvider<AddLocationViewModel>(
            create: (context) => snapshot.data,
            builder: (context, widget) {
              return AnimatedList(
                key: locationListViewKey,
                initialItemCount:
                    Provider.of<AddLocationViewModel>(context, listen: false)
                        .locationList
                        .length,
                itemBuilder: (context, currentIndex, animation) {
                  var currentLocationItem =
                      Provider.of<AddLocationViewModel>(context, listen: false)
                          .locationList
                          .elementAt(currentIndex);

                  return Container(
                    padding: EdgeInsets.all(5),
                    height: 80,
                    child: Card(
                      color: Colors.transparent,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Align(
                                child: Radio(
                                  activeColor: Colors.lightGreen,
                                ),
                              ),
                              Column(
                                children: <Widget>[
                                  RichText(
                                    text: TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                            text:
                                                '${currentLocationItem.locationName}, ',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                            )),
                                        TextSpan(
                                            text:
                                                "${currentLocationItem.currentDateTime.toString()}",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 10,
                                            )),
                                      ],
                                    ),
                                  ),
                                  RichText(
                                    softWrap: true,
                                    text: TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                            text:
                                                '${currentLocationItem.currentTemperature.toStringAsFixed(2)}, ',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                            )),
                                        TextSpan(
                                            text:
                                                "${currentLocationItem.weatherDescription}",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                            )),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                  height: 50,
                                  child: VerticalDivider(color: Colors.black)),
                              IconButton(
                                icon: Icon(Icons.close),
                                onPressed: null,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
        } else {
          return _buildProgressIndicator();
        }
      },
    );
  }

  Container _buildProgressIndicator() {
    return Container(
        color: Colors.white,
        child: Center(
          child: CircularProgressIndicator(),
        ));
  }

  Widget _buildAddLocationFAB() {
    return Container(
      padding: EdgeInsets.all(15),
      alignment: Alignment.bottomRight,
      child: FloatingActionButton(
          splashColor: GeneralStyles.buttonSplashColor(),
          backgroundColor: Colors.lightBlue,
          onPressed: () async {
            await GeneralAnimationSettings.buttonTapDelay();
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          )),
    );
  }
}
