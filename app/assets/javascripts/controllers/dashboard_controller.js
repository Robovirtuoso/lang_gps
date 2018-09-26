Controllers.DashboardController = class DashboardController {
  constructor(el) {
    this.el = el;
    this.languageUser = new LanguageUsers();
  }

  render() {
    this.languageUser.fetch().done(this.validateLanguage);
    return this;
  }

  validateLanguage() {
  }
}
