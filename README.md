# README

## Notes

Please see this [note](https://github.com/zainafifaldi/good-night-app/blob/main/notes.md) before explore the project.

## How to Install

### Pre-requisite
- Ruby (>= 3.2.0)
- MySQL
- Redis

### Installation
1. Clone this repository using SSH
   ```bash
   git clone git@github.com:zainafifaldi/good-night-app.git
   ```

2. Copy env.sample file into .env
   ```bash
   cp env.sample .env
   ```
   Setup database variables based on your local env

3. Run bundle install to install all gems / dependencies
   ```bash
   bundle install
   ```

4. Run database migration, and run seeder for dummy user data
   ```bash
   rails db:migrate
   rails db:seed
   ```
   *Note: This will also create database if not exist*

5. Start the application server
   ```bash
   rails server
   ```

## Usable

### API Contract

[TBD]

### cURL

- API clock-in operation
   - **HTTP:**
      ```http
      POST /v1/sleep-records/clock-in HTTP/1.1
      Host: localhost:3000
      Content-Type: application/json
      Content-Length: 58

      {
         "user_id": 1,
         "clock_in_time_unix": 1733866200
      }
      ```
   - **cURL:**
      ```bash
      curl --location 'localhost:3000/v1/sleep-records/clock-in' \
      --header 'Content-Type: application/json' \
      --data '{
         "user_id": 1,
         "clock_in_time_unix": 1733866200
      }'
      ```

- API wake-up operation
   - **HTTP:**
      ```http
      POST /v1/sleep-records/wake-up HTTP/1.1
      Host: localhost:3000
      Content-Type: application/json
      Content-Length: 57

      {
         "user_id": 1,
         "wake_up_time_unix": 1733892300
      }
      ```
   - **cURL:**
      ```bash
      curl --location 'localhost:3000/v1/sleep-records/wake-up' \
      --header 'Content-Type: application/json' \
      --data '{
         "user_id": 1,
         "wake_up_time_unix": 1733892300
      }'
      ```

- API follow\
   - **HTTP:**
      ```http
      POST /v1/users/2/follow HTTP/1.1
      Host: localhost:3000
      Content-Type: application/json
      Content-Length: 24

      {
         "followee_id": 1
      }
      ```
   - **cURL:**
      ```bash
      curl --location 'localhost:3000/v1/users/2/follow' \
      --header 'Content-Type: application/json' \
      --data '{
         "followee_id": 1
      }'
      ```

- API unfollow\
   - **HTTP:**
      ```http
      POST /v1/users/2/unfollow HTTP/1.1
      Host: localhost:3000
      Content-Type: application/json
      Content-Length: 24

      {
         "followee_id": 1
      }
      ```
   - **cURL:**
      ```bash
      curl --location 'localhost:3000/v1/users/2/unfollow' \
      --header 'Content-Type: application/json' \
      --data '{
         "followee_id": 1
      }'
      ```

- API following sleep records\
   - **HTTP:**
      ```http
      GET /v1/users/2/following-sleep-records HTTP/1.1
      Host: localhost:3000
      ```
   - **cURL:**
      ```bash
      curl --location 'localhost:3000/v1/users/2/following-sleep-records'
      ```
