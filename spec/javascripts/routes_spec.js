//= routes

fixture.preload("route_view.html");
describe("routes", () => {

  beforeEach(() => {
    this.fixtures = fixture.load("route_view.html", true);
  });

  afterEach(() => {
    delete Controllers.TestController;
  });

  describe("RouteTemplate#call()", () => {
    it("instantiates a controller based on a view element with corresponding id", () => {
      let spy = sinon.spy();

      Controllers.TestController = class TestController {
        render() {
          spy();
        }
      }

      let route = new RouteTemplate();
      route.call();

      expect(spy.called).to.be(true);
    });

    it("throws an error when `render` function is missing", () => {
      Controllers.TestController = class TestController {
      };
      
      let route = new RouteTemplate();

      try {
        route.call();
        sinon.assert.fail("Error not thrown");
      } catch (error) {
        expect(error.message).to.contain("Function `render` missing");  
      }
    });

  });

  describe("RouteTemplate#controllerName(viewId)", () => {
    it("returns the controller class for a view", () => {
      let testObj = (function() {});
      Controllers.TestController = testObj;

      let route = new RouteTemplate();
      expect(route.controllerName('test-view')).to.be(testObj);
    });

    it("throws an error when a controller doesn't exist for given viewId", () => {
      let route = new RouteTemplate();
      
      try {
        route.controllerName('nonexistent-view');
        sinon.assert.fail("Error not thrown");
      } catch (error) {
        expect(error.message).to.contain("Missing controller for view");
      }
    });

  });

});
