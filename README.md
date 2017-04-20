# Soccer Arena Website

**Soccer Arena** is a Ruby on Rails website let amateurs soccer teams meet, play and challenge each other.

Submitted by: **Echo Studio**

Time spent: **500** hours spent in total

URL: **https://soccerarena.herokuapp.com**

## User stories

### Field Owner
* [x] User can register as owner with avatar, username and password.
* [x] User can log in, log out as owner.
* [x] Owner can create the field with name, address.
* [x] Owner can edit its the field detail. The other users or owners does not have this permission.
* [x] Owner can see all the matches have booked through a calendar

### Field
* [x] Field owner can create the field.
* [x] Field contains detail information including name, address, map.
* [x] User can search field by name

### Match
* [x] Need 2 teams to start the match.
* [x] Host can invite other teams
* [x] Host can accept/decline request to match
* [x] Host can choose start time & end time for match through a calendar
* [x] Player can update match result, goal
* [x] Player can view match result
* [x] Record result of each match will be verified by admin
* [ ] User can select referee in a match.

### Player
* [x] User can create user as player with avatar, full name, email, password
* [x] User can log in, log out as player.
* [x] Player can update profile information.
* [x] Player can join the team. Player can join only one team.
* [x] Player has playing statistic (scored goal, played matches)
* [x] Player can write own blog post
* [ ] Team owner wants to book a slot need to put a deposit money.

### Team
* [x] Team will have default point 1000 after created.
* [x] Team can add or remove user
* [x] Team can book match.
* [x] Team has playing statistic (scored goal, played matches)
* [x] Team point will be increase or decrease by 25 for each win or loss.
* [x] User can sort team ranking by its current point.

### Notification
* [x] Player send/cancel join team request
* [x] Player accept/decline team invitation
* [x] Team send/cancel team invitation
* [x] Team accept/decline join team request
* [x] Home team send/cancel match invitation
* [x] Home team accept/decline match request
* [x] Away team send/cancel match request
* [x] Away team accept/decline match invitation

## Video Walkthrough

Here's a walkthrough of implemented user stories:

![Video Walkthrough](walkthrough.gif)

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

* Front-end: Semantic UI, Javascript, Jquery
* Back-end: Ruby on Rails
* Database: PostgreSQL

## Challenges

* Database design
* How to record & verify match result

## License

    Copyright [2017] [Echo Studio]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
