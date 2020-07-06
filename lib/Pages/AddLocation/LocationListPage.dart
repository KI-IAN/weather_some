import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:weather_some/Common/Animations/GeneralAnimationSettings.dart';
import 'package:weather_some/Common/CustomWidgets/CustomProgressIndicator.dart';
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
        backgroundColor: GeneralStyles.appPrimaryColor(),
        appBar: AppBar(
          title: Text(EnglishTexts.addLocation_titleBarLabel),
          backgroundColor: GeneralStyles.appPrimaryColor(),
          elevation: 0,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.gps_fixed,
                color: Colors.white,
              ),
              onPressed: () async {
                GeneralAnimationSettings.buttonTapDelay();

                // //Get Current Location
                // var currentLocation = await getCurrentLocation();

                return showDialog(
                    context: context,
                    builder: (context) {
                      return FutureBuilder(
                          future: getCurrentLocation(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData &&
                                snapshot.connectionState ==
                                    ConnectionState.done) {
                              return AlertDialog(
                                title: Text('GPS Location'),
                                actions: <Widget>[
                                  RaisedButton(
                                    color: Colors.blueGrey,
                                    onPressed: () {
                                      GeneralAnimationSettings.buttonTapDelay();
                                      Navigator.pop(context);
                                    },
                                    child:
                                        Icon(Icons.close, color: Colors.white),
                                  ),
                                  RaisedButton(
                                    color: Colors.lightGreen,
                                    onPressed: () {
                                      GeneralAnimationSettings.buttonTapDelay();
                                    },
                                    child:
                                        Icon(Icons.save, color: Colors.white),
                                  ),
                                ],
                                content: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text('Location : '),
                                      Text(
                                          'Latitude  : ${snapshot.data.latitude}'),
                                      Text(
                                          'Longitude : ${snapshot.data.longitude}'),
                                      Text(
                                          'Do you want to save this location?'),
                                    ],
                                  ),
                                ),
                              );
                            } else if (snapshot.hasError) {
                              return Text('Error');
                            } else {
                              return CustomProgressIndicator();
                            }
                          });
                    });
              },
            ),
            IconButton(
              splashColor: GeneralStyles.buttonSplashColor(),
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () {
                GeneralAnimationSettings.buttonTapDelay();
                showSearch(context: context, delegate: LocationSearch());
              },
            ),
          ],
        ),
        body: LocationList(),
      );

  Future<LocationData> getCurrentLocation() async {
    var location = new Location();
    // var currentLocation = <String, double>{};
    LocationData currentLocation;
    try {
      currentLocation = await location.getLocation();
    } catch (e) {
      currentLocation = null;
    }
    return currentLocation;
  }
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
              return _buildAnimatedList(context);
            },
          );
        } else {
          return _buildProgressIndicator();
        }
      },
    );
  }

  Widget _buildAnimatedList(BuildContext context) {
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

        return _buildLocationItem(currentLocationItem, context, currentIndex);
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
                Radio(
                  groupValue:
                      Provider.of<LocationListViewModel>(context, listen: false)
                          .selectedLocationId,
                  onChanged: (value) async {
                    Provider.of<LocationListViewModel>(context, listen: false)
                        .selectedLocationId = value;

                    //update choosen city in DB
                    await Provider.of<LocationListViewModel>(context,
                            listen: false)
                        .setSelectedLocation(value);

                    //Need to find a better way as it rebuilds the whole listview. But all I need is to select different radio button!!!!
                    setState(() {});
                  },
                  value: currentLocationItem.id,
                  activeColor: Colors.lightGreen,
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

    setState(() {});
  }

  Widget _buildProgressIndicator() {
    return Container(
        color: Colors.white,
        child: Center(
          child: CircularProgressIndicator(),
        ));
    // return CustomProgressIndicator();
  }
}
