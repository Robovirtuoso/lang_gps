//= require language_users
//= require controllers/dashboard_controller


describe("DashboardController", () => {
  before(() => { this.server = sinon.fakeServer.create(); });
  after(() => { this.server.restore(); });

  describe("render()", () => {

    it("forwards server data to a callback", () => {
      let cont = new Controllers.DashboardController();
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

});
