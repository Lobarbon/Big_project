# Team7 2020 SOA Project

## Usage
### Installation
If you don't have [Ruby] please download.

Step1. Clone the [Indie-Land].
```bash=
$ git clone https://github.com/Lobarbon/Indie-Land.git
$ cd Indie-Land
```

Step2. Install ``Bundler`` package, if you have ``Bundler`` please jump to ``Step3``.
```bash=
$ gem install bundler
```

Step3. Install ``Gemfile`` package.
```bash=
$ bundle install
```

### Running the Application
Running a Roda application is similar to running any other rack-based application that uses a ``config.ru`` file. You can start a basic server using ``rackup``:
```bash=
$ rackup
```
Ruby web servers such as Unicorn and Puma also ship with their own programs that you can use to run a Roda application.

By default, the base URL we're targeting is [http://localhost:9292].

### Language of the Domain
original JSON description -> our YAML description
- title -> title
- sourceWebPromote -> `website`
- showInfo -> `infos`
- time -> `start_time`
- endTime -> `end_time`
- location -> `address`
- locationName -> `location`

## Api Explore
Get Indie music information on Taiwan Open Data Platform
