## Overview
The [Enlighten Systems API](https://developer.enphase.com/docs) is a JSON-based API that provides access to performance data for a PV (Photovoltaic) system. This single page Rails app provides a demo for the following API methods using [Enphase]("#") gem.

  1. get_enphase_feed
  2. get_enphase_summary
  3. get_enphase_last_7_day_summaries
  4. get_enphase_last_7_day_stats
  5. get_enphase_today_stats
  6. get_enphase_historical_stats
  7. get_enphase_energy_lifetime


## Setup Prerequisites
1. [Ruby on Rails 3.2.18](http://www.rubyonrails.org)
2. [Ruby 2.1.5](https://www.ruby-lang.org/en/downloads/)
3. [Postgres 9.4](http://www.postgresql.org/) 


## Third Party gems used
1. EnPhase 1.0.0
2. RSpec


## Installation
1. Unzip the app to the desired directory.

2. Install the required gems using bundler with the following command. 
    ```"bundle install"```
    Note: If you are using windows, make sure you have DevKit 4.5.2 for the bundler to succeed.

3. Open ```config/database.yml``` and modify the values of database, username, host and password with the details you will be using.

4. Run ```"rake db:create"``` from the project root to create the database

5. Run ```"rake db:migrate"``` from the project root to run the migrations.

6. Execute the following command to run the application.
    ```"rails s -p <port_name>"```


## Running demo and verifying the API
1. Launch /demo in your browser.
2. Make sure you authorize with your Enlighten EnPhase account. (You might need to signup, verify your email and login into your Enlighten EnPhase account.)
3. Once you confirm connecting the application, you will be redirected back to the app with the ```enphase_user_id```.
4. For demo purposes, "4d7a45774e6a41320a" user_id is used to demonstrate the API calls. 
5. Choose one of the API calls from the select options.
6. The input fields are prefilled with sample data which can be used to get the response APIs.
7. You can either use them or give your own values and check for responses.

## References
1. [EnPhase gem](#)
2. [Enlighten Systems API](https://developer.enphase.com/docs)

## Limitations
1. "4d7a45774e6a41320a" is used for demonstrating the API calls in this app. To use your own ```enphase_user_id```, you will have to replace the private before filter method ```set_enphase_user_id``` with the commented code:
  def set_enphase_user_id
    @user_id = cookies[:enphase_user_id].blank? ? nil : cookies[:enphase_user_id]
  end
