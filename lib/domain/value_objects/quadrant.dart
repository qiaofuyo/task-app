enum Quadrant {
  importantUrgent,
  importantNotUrgent,
  notImportantUrgent,
  notImportantNotUrgent,
}

extension QuadrantX on Quadrant {
  String get displayName {
    switch (this) {
      case Quadrant.importantUrgent:
        return '重要且紧急';
      case Quadrant.importantNotUrgent:
        return '重要但不紧急';
      case Quadrant.notImportantUrgent:
        return '不重要但紧急';
      case Quadrant.notImportantNotUrgent:
        return '不重要且不紧急';
    }
  }
}
