enum ScheduleType {
  normal,
  holiday,
}

ScheduleType scheduleTypeFromJson(String v) {
  return v == 'ScheduleType.normal'
      ? ScheduleType.normal
      : ScheduleType.holiday;
}
