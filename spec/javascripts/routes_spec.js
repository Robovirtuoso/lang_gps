//= routes

fixture.preload("route_view.html");
describe("routes", () => {

  beforeEach(() => {
    this.fixtures = fixture.load("route_view.html", true);
  });

  afterEach(() => {
    delete App.Controllers.TestController;
  });

  describe("App.RouteTemplate#call()", () => {
    it("instantiates a controller based on a view element with corresponding id", () => {
      let spy = sinon.spy();

      App.Controllers.TestController = class TestController {
        render() {
          spy();
        }
      }

      let route = new App.RouteTemplate();
      route.call();

      expect(spy.called).to.be(true);
    });

    it("throws an error when `render` function is missing", () => {
      App.Controllers.TestController = class TestController {
      };
      
      let route = new App.RouteTemplate();

      try {
        route.call();
        sinon.assert.fail("Error not thrown");
      } catch (error) {
        expect(error.message).to.contain("Function `render` missing");  
      }
    });

  });

  describe("App.RouteTemplate#controllerName(viewId)", () => {
    it("returns the controller class for a view", () => {
      let testObj = (function() {});
      App.Controllers.TestController = testObj;

      let route = new App.RouteTemplate();
      expect(route.controllerName('test-view')).to.be(testObj);
    });

    it("throws an error when a controller doesn't exist for given viewId", () => {
      let route = new App.RouteTemplate();
      
      try {
        route.controllerName('nonexistent-view');
        sinon.assert.fail("Error not thrown");
      } catch (error) {
        expect(error.message).to.contain("Missing controller for view");
      }
    });

  });

});
