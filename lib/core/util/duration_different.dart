DurationDifference calculateDurationDifference(
    DateTime startDate, DateTime endDate) {
  int years = endDate.year - startDate.year;
  int months = endDate.month - startDate.month;
  int days = endDate.day - startDate.day;

  // Adjust days and months if days are negative
  if (days < 0) {
    months -= 1;
    final previousMonth = DateTime(endDate.year, endDate.month - 1);
    days += DateTime(endDate.year, endDate.month, 0).day -
        previousMonth.day +
        endDate.day;
  }

  // Adjust years if months are negative
  if (months < 0) {
    months += 12;
    years -= 1;
  }

  return DurationDifference(years, months, days);
}

class DurationDifference {
  int years;
  int months;
  int days;

  DurationDifference(this.years, this.months, this.days);

  @override
  String toString() {
    if (years == 0) {
      return '$months months';
    }
    return '$years years, $months months';
  }
}
