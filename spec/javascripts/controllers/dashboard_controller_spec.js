//= require language_users
//= require controllers/dashboard_controller
//= require bootstrap

describe("DashboardController", () => {

  describe("render()", () => {
    before(() => { this.server = sinon.fakeServer.create(); });
    after(() => { this.server.restore(); });

    it("forwards server data to a callback", () => {
      let cont = new App.Controllers.DashboardController();
      let serverData = [{ id: 1, name: 'French' }];

      let exp = sinon.mock(cont)
        .expects("validateLanguage")
        .withArgs(serverData);

      cont.render();

      this.server.requests[0].respond(
        200,
        { "content-type": "application/json" },
        JSON.stringify(serverData)
      );

      exp.verify();
    });

  });

  describe("validateLanguage(data)", () => {
    fixture.preload("test_form.html", "test_modal.html");

    beforeEach(() => {
      this.fixtures = fixture.load("test_form.html", "test_modal.html", true);
    });

    it("returns true when data is present", () => {
      let cont = new App.Controllers.DashboardController();
      let data = [{ name: 'French', id: 1 }];

      expect(cont.validateLanguage(data)).to.equal(true);
    });

    it("opens #language-form modal when no data is present", () => {
      $('.modal').prop('id', 'language-form');

      let cont = new App.Controllers.DashboardController();
      let exp = sinon.mock(cont.$modal).expects("modal");

      cont.validateLanguage([]);

      exp.verify();
    });
  });

});
