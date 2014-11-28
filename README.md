##Tracktor Web App

This is the Rails app which handles Harvest API integration, and serves as a middleman between the hardware and Harvest.

###Setup

It's a pretty straight forward Rails app, backed with a Postgres database.

To get set up and running locally, copy over the necessary config files.

```ruby
cp config/database.yml.example config/database.yml
cp config/harvest.yml.example config/harvest.yml
```

You'll need the harvest API credentials from [vigesafe](http://vigesafe.lab.viget.com/passwords/84fa27eb-484c-4b91-91d8-c3b043690a26).

###Testing

There are no tests.

This is an extra line
