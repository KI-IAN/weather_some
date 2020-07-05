import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_some/Common/Animations/GeneralAnimationSettings.dart';
import 'package:weather_some/Common/Styles/GeneralStyles.dart';
import 'package:weather_some/LanguageFiles/EnglishTexts.dart';
import 'package:weather_some/Pages/AddLocation/Helpers/LocationSearch.dart';
import 'package:weather_some/Pages/AddLocation/ViewModels/LocationListViewModel.dart';
import 'package:weather_some/Pages/AddLocation/ViewModels/LocationVMFutureProvider.dart';
import 'package:weather_some/Pages/AddLocation/ViewModels/LocationViewModel.dart';

class LocationListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _buildScaffold(context);
  }

  Widget _buildScaffold(BuildContext context) => Scaffold(
        backgroundColor: Colors.indigo[300],
        appBar: AppBar(
          title: Text(EnglishTexts.addLocation_titleBarLabel),
          backgroundColor: Colors.black38,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () {
                showSearch(context: context, delegate: LocationSearch());
              },
            ),
          ],
        ),
        body: LocationList(),
      );
}

class LocationList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LocationListState();
}

class LocationListState extends State<LocationList> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        _buildLocationListView(),
        // _buildAddLocationFAB(),
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
          return ChangeNotifierProvider<LocationListViewModel>(
            create: (context) => snapshot.data,
            builder: (context, widget) {
              return AnimatedList(
                key: locationListViewKey,
                initialItemCount:
                    Provider.of<LocationListViewModel>(context, listen: false)
                        .locationList
                        .length,
                itemBuilder: (context, currentIndex, animation) {
                  var currentLocationItem =
                      Provider.of<LocationListViewModel>(context, listen: false)
                          .locationList
                          .elementAt(currentIndex);

                  return _buildLocationItem(
                      currentLocationItem, context, currentIndex);
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

  Container _buildLocationItem(LocationViewModel currentLocationItem,
      BuildContext context, int currentIndex) {
    return Container(
      padding: EdgeInsets.all(5),
      height: 80,
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Align(
                  child: Radio(
                    onChanged: (value) {},
                    value: currentLocationItem.isSelectedCity,
                    activeColor: Colors.lightGreen,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                                text:
                                    '${currentLocationItem.cityName}, ${currentLocationItem.countryCode} ',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                )),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: false,
                        child: RichText(
                          softWrap: true,
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                  text: '${currentLocationItem.latitude}, ',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                  )),
                              TextSpan(
                                  text: "${currentLocationItem.longitude}",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible:
                      Provider.of<LocationListViewModel>(context, listen: false)
                          .locationList
                          .elementAt(currentIndex)
                          .isDeleteableProp,
                  child: Container(
                      height: 50, child: VerticalDivider(color: Colors.black)),
                ),
                Visibility(
                  visible:
                      Provider.of<LocationListViewModel>(context, listen: false)
                          .locationList
                          .elementAt(currentIndex)
                          .isDeleteableProp,
                  child: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () async {
                      await removeLocation(
                          context, currentLocationItem, currentIndex);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> removeLocation(
    BuildContext context,
    LocationViewModel data,
    int currentIndex,
  ) async {
    await Provider.of<LocationListViewModel>(context, listen: false)
        .deleteLocation(data.id);

    locationListViewKey.currentState.removeItem(
        currentIndex,
        (context, animation) => SizeTransition(
              sizeFactor: animation,
              child: _buildLocationItem(data, context, currentIndex),
            ));
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
