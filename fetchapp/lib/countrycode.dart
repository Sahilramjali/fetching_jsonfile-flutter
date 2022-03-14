class Country {
  String? name;
  String? dial_code;
  String? code;
  Country(this.name, this.dial_code, this.code);

  Country.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    dial_code = json['dial_code'];
    code = json['code'];
  }
}
