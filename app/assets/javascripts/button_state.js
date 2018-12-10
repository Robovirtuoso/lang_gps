(function() {
  class ButtonState {
    constructor(params) {
      if (params === undefined) params = {};

      let missingParams = [];
      if (!params.hasOwnProperty("$el")) missingParams.push("$el");
      if (!params.hasOwnProperty("$input")) missingParams.push("$input");

      if (missingParams.length > 0) {
        throw new Error(`Missing arguments: ${missingParams.join(",")}`);
      }

      this.$el = params.$el;
      this.$input = params.$input;

      // this selects the appropriate handler based on
      // the type of the input element (text, checkbox, select, etc.)
      let type = this.$input.prop('type');
      let handler = ButtonState.handlers[type];

      if (_.isUndefined(handler)) throw new Error("Missing ButtonState handler for type: " + type);

      // bindings
      this.handler = _.bind(handler, this);
    }

    addObservers() {
      this.toggleDisable(true);
      this.$input.on('change', this.handler);
    }

    toggleDisable(val) {
      // true disables
      // false enables
      return this.$el.prop("disabled", val);
    }
  }

  // All handlers will be executed in the context of a
  // ButtonState instance and a jQuery.Event instance
  // will be the first argument
  function checkboxHandler(e) {
    // returns true if at least one element is checked
    let toggle = _.some(this.$input, { 'checked': true });

    // we want to enable if checked
    // and disable if none checked
    this.toggleDisable(!toggle);
  };

  function textHandler(e) {
    // will return true or false
    let toggle = _.isEmpty(e.target.value);

    // if empty will disable
    // if not empty will enable
    this.toggleDisable(toggle);
  };

  ButtonState.handlers = {
    checkbox: checkboxHandler,
    text: textHandler
  };

  window.App || (window.App = {});
  App.ButtonState = ButtonState;
})();
