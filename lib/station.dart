class Station {
  final String name, url, urlResolved, countrycode, favicon;
  Station(
      this.name, this.url, this.urlResolved, this.countrycode, this.favicon);
  factory Station.fromJson(Map<String, dynamic> json) {
    return Station(
      json['name'],
      json['url'],
      json['url_resolved'],
      json['countrycode'],
      json['favicon'],
    );
  }
}
