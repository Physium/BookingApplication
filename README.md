# Introduction

This is a 1 week Ruby on Rails challenge for me to learn and better understand the framework by building an application. 

The choice of application here is a room booking application which allows the users to sign up and make bookings to reserve rooms.

A live preview of the application is host at Heroku:
* [https://cryptic-hamlet-57533.herokuapp.com/](https://cryptic-hamlet-57533.herokuapp.com/)
* Its a free instance, so please go easy on it.
* There are 2 categories of users, normal users and admin user.
* Normal users can simply sign up via the application and start using the application.
* Admin users are specifically assigned and have access to additional controls within the application. ( Adding of room, editing of users, full booking controls across all users )

Application is done with the following core technology:
* Rails 6
* Ruby 2.7
* Postgresql

## To Deploy Locally
* Projects uses ruby 2.7. The ``.ruby-version`` file is already in place so you many use ``rbenv`` to install Ruby 2.7.0 and you are good to go.
* Ensure postgresql is installed. If mac, ``brew install postgresql`` will do the job. 
* Run the following commands:
``` sh
# Clone the Repository
git clone https://github.com/Physium/BookingApplication.git
cd BookingApplication

# Ensure that postgresql services is running
brew services start postgresql

# Install project dedepencies
bundle install
yarn install
rails db:create db:migrate

# Run
rails server
```
## Testing
* Uses in-built rails 6 test engine to carry out a series of tests on models and controllers. 
* Wrote a couple of integration test to mimic user workflows in creating and editing a booking.
* Test can be run via ``rails test``

## TODOs
* Switch frontend templating engine from erb to slim
* Switch test engine to RSpec

## Feature Improvement
* ~~Booking workflow - Recommend users a room that is available within a particular timeslot~~
* Move to a more powerful calendar such as FullCalendar
* Work on providing a customer user profile and information page 
* Use a frontend framework like Angular/React
* Move away from bootstrap to MaterialCSS of sort
* Introduce Devops capabilities (Containerizing, CICD deployment, Infra as a Code)
* Deploy on AWS


