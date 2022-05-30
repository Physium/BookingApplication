# Introduction
This started off as a 1 week Ruby on Rails challenge for me to learn and better understand the framework by building an application.
Well... thanks to this I'm now have the opportunity to deal with Rails on a day to day basis.
There are so many things that I have learnt on how to be simply better but I honestly find it hard to keep all the different concepts, practices and tools all into my gold fish brain.
Thus I see as an opportunity to implement some of the concepts/practices that I've learnt in a fun way by updating here time to time. 
This beats writing notes which is brutally boring, tedious and pointless at times(For me at least).

Nonetheless, I hope eventually this helps someone out who is looking to get started with Rails for some reason or another. (Why thou?)

# Application
The choice of application here is a room booking application which simply allows users to sign up and make room bookings.
As simple as that!

## Feature(s)
* User Authorization
* User Booking Management
* Administrative Management (Booking, User and Room Creation)


## Tech Stack
Application is done with the following core technology:
* Rails 6.0 (Duh~)
* Ruby 2.7
* PostgreSQL

## Testing
Tests were previously terribly written with MiniTest. Currently in progress of migrating all test to RSpec with proper coverage across models and controllers

Test can be run simply via running `rspec`in cli

# Getting Local Development Up
* Projects uses ruby 2.7. The ``.ruby-version`` file is already in place so you many use ``rbenv`` to install Ruby 2.7.0 and you are good to go.
* Require node `lts/fermium` which is used for yarn in Rails 6
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

## TODOs
* Switch frontend templating engine from erb to slim
* ~~Switch test engine to RSpec~~
* Clean up javascript frontend component with proper page javascript
* Finish up test coverage for controller
* Dockerize application to ease of deployment
* Create simple pipeline on github actions to manage code push
* Documentation on deploying to heroku

## Feature Improvement
* ~~Booking workflow - Recommend users a room that is available within a particular timeslot~~
* Move to a more powerful calendar such as FullCalendar
* Work on providing a customer user profile and information page 
* Use a frontend framework like Angular/React
* Introduce Devops capabilities (Containerizing, CICD deployment, Infra as a Code)
* Deploy on AWS


