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
        entries: entries["entries"],
        totalTime: entries["entries"]["total_time"]
      }).render();

      new MultiLingualChart({
        $el: $el.find('#multi-language-chart'),
        entries: entries["entries"],
        totalTime: entries["entries"]["total_time"]
      }).render();

      for (let name in entries.entries.languages) {
        let language = entries.entries.languages[name];

        new LanguageChart({
          $el: $el.find(`#language-${language.id}-chart`),
          entries: language.study_habits,
          totalTime: language.total_time
        }).render();
      }

      $el.find('.no-data-filler').css({
        opacity: 1
      });

    })
  }

}
