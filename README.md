# Salt Lake County (SLCo) Court Calendar Service

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

Create and migrate database.

```` sh
bundle exec rake db:create
bundle exec rake db:migrate
bundle exec rake db:seed
````

### Testing

Add features and corresponding tests. Run tests:

```` sh
bundle exec rspec spec/
````
