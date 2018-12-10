(function() {
  class RouteTemplate {
    classify(str) {
      return _.startCase(str.replace(/[\W_]/g, ' ')).replace(/\s/g, '');
    }

    controllerName(viewId) {
      let contId = _.replace(viewId, 'view','controller');
      let contName = this.classify(contId);
        
      let controller = App.Controllers[contName];

      if (controller) {
        return controller;
      } else {
        throw new Error(`Missing controller for view ${viewId}. Expected controller name: ${contName}`);
      }
    }

    call() {
      $('[id$="-view"]').each((idx, el) => {
        let className = this.controllerName(el.id);
        let cont = new className(el);

        if (typeof cont.render === "function") {
          cont.render();
        } else {
          throw Error("Function `render` missing from controller class: " + className);
        }
      });
    }
  }

  window.App || (window.App = {});
  App.RouteTemplate = RouteTemplate;
})()
