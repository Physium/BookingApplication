# Introduction

This is a 1 week Ruby on Rails challenge for me to learn and better understand the framework by building an application. 

The choice of application here is a room booking application which allows the users to sign up and make bookings to reserve rooms.

A live preview of the application is host at Heroku:
* (https://cryptic-hamlet-57533.herokuapp.com/) [https://cryptic-hamlet-57533.herokuapp.com/]
* Its a free instance, so please go easy on it.
* There are 2 categories of users, normal users and admin user.
* Normal users can simply sign up via the application and start using the application.
* Admin users are specifically assigned and have access to additional controls within the application. ( Adding of room, editing of users, full booking controls across all users )

Application is done with the following core technology:
* Rails 6
* Ruby 2.7
* Postgresql

## To Deploy Locally
* Ensure Rails 6 is installed locally by following [Offical Documentation](https://guides.rubyonrails.org/getting_started.html#creating-a-new-rails-project-installing-rails)
* Create database name with the respective name under ``config\database.yml``
* Run the following commands:
``` sh
git clone https://github.com/Physium/BookingApplication.git
bundle install
rails server
```
## Testing
* Uses in-built rails 6 test engine to carry out a serious of test on model and controller. 
* Wrote a couple of integration test to mimic user workflows in creating and editing a booking.
* Test can be run via ``rails test``

## Feature Improvement
* Booking workflow - Recommend users a room that is available within a particular timeslot
* Move to a more powerful calendar such as FullCalendar
* Work on providing a customer user profile and information page 
* Use a frontend framework like Angular/React
* Move away from bootstrap to materialcss of sort
* Introduce Devops capabilties (Conterizing, CICD deployment, Infra as a Code)
* Deploy on AWS


