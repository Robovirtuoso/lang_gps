//= require language_users

describe("LanguageUsers", () => {

  before(() => { this.server = sinon.fakeServer.create(); });
  after(() => { this.server.restore(); });

  describe("fetch()", () => {
    it("calls the server for languages based on user id", () => {
      let lang = new LanguageUsers();

      let langPromise = lang.fetch();

      this.server.requests[0].respond(
        200,
        { "Content-Type": "application/json" },
        JSON.stringify([
          { id: 1, name: 'Spanish' },
          { id: 2, name: 'French' }
        ])
      );

      langPromise.done((data) => {
        expect(data.length).to.be(2);
      });

    });
  });
});
