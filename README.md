# gingerSpice

_Description: Make meaningful connections. Be an ambassador to your city. Make new memories with a new friend._

## Table of Contents

* [Initial White-Boarding](#initial-whiteboarding)
* [Schema](#schema)
* [Project Setup](#project-setup)
* [Testing](#testing)
* [Deploying](#deploying)
* [Troubleshooting](#troubleshooting)
* [Team Members](#team-members)

## <a name="initial-whiteboarding"></a>Initial White-Boarding
![Features](http://i.minus.com/iGABsn7Bg2Hf0.jpg)
![UserStory](http://i.minus.com/i4dlGntnpFvev.JPG)

## <a name="schema"></a>Schema
![Schema](http://i.minus.com/ibikqHkEtJ9HQb.png)

## <a name="project-setup"></a>Project Setup

_How do I, as a developer, start working on the project?_
  - Start by cloning the project!
  - $git clone https://github.com/jpark3000/find_a_guide folder_to_be_createds_name
  - *** The $ symbol at the start of the line denotes the command/terminal line.

1. _What dependencies does it have (where are they expressed) and how do I install them?_
  - They are all listed in the Gemfile, but...
  - Production - Gon, Geocoder, Dotenv-rails, Rest-client, Postgres
  - Development/Test - Shoulda-Matchers, FactoryGirl, Faker, Capybara
  - Those are the gems required, besides what Rails 4 comes with.

2. _How can I see the project working before I change anything?_
  - The usual way...
  - Clone the repo.
  - $bundle, $rake db:create db:migrate, $rake db:seed (optional), $rails s
  - Open a browser and type localhost:3000 in the URL.

## <a name="testing"></a>Testing

_How do I run the project's automated tests?_

#### Below is the command to run all model/controller/integration tests using RSpec
1. $rake spec


## <a name="deploying"></a>Deploying

### _How to setup the deployment environment_

- Ask  <a href="https://github.com/CharlieTruong">Charlie</a>. jajaja ;)

### _How to deploy_

## <a name="troubleshooting"></a>Troubleshooting & Useful Tools

_Weird Stuff_
1. _You may have to..._
  - remove the '<%=ENV['FACEBOOK_APP_ID']%>' line from /app/assets/javascripts/facebook.
  - Save the file
  - $rails s
  - stop the rails server
  - replace the <%=ENV['FACEBOOK_APP_ID']%> line in /app/assets/javascripts/facebook.
  - $rails s
  - Then you're good to go!!!



## <a name="team-members"></a>Team Members
* <a href="https://github.com/jpark3000">Justin Park</a>
* <a href="https://github.com/stevenspiel">Steven Spiel</a>
* <a href="https://github.com/CharlieTruong">Charlie Truong</a>
* <a href="https://github.com/gnitnuj">Junting Lu</a>

