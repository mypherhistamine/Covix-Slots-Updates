class VacCenterFound {
  String? centerName;
  String? timeFetched;
  String? pinCode;
  String? date;
  String? dose1;
  String? dose2;
  String? vaccineName;
  String? allAges;
  String? minAgeLimit;
  String? maxAgeLimit;
  String? availableCapacity;

  //constructor for the class
  VacCenterFound(
      {this.allAges,
      this.availableCapacity,
      this.centerName,
      this.dose2,
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
    dose2 - $dose2
    vacc-name $vaccineName;
    is-all-ages $allAges;
    min-age-limit $minAgeLimit;
    max-age-limit $maxAgeLimit;
    ''';
  }
}
