# lang_gps
`lang_gps` is an application for recording your language learning progress.

## Ideology
When studying a foreign language there are four main categories for which you will need to practice.

  * listening
  * reading
  * writing
  * speaking

As you are on your path to fluency in any given language you want to ensure that your study habits
involve a balanced allocation of time between these four methods. If every day you only practice reading
you will never improve your listening ability.

`lang_gps` is meant to provide you with tracking functionality that helps you shape the way you study.

## Using the App
After logging into the app, select the language(s) you wish to study from the pop-up modal and then click the `New Entry` link.
Enter in your study time for the day and then watch as your progress evolves daily.

## Server
After pulling down the code simply run the following command to get setup.

`./bin/setup`

## Dev Server
The dev server for this app can be found at: [https://lang-gps-dev.herokuapp.com/](https://lang-gps-dev.herokuapp.com/)

## Testing

`rspec` is the testing framework used for rails while `mocha` is used for javascript with `teaspoon` being the runner.

`bundle exec rspec spec/`
`bundle exec teaspoon`

JS specs can also be executed by running the server and navigating to `localhost:3000/teaspoon`
