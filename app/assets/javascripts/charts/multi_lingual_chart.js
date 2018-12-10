App.MultiLingualChart = class MultiLingualChart extends App.BaseChart {
  columns() {
    return {
      string: 'Language',
      number: 'Hours'
    }
  }

  getData(entries) {
    let data = [];
    for (let key in entries["languages"]) {
      data.push([key, entries["languages"][key]["total_time"]])
    }

    return data;
  }
}
