App.LanguageChart = class LanguageChart extends App.BaseChart {
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
