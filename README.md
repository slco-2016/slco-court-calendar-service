# Salt Lake County (SLCo) Court Calendar Service

## Usage

Visit production application at __________.

Request data from the API.

### API

#### Event Search

Responds with zero or more court calendar events.

`GET /api/v0/event-search.json`

##### Search Parameters

Specify one or more search parameters. A result will be included in the response if it matches ALL request conditions.

event_search_parameter | description | example
--- | --- | ---
`first_name` | The defendant's first name. | `MICHAEL`
`last_name` | The defendant's last name. | `LOPEZ`
`birth_date` | The defendant date of birth in YYYY-MM-DD format. | `1988-04-05`





## Contributing

### Prerequisites

[Install](http://data-creative.info/process-documentation/2015/07/18/how-to-set-up-a-mac-development-environment.html#ruby) ruby and bundler.

[Install](http://data-creative.info/process-documentation/2015/07/18/how-to-set-up-a-mac-development-environment.html#postgresql) postgresql.

Download source code and install package dependencies.

```` sh
git clone git@github.com:slco-2016/slco-court-calendar-service.git
cd slco-court-calendar-service/
bundle install
````

Set the following environment variables based on credentials obtained from county government partners:

 + `SLCO_FTP_HOST`
 + `SLCO_FTP_USER`
 + `SLCO_FTP_PASSWORD`

Create database user.

```` sh
psql
CREATE USER courtbot_slco WITH ENCRYPTED PASSWORD 'c0urtb0t!';
ALTER USER courtbot_slco CREATEDB;
ALTER USER courtbot_slco WITH SUPERUSER;
\q
````

Create and migrate the development database.

```` sh
bundle exec rake db:create
bundle exec rake db:migrate
bundle exec rake db:seed
````

Extract VINE data from the SLCo FTP server.

```` sh
bundle exec rake extract:vine_files
````

### Testing

Create and migrate the test database.

```` sh
bundle exec rake db:test:prepare
````

Add features and corresponding tests, then run tests.

```` sh
bundle exec rspec spec/
````
