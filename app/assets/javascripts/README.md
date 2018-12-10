# Router
The JS side of the application initializes through the router located under `routes.js`.
The `RouteTemplate` class is created under `app/views/application.html` where it then looks for any elements
in the dom that have an `id` ending in `-view`. It will then find a "controller" object that corresponds to
the view name and call `.render()` on it.

For example:

```html
<div id="test-view">
  <p>Here is some text</p>
</div>
```

```javascript
App.Controllers.TestController = class TestController {
  constructor(el) {
    this.el = el;
    this.paragraph = el.querySelector('p');
  }

  render() {
    console.log("I get called when the page loads");
  }
}
```

The controller must be placed under the `App.Controllers` namespace otherwise the RouteTemplate will not know how to create it.
If there is not a matching controller for a given view element then an error will be thrown.

For JavaScript code that needs to be encapsulated to a specific html element or a specific page it is recommended that this
pattern be used.
