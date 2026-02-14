enum GSNetworkMethode {
  get,
  post,
  put,
  delete
}

extension GSNetworkMethodeExt on GSNetworkMethode {
  String get methode => name.toUpperCase();
}