App.Controllers.DashboardController = class DashboardController {
  constructor(el) {
    this.el = el;
    this.languageUser = new App.LanguageUsers();
    this.$modal = $('.modal#language-form');

    // bindings
    this.validateLanguage = _.bind(this.validateLanguage, this);
  }

  render() {
    this.languageUser.fetch().done(this.validateLanguage);
    return this;
  }

  validateLanguage(data) {
    if (data.length > 0) {
      return true;
    } else {
      this.$modal.modal();

      new App.ButtonState({
        $el: $('[type="submit"]'),
        // checkbox type specified because rails creates a hidden
        // input field with the same name as the other checkbox inputs
        $input: $('[type="checkbox"][name="language_user[language_id][]"]')
      }).addObservers();
    }
  }

}
