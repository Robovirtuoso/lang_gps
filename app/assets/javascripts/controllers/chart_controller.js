App.Controllers.ChartController = class ChartController {
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
      new App.StudyHabitChart({
        $el: $el.find('#language-chart'),
        entries: entries["entries"]
      }).render();

      new App.MultiLingualChart({
        $el: $el.find('#multi-language-chart'),
        entries: entries["entries"]
      }).render();

      for (let name in entries.entries.languages) {
        let language = entries.entries.languages[name];

        new App.LanguageChart({
          $el: $el.find(`#language-${language.id}-chart`),
          entries: language.study_habits
        }).render();
      }

      $el.find('.no-data-filler').css({
        opacity: 1
      });

    })
  }

}
