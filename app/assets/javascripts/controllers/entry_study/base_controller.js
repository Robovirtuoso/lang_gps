App.EntryStudyBaseController = class EntryStudyBaseController {
  constructor(el) {
    this.el = el;
    this.$el = $(el);

    this.buttonState = new App.ButtonState({
      $el: this.$el.find('.form-control'),
      $input: this.$el.find('#study_habit_' + this.habitType())
    });
  }

  habitType() {
    throw new Error("Implement a habitType function returning one of the following values: [listening, reading, writing, speaking]");
  }

  render() {
    this.buttonState.addObservers();
    return this;
  }
}
