# README

## Notes

Please see this [note](https://github.com/zainafifaldi/good-night-app/blob/main/notes.md) before explore the project.

## How to Install

### Pre-requisite
- Ruby (>= 3.2.0)
- MySQL

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
