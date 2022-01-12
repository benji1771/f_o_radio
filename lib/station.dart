class Station {
  final String? name, url, urlResolved, countrycode, favicon;
  Station(
      {this.name, this.url, this.urlResolved, this.countrycode, this.favicon});
  factory Station.fromJson(Map<String, dynamic> json) {
    return Station(
      name: json['name'],
      url: json['url'],
      urlResolved: json['url_resolved'],
      countrycode: json['countrycode'],
      favicon: json['favicon'],
    );
  }
}
