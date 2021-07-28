class VacCenterFound {
  String? centerName;
  String? timeFetched;
  String? pinCode;
  String? date;
  String? dose1;
  String? vaccineName;
  String? allAges;
  String? minAgeLimit;
  String? maxAgeLimit;

  //constructor for the class
  VacCenterFound(
      {this.allAges,
      this.centerName,
      this.date,
      this.dose1,
      this.maxAgeLimit,
      this.minAgeLimit,
      this.pinCode,
      this.timeFetched,
      this.vaccineName});

  @override
  String toString() {
    return '''
    Center Name: $centerName,
    centerName;
    time-fetched $timeFetched;
    pincode $pinCode;
    date-of-vaccine $date;
    dose-1-seats $dose1;
    vacc-name $vaccineName;
    is-all-ages $allAges;
    min-age-limit $minAgeLimit;
    max-age-limit $maxAgeLimit;
    ''';
  }
}
