// To parse this JSON data, do
//
//     final covidSessionByDistrict = covidSessionByDistrictFromJson(jsonString);

import 'dart:convert';

CovidSessionByDistrict covidSessionByDistrictFromJson(String str) =>
    CovidSessionByDistrict.fromJson(json.decode(str));

String covidSessionByDistrictToJson(CovidSessionByDistrict data) =>
    json.encode(data.toJson());

class CovidSessionByDistrict {
  CovidSessionByDistrict({
    this.sessions,
  });

  List<Session>? sessions;

  factory CovidSessionByDistrict.fromJson(Map<String, dynamic> json) =>
      CovidSessionByDistrict(
        sessions: List<Session>.from(
            json["sessions"].map((x) => Session.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "sessions": List<dynamic>.from(sessions!.map((x) => x.toJson())),
      };
}

class Session {
  Session({
    this.centerId,
    this.name,
    this.address,
    this.stateName,
    this.districtName,
    this.blockName,
    this.pincode,
    this.from,
    this.to,
    this.lat,
    this.long,
    this.feeType,
    this.sessionId,
    this.date,
    this.availableCapacity,
    this.availableCapacityDose1,
    this.availableCapacityDose2,
    this.fee,
    this.allowAllAge,
    this.minAgeLimit,
    this.vaccine,
    this.slots,
    this.maxAgeLimit
  });

  int? centerId;
  String? name;
  String? address;
  StateName? stateName;
  DistrictName? districtName;
  BlockName? blockName;
  int? pincode;
  String? from;
  String? to;
  int? lat;
  int? long;
  FeeType? feeType;
  String? sessionId;
  Date? date;
  int? availableCapacity;
  int? availableCapacityDose1;
  int? availableCapacityDose2;
  String? fee;
  bool? allowAllAge;
  int? minAgeLimit;
  int? maxAgeLimit;
  Vaccine? vaccine;
  List<String>? slots;

  factory Session.fromJson(Map<String, dynamic> json) => Session(
        centerId: json["center_id"],
        name: json["name"],
        address: json["address"],
        stateName: stateNameValues.map![json["state_name"]],
        districtName: districtNameValues.map![json["district_name"]],
        blockName: blockNameValues.map![json["block_name"]],
        pincode: json["pincode"],
        from: json["from"],
        to: json["to"],
        lat: json["lat"],
        long: json["long"],
        feeType: feeTypeValues.map![json["fee_type"]],
        sessionId: json["session_id"],
        date: dateValues.map![json["date"]],
        availableCapacity: json["available_capacity"],
        availableCapacityDose1: json["available_capacity_dose1"],
        availableCapacityDose2: json["available_capacity_dose2"],
        maxAgeLimit : json['max_age_limit'],
        fee: json["fee"],
        allowAllAge:
            json["allow_all_age"] == null ? null : json["allow_all_age"],
          
        minAgeLimit: json["min_age_limit"],
        vaccine: vaccineValues.map![json["vaccine"]],
        slots: List<String>.from(json["slots"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "center_id": centerId,
        "name": name,
        "address": address,
        "state_name": stateNameValues.reverse[stateName],
        "district_name": districtNameValues.reverse[districtName],
        "block_name": blockNameValues.reverse[blockName],
        "pincode": pincode,
        "from": from,
        "to": to,
        "lat": lat,
        "long": long,
        "fee_type": feeTypeValues.reverse[feeType],
        "session_id": sessionId,
        "date": dateValues.reverse[date],
        "available_capacity": availableCapacity,
        "available_capacity_dose1": availableCapacityDose1,
        "available_capacity_dose2": availableCapacityDose2,
        "fee": fee,
        "allow_all_age": allowAllAge == null ? null : allowAllAge,
        "min_age_limit": minAgeLimit,
        "vaccine": vaccineValues.reverse[vaccine],
        "slots": List<dynamic>.from(slots!.map((x) => x)),
      };
}

enum BlockName { NOT_APPLICABLE }

final blockNameValues =
    EnumValues({"Not Applicable": BlockName.NOT_APPLICABLE});

enum Date { THE_29072021 }

final dateValues = EnumValues({"29-07-2021": Date.THE_29072021});

enum DistrictName { CENTRAL_DELHI }

final districtNameValues =
    EnumValues({"Central Delhi": DistrictName.CENTRAL_DELHI});

enum FeeType { PAID, FREE }

final feeTypeValues = EnumValues({"Free": FeeType.FREE, "Paid": FeeType.PAID});

enum StateName { DELHI }

final stateNameValues = EnumValues({"Delhi": StateName.DELHI});

enum Vaccine { COVISHIELD, COVAXIN , SPUTNIK }

final vaccineValues =
    EnumValues({"COVAXIN": Vaccine.COVAXIN, "COVISHIELD": Vaccine.COVISHIELD});

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map!.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap!;
  }
}
