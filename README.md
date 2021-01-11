![Ruby](https://github.com/Lobarbon/Indie-Land/workflows/Ruby/badge.svg?branch=master)
# IndieLand
🍺 Indie-Land is a gorgeous place to discover Taiwan Indie Music activities immediately by just browsing our website. 

## Our goals
- Show recent indie music events sorted by date.
- Group events by the country; Therefore, people can select events by the place.

## Long-term goals
- Display events on the map so people can see nearby events.
- Users can leave comments on the events.
- Users can "like" the event and we will show the number of likes.

## Database Design
- We have two tables.
    - Event table
        | id | event_name | website | created_at | updated_at |
        |:--:|:----------:|:-------:|:----------:|:----------:|
        | 45 | 「手遊傳藝」聽障導覽活動報名 | https://event.culture.tw/NCFTA | 2020-11-08 11:24:27 +0800 | 2020-11-08 11:24:27 +0800 |

    - Session table
        | id | event_id | start_time | end_time | address | place | created_at | updated_at |
        |:--:|:--------:|:----------:|:--------:|:-------:|:-----:|:----------:|:----------:|
        | 57 | 45 | 2020/07/06 13:00:00 | 2020/07/06 13:00:00 | 268  宜蘭縣五結鄉五濱路二段201號 | | 2020-11-08 11:25:46.641456 +0800 | 2020-11-08 11:25:46.641456 +0800 |

- Relation
    - An event has one or more than one session.
        - The Session is a weak entity because it must depend on the Event.
    - ER diagram
        ![ER-Diagram][ER-Diagram]

## Usage
### Installation
If you don't have [Ruby] (2.7.1) please download.

Setup
```

```

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
or
```bash=
$ rake up
```
Ruby web servers such as Unicorn and Puma also ship with their own programs that you can use to run a Roda application.

By default, the base URL we're targeting is [http://localhost:9292].

### Rakefile
- Web App and Api
    - Run app.
        ```bash=
        $ rake up
        ```
    - Keep restarting web app upon changes
        ```bash=
        $ rake rerack
        ```
    - Run api.
        ```bash=
        $ rake api
        ```

- Quality Checks and Tests
    - Run all quality checks.
        ```bash=
        $ rake check:all
        ```
    - Run tests.
        ```bash=
        $ rake spec
        ```
    - Keep rerunning tests upon changes
        ```bash=
        $ rake respec
        ```

- Database
    - Run migrations.
        ```bash=
        $ rake db:migrate
        ```
    - Wipe records from all tables.
        ```bash=
        $ rake db:wipe
        ```
    - Delete dev or test database file.
        ```bash=
        $ rake db:drop
        ```

- Utilities
    - Run Irb Console
        ```bash=
        $ rake console
        ```
    - Clean cassette fixtures.
        ```bash=
        $ rake vcr:clean
        ```

## Language of the Domain
original JSON description -> our YAML description
- title -> `event name`
- sourceWebPromote -> `event website`
- descriptionFilterHtml -> `description`
- webSales -> `sale website`
- sourceWebName -> `source`
- showInfo -> `sessions`
    - time -> `start_time`
    - endTime -> `end_time`
    - location -> `address`
    - locationName -> `place`
    - price -> `ticket_price`

## Framework
- [Bootstrap]

[Ruby]: https://www.ruby-lang.org/en/
[Bootstrap]: https://getbootstrap.com/
[http://localhost:9292]: http://localhost:9292
[Indie-Land]: https://github.com/Lobarbon/Indie-Land.git
[ER-Diagram]: https://github.com/Lobarbon/Indie-Land/blob/database/png/ER_Diagram.png
