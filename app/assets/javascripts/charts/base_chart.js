class BaseChart {
  constructor(options) {
    this.$el = options.$el;
    this.entries = options.entries;

    // bindings
    this.chart = _.bind(this.chart, this);
  }

  columns() {
    throw new Error("Chart must implement `columns` method returning a column object");
  }

  getData() {
    throw new Error("Chart must implement `getData` method returning an array of values corresponding to the column object");
  }

  render() {
    var data = new google.visualization.DataTable();

    var columns = this.columns();
    for (let type in columns) {
      data.addColumn({ type: type, id: columns[type] })
    }

    let entry = this.getData(this.entries);
    data.addRows(entry);
    this.chart().draw(data, this.chartOptions);

    return this;
  }

  chartType() {
    throw new Error("Chart must implement `chartType` method returning a string value of the type of Google chart to be rendered");
  }

  chart() {
    let type = this.chartType();
    // ie. PieChart, Calendar, etc.
    return new google.visualization[type](this.$el[0]);
  }
}

BaseChart.prototype.chartOptions = {
  width: 350
}
