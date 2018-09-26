class LanguageUsers {
  fetch() {
    return $.ajax({
      url: '/api/language_users/',
      method: 'GET',
      dataType: 'JSON'
    });
  }
}
