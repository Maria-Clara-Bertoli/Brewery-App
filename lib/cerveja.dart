class Cerveja {
  String? _id;
  String? _name;
  String? _breweryType;
  String? _street;
  String? _city;
  String? _state;
  String? _postalCode;
  String? _country;
  String? _longitude;
  String? _latitude;
  String? _phone;
  String? _updatedAt;
  String? _createdAt;

  Cerveja(
      {String? id,
      String? name,
      String? breweryType,
      String? street,
      String? city,
      String? state,
      String? postalCode,
      String? country,
      String? longitude,
      String? latitude,
      String? phone,
      String? updatedAt,
      String? createdAt}) {
    if (id != null) {
      this._id = id;
    }
    if (name != null) {
      this._name = name;
    }
    if (breweryType != null) {
      this._breweryType = breweryType;
    }
    if (street != null) {
      this._street = street;
    }
    if (city != null) {
      this._city = city;
    }
    if (state != null) {
      this._state = state;
    }
    if (postalCode != null) {
      this._postalCode = postalCode;
    }
    if (country != null) {
      this._country = country;
    }
    if (longitude != null) {
      this._longitude = longitude;
    }
    if (latitude != null) {
      this._latitude = latitude;
    }
    if (phone != null) {
      this._phone = phone;
    }
    if (updatedAt != null) {
      this._updatedAt = updatedAt;
    }
    if (createdAt != null) {
      this._createdAt = createdAt;
    }
  }

  String? get id => _id;
  set id(String? id) => _id = id;
  String? get name => _name;
  set name(String? name) => _name = name;
  String? get breweryType => _breweryType;
  set breweryType(String? breweryType) => _breweryType = breweryType;
  String? get street => _street;
  set street(String? street) => _street = street;
  String? get city => _city;
  set city(String? city) => _city = city;
  String? get state => _state;
  set state(String? state) => _state = state;
  String? get postalCode => _postalCode;
  set postalCode(String? postalCode) => _postalCode = postalCode;
  String? get country => _country;
  set country(String? country) => _country = country;
  String? get longitude => _longitude;
  set longitude(String? longitude) => _longitude = longitude;
  String? get latitude => _latitude;
  set latitude(String? latitude) => _latitude = latitude;
  String? get phone => _phone;
  set phone(String? phone) => _phone = phone;
  String? get updatedAt => _updatedAt;
  set updatedAt(String? updatedAt) => _updatedAt = updatedAt;
  String? get createdAt => _createdAt;
  set createdAt(String? createdAt) => _createdAt = createdAt;

  Cerveja.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _breweryType = json['brewery_type'];
    _street = json['street'];
    _city = json['city'];
    _state = json['state'];
    _postalCode = json['postal_code'];
    _country = json['country'];
    _longitude = json['longitude'];
    _latitude = json['latitude'];
    _phone = json['phone'];
    _updatedAt = json['updated_at'];
    _createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['name'] = this._name;
    data['brewery_type'] = this._breweryType;
    data['street'] = this._street;
    data['city'] = this._city;
    data['state'] = this._state;
    data['postal_code'] = this._postalCode;
    data['country'] = this._country;
    data['longitude'] = this._longitude;
    data['latitude'] = this._latitude;
    data['phone'] = this._phone;
    data['updated_at'] = this._updatedAt;
    data['created_at'] = this._createdAt;
    return data;
  }
}