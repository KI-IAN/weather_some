class CloudsViewModel {
//clouds.all Cloudiness, %
  num all;

  CloudsViewModel({this.all});

  factory CloudsViewModel.fromJson(Map<String, dynamic> jsonData) {
    return CloudsViewModel(
      all: jsonData['all'],
    );
  }
}
