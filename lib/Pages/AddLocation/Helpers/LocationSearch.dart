import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_some/Common/Animations/GeneralAnimationSettings.dart';
import 'package:weather_some/Common/ViewModels/SimpleMaps/CityInfoViewModels.dart';
import 'package:weather_some/Pages/AddLocation/Helpers/LocationSearchHelper.dart';
import 'package:weather_some/Pages/AddLocation/ViewModels/LocationSearchViewModel.dart';
import 'package:weather_some/Pages/MainPage/MainAppCarouselPage.dart';

class LocationSearch extends SearchDelegate<CityInfoViewModel> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          resetQuery();
        },
      ),
      IconButton(
        icon: Icon(Icons.gps_fixed),
        onPressed: () {},
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text(query),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
        future: LocationSearchHelper().getAllCities(),
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            return ChangeNotifierProvider<LocationSearchViewModel>(
              create: (context) => snapshot.data,
              builder: (context, widget) {
                Provider.of<LocationSearchViewModel>(context, listen: false)
                        .cities =
                    Provider.of<LocationSearchViewModel>(context, listen: false)
                        .cities
                        .where((r) =>
                            r.city.toLowerCase().contains(query.toLowerCase()))
                        .toList();

                return ListView.builder(
                    itemCount: Provider.of<LocationSearchViewModel>(context,
                            listen: false)
                        .cities
                        .length,
                    itemBuilder: (context, currentIndex) {
                      var currentItem = Provider.of<LocationSearchViewModel>(
                              context,
                              listen: false)
                          .cities
                          .elementAt(currentIndex);
                      return ListTile(
                        title: Text(currentItem.city),
                        subtitle: Text(currentItem.admin),
                        onTap: () async {
                          GeneralAnimationSettings.buttonTapDelay();
                          await addLocation(context, currentItem);
                        },
                      );
                    });
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Future<void> addLocation(
      BuildContext context, CityInfoViewModel cityInfo) async {
    await Provider.of<LocationSearchViewModel>(context, listen: false)
        .addLocation(cityInfo);

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => MainAppCarouselPage()),
        (route) => false);
  }

  void resetQuery() {
    query = '';
  }
}
