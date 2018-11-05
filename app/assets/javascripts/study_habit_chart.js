class StudyHabitChart extends BaseChart {
  columns() {
    return {
      string: 'Study Habit',
      number: 'Hours'
    }
  }

  whitelistFields() {
    return ['speaking', 'reading', 'writing', 'listening'];
  }

  getData(entries) {
    let data = [];
    for (let key in entries) {
      if (_.includes(this.whitelistFields(), key)) {
        data.push([key, entries[key]["total_time"]])
      }
    }

    return data;
  }
}
