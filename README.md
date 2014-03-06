# City Bird

_Description:_
  - Make meaningful connections. Be an ambassador to your city. Make new memories with a new friend._
_Deployed Test Site:_
  - <a href='http://city-bird.herokuapp.com/'>City Bird</a>
  - Login: public_pnjzbca_tester@tfbnw.net
  - Password: 123456

## Table of Contents

* [Initial White-Boarding](#initial-whiteboarding)
* [Schema](#schema)
* [Project Setup](#project-setup)
* [Testing](#testing)
* [Deploying](#deploying)
* [Troubleshooting](#troubleshooting)
* [Team Members](#team-members)

## <a name="initial-whiteboarding"></a>Initial White-Boarding
![Features](http://i.imgur.com/DxJF3yf.jpg?1)
![UserStory](http://i.imgur.com/2xXNr6e.jpg?1)

## <a name="schema"></a>Schema
![Schema](http://i.minus.com/ibikqHkEtJ9HQb.png)

## <a name="project-setup"></a>Project Setup

_How do I, as a developer, start working on the project?_
  - Start by cloning the project!
  - `$git clone https://github.com/jpark3000/find_a_guide folder_to_be_createds_name`
  - *** The $ symbol at the start of the line denotes the command/terminal line.

1. _What dependencies does it have (where are they expressed) and how do I install them?_
  - They are all listed in the Gemfile, but...
  - Production - Gon, Geocoder, Dotenv-rails, Rest-client, Postgres
  - Development/Test - Shoulda-Matchers, FactoryGirl, Faker, Capybara
  - Those are the gems required, besides what Rails 4 comes with.
  - The project uses the Mailgun and Facebook API, so you will need to obtain your own keys and place them in a .env.local file in your root directory:
    - MAILGUN_API_KEY
    - FACEBOOK_APP_ID
    - FACEBOOK_SECRET
    - DOMAIN (your domain for the site.  For local development it would be localhost of course.)
  -Additionally, if using your own email, replace the citybird email with your own in the emails controller, meetups controller, and emails model.

2. _How can I see the project working before I change anything?_
  - The usual way...
  - Clone the repo.
  - `$bundle, $rake db:create db:migrate, $rake db:seed (optional), $rails s`
  - Open a browser and type `localhost:3000` in the URL.

## <a name="testing"></a>Testing

_How do I run the project's automated tests?_

#### Below is the command to run all model/controller/integration tests using RSpec
1. `$rake spec`


## <a name="deploying"></a>Deploying

### _How to setup the deployment environment_

- Make sure to set your envioronment variables on the server (the variables identified in the .env.local file described previously)
- The app also makes use of rake tasks to send email notifications.  On Heroku, at least, you can use Heroku Scheduler.
- The javascript tree is not being required in application.js.  Any new, unique javascript files will need to be referenced for config/environments/production.rb


## <a name="troubleshooting"></a>Troubleshooting & Useful Tools

_Weird Stuff_
1. _You may have to..._
  - remove the `<%=ENV['FACEBOOK_APP_ID']%>` line from /app/assets/javascripts/facebook.
  - Save the file
  - `$rails s`
  - stop the rails server
  - replace the `<%=ENV['FACEBOOK_APP_ID']%>` line in /app/assets/javascripts/facebook.
  - `$rails s`
  - Then you're good to go!!!



## <a name="team-members"></a>Team Members
* <a href="https://github.com/jpark3000">Justin Park</a>
* <a href="https://github.com/stevenspiel">Steven Spiel</a>
* <a href="https://github.com/CharlieTruong">Charlie Truong</a>
* <a href="https://github.com/gnitnuj">Junting Lu</a>

