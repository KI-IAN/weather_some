class CloudsViewModel {
//clouds.all Cloudiness, %
  int all;

  CloudsViewModel({this.all});

  factory CloudsViewModel.fromJson(Map<String, dynamic> jsonData) {
    return CloudsViewModel(
      all: jsonData['all'],
    );
  }
}
