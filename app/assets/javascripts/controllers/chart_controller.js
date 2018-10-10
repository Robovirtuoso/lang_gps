Controllers.ChartController = class ChartController {
  constructor(el) {
    this.el = el;
    this.chartEl = $(this.el).find('#language-chart')[0];


    // bindings
    this.renderChart = _.bind(this.renderChart, this);
    this.chart = _.bind(this.chart, this);
  }

  render() {
    google.charts.load('current', {'packages':['corechart']});
    google.charts.setOnLoadCallback(this.renderChart);
    return this;
  }

  renderChart() {
    var data = new google.visualization.DataTable();
    data.addColumn('string', 'Study Habit');
    data.addColumn('number', 'Time');
    /*
       Need to have code call API for study habits
     */

    // data.addRows([
    //   ['Listening', 10],
    //   ['Reading', 5]
    // ])

    $.ajax({
      url: '/api/entries/',
      method: 'GET',
      dataType: 'JSON'
    }).done((entries) => {
      // data.addRows(entries);

      let enty = this.getData(entries["entries"]);
      data.addRows(enty);
      this.chart().draw(data, this.options);
    })

  }

  getData(entries) {
    let data = [];
    for (let key in entries) {
      data.push([key, entries[key]["total_time"]["hours"]])
    }

    return data;
  }

  chart() {
    return new google.visualization.PieChart(this.chartEl);
  }
}

Controllers.ChartController.prototype.chartOptions = {
  title: 'Study progress for the week',
  width: 500,
  height: 400
}
