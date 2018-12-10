(function() {
  class LanguageUsers {
    fetch() {
      return $.ajax({
        url: '/api/language_users/',
        method: 'GET',
        dataType: 'JSON'
      });
    }
  }

  window.App || (window.App = {});
  App.LanguageUsers = LanguageUsers;
})();
