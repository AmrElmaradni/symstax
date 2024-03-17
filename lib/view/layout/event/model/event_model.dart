class EventModel {
  List<Audience>? audience;
  String? date;
  String? description;
  String? email;
  String? eventType;
  String? id;
  String? createdAt;
  double? lat;
  double? lng;

  EventModel(
      {this.audience,
      this.date,
      this.description,
      this.email,
      this.eventType,
      this.id,
      this.createdAt,
      this.lat,
      this.lng});

  EventModel.fromJson(Map<String, dynamic> json) {
    if (json['audience'] != null) {
      audience = <Audience>[];
      json['audience'].forEach((v) {
        audience!.add(Audience.fromJson(v));
      });
    }
    date = json['date'];
    description = json['description'];
    email = json['email'];
    eventType = json['eventType'];
    id = json['id'];
    createdAt = json['createdAt'];
    lat = double.tryParse(json['lat'].toString());
    lng = double.tryParse(json['lng'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (audience != null) {
      data['audience'] = audience!.map((v) => v.toJson()).toList();
    }
    data['date'] = date;
    data['description'] = description;
    data['email'] = email;
    data['eventType'] = eventType;
    data['id'] = id;
    data['createdAt'] = createdAt;
    data['lat'] = lat?.toString();
    data['lng'] = lng?.toString();
    return data;
  }
}

class Audience {
  String? id;
  String? email;

  Audience({this.id, this.email});

  Audience.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    return data;
  }
}
