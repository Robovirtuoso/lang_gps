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
      data.addColumn(type, columns[type])
    }

    let entry = this.getData(this.entries);
    data.addRows(entry);
    this.chart().draw(data, this.chartOptions);

    return this;
  }

  chart() {
    return new google.visualization.PieChart(this.$el[0]);
  }
}

BaseChart.prototype.chartOptions = {
  width: 350
}
