class ProgressChart extends BaseChart {
  columns() {
    return { 
      'date': 'Date',
      'number': 'Hours Studied'
    }
  }

  getData(entries) {
    return _.map(entries["all"], function(entry) {
      return [new Date(entry.when), entry.length];
    });
  }

  chartType() {
    return "Calendar";
  }
}

ProgressChart.prototype.chartOptions = {
  width: 800,
  calendar: { cellSize: 14 }
}
