Controllers.DashboardController = class DashboardController {
  constructor(el) {
    this.el = el;
    this.languageUser = new LanguageUsers();
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
    }
  }
}
