Controllers.ChartController = class ChartController {
  constructor(el) {
    this.el = el;
    this.chartEl = $(this.el).find('#language-chart')[0];

    // bindings
    this.renderChart = _.bind(this.renderChart, this);
  }

  render() {
    google.charts.load('current', {'packages':['corechart']});
    google.charts.setOnLoadCallback(this.renderChart);
    return this;
  }

  renderChart() {
    var $el = $(this.el);

    $.ajax({
      url: '/api/entries/',
      method: 'GET',
      dataType: 'JSON'
    }).done((entries) => {
      new StudyHabitChart({
        $el: $el.find('#language-chart'),
        entries: entries
      }).render();

      new MultiLingualChart({
        $el: $el.find('#multi-language-chart'),
        entries: entries
      }).render();
    })
  }

}
