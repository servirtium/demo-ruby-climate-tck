Note - The World Bank took down their climate WebAPI. Darn it. We now depend on a docker version of the same until we work out what to do long term. Docker build and deploy this locally - https://github.com/servirtium/worldbank-climate-recordings - see README

TL;DR:

```
docker build git@github.com:servirtium/worldbank-climate-recordings.git#main -t worldbank-weather-api-for-servirtium-development
docker run -d -p 4567:4567 worldbank-weather-api-for-servirtium-development
```

The build for this demo project needs that docker container running

# demo-ruby-climate-tck

Demo of Servirtum using the [Climate Data API of the World Bank](https://datahelpdesk.worldbank.org/knowledgebase/articles/902061-climate-data-api)

This demo is a work in progress following a guide (at step 3 presently): https://github.com/servirtium/README/blob/master/starting-a-new-implementation.md

## Building & Running Tests

* Rubocop: `bundle exec rake rubocop`
* RSpec: `bundle exec rake spec`
  
