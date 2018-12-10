//= require button_state
//= require jquery

describe("App.ButtonState", () => {

  describe(".constructor()", () => {
    it("throws an error if all arguments aren't provided", () => {
      try {
        new App.ButtonState();
        sinon.assert.fail("no error thrown");
      } catch (e) {
        expect(e.message).to.contain("Missing arguments: $el,$input");
      }
    });

    it("throws an error if only one arguments is provided", () => {
      try {
        new App.ButtonState({ $el: "" });
        sinon.assert.fail("no error thrown");
      } catch (e) {
        expect(e.message).to.contain("Missing arguments: $input");
      }

      try {
        new App.ButtonState({ $input: "" });
        sinon.assert.fail("no error thrown");
      } catch (e) {
        expect(e.message).to.contain("Missing arguments: $el");
      }
    });
  });

  describe("#addObservers()", () => {
    fixture.preload("test_form.html");

    beforeEach(() => {
      this.fixtures = fixture.load("test_form.html", true);
    });

    it("disables the element", () => {
      let button = new App.ButtonState({
        $el: $('#test_button'),
        $input: $('[name="email"]')
      });

      button.addObservers();
      expect(button.$el.is(':disabled')).to.equal(true);
    });

    it("it removes disable attr when input is filled", () => {
      let button = new App.ButtonState({
        $el: $('#test_button'),
        $input: $('[name="email"]')
      });

      button.addObservers();

      $('[name="email"]')
        .val("testemail@ruby.com")
        .trigger('change');

      expect(button.$el.is(':disabled')).to.equal(false);
    });

    it("adds the disable attr when input is filled and then emptied", () => {
      let button = new App.ButtonState({
        $el: $('#test_button'),
        $input: $('[name="email"]')
      });

      button.addObservers();

      $('[name="email"]').val("testemail@ruby.com").trigger('change');
      $('[name="email"]').val("").trigger('change');

      expect(button.$el.is(':disabled')).to.equal(true);
    });

    context("handles checkboxes", () => {
      it("is disabled when no checkbox is selected", () => {
        let button = new App.ButtonState({
          $el: $('#test_button'),
          // a group of checkboxes
          $input: $('[name="[car][]"]')
        });

        button.addObservers();
        expect(button.$el.is(':disabled')).to.equal(true);
      });

      it("enables button when at least one checkbox is selected", () => {
        let button = new App.ButtonState({
          $el: $('#test_button'),
          // a group of checkboxes
          $input: $('[name="[car][]"]')
        });

        button.addObservers();

        $('#car_jeep').prop('checked', true).trigger('change');
        expect(button.$el.is(':disabled')).to.equal(false);
      });

      it("stays enabled when multiple are selected", () => {
        let button = new App.ButtonState({
          $el: $('#test_button'),
          // a group of checkboxes
          $input: $('[name="[car][]"]')
        });

        button.addObservers();

        $('#car_jeep').prop('checked', true).trigger('change');
        $('#car_limo').prop('checked', true).trigger('change');
        expect(button.$el.is(':disabled')).to.equal(false);
      });

      it("disables if selected and then deselected", () => {
        let button = new App.ButtonState({
          $el: $('#test_button'),
          // a group of checkboxes
          $input: $('[name="[car][]"]')
        });

        button.addObservers();

        let $jeep = $('#car_jeep');
        $jeep.prop('checked', true).trigger('change');
        $jeep.prop('checked', false).trigger('change');

        expect(button.$el.is(':disabled')).to.equal(true);
      });
    });
  });

});
