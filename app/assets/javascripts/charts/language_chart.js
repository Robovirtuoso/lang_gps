class LanguageChart extends BaseChart {
  columns() {
    return {
      string: 'Study Habit',
      number: 'Hours'
    }
  }

  getData(collection) {
    return _.toPairs(collection);
  }
}
