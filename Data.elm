module Data exposing (json)


json : String
json =
    """
    {
      "bio": "Patrick is a web developer, audio engineer, musician, and podcaster.",
      "projects": [
        {
          "id": 4,
          "name": "Pie Finder",
          "timeline": "Dec 2016",
          "status": "Active",
          "categories": ["Web"],
          "technologies": ["Python", "Flask", "Javascript"],
          "link": "https://pie-finder.herokuapp.com/",
          "src_link": "https://github.com/pkolo/raspberry-pi-challenge",
          "description": "A single-page front-end app where users can enter an ingredient and get back several pie recipes that incorporate that ingredient. Built in a day or so, mostly to familiarize myself with Python and the Flask framework. It also uses the Recipepuppy API."
        },
        {
          "id": 2,
          "name": "List-o-matic",
          "timeline": "Jan 2017 - current",
          "status": "Active",
          "categories": ["Web", "Music"],
          "technologies": ["Rails", "Ruby", "React", "Javascript"],
          "link": "https://list-o-matic.herokuapp.com/",
          "src_link": "https://github.com/pkolo/list-o-matic-v2",
          "description": "A web app that lets users log in and contribute to ranked lists of albums. Perfect for kinds of message boards where, for example, all the users want to make 'Top 50 Albums of the 90s' lists and compile those lists into an overall board-wide list. Most people who post on message boards still do this sort of thing by hand, if you can believe it. I figured, 'There must be a better way!' Built with Rails, React, PostgreSQL, and the Discogs API. Currently in use by my message board friends, but I'm still adding features."
        },
        {
          "id": 9,
          "name": "ihgbot",
          "timeline": "Apr 2017 - current",
          "status": "Active",
          "categories": ["Web"],
          "technologies": ["Python", "Flask"],
          "link": "http://ihgbot.herokuapp.com/random",
          "src_link": "https://github.com/pkolo/ihgbot",
          "description": "An API for a Slackbot. Generates mutant Markov chain Slack posts based on a corpus of message board posts made by my message board friends. Responds to many slash commands, sometimes posts by itself. Built using Python, Flask, and Scrapy. Note: the opinions expressed by ihgbot do not reflect those of its creator."
        },
        {
          "id": 10,
          "name": "Yacht or Nyacht?",
          "timeline": "Apr 2017 - current",
          "status": "In Progress",
          "categories": ["Web", "Music"],
          "technologies": ["Sinatra", "Ruby", "Javascript"],
          "link": "",
          "src_link": "https://github.com/pkolo/yacht-or-nyacht",
          "description": "A web-app version of the Yachtski Scale, used by the hosts of the Beyond Yacht Rock podcast to determine whether a given song is yacht rock or nyacht. Given a song and score, the app can also produce relevant album and personnel data (pulled from Discogs using their API).  Built with Ruby on Sinatra with PostgreSQL and Active Record, and using data from the Wateracre Calculator / Jay Gradient."
        },
        {
          "id": 3,
          "name": "Friend Rock",
          "timeline": "Apr 2017 - current",
          "status": "In Progress",
          "categories": ["Web", "Music"],
          "technologies": ["Rails", "Ruby"],
          "link": "",
          "src_link": "https://github.com/pkolo/friend-rock",
          "description": "An attempt to build a decent social network for bands. Most of the ones that exist are not very good at connecting bands with eachother. They want to connect bands to fans-- most bands have no fans, except other bands. This is a fact. This site will have a lot of good features for DIY and punk bands to use, I promise. So far it just uses Rails and PostgreSQL."
        },
        {
          "id": 1,
          "name": "Sounds Park",
          "timeline": "2015 - current",
          "status": "Active",
          "categories": ["Music", "Audio"],
          "technologies": ["Ableton Live", "Reaper"],
          "link": "https://soundcloud.com/sounds-park",
          "src_link": "",
          "description": "The main repository for my musical output. Intermittently updated with songs and remixes of my creation. Everything I make is DIY, self-recorded, self-produced. "
        },
        {
          "id": 5,
          "name": "Project Real World - Webseries",
          "timeline": "2013 - 2014",
          "status": "Inactive",
          "categories": ["Video", "Audio", "Comedy"],
          "technologies": ["Adobe Premiere", "Reaper"],
          "link": "http://projectrealworld.com/webseries/",
          "src_link": "",
          "description": "A six-episode 'animated' comedy webseries that I acted in,  co-wrote, co-engineered, co-edited, co-produced, co-directed, etc, etc. The story centers around Pad, a professional gamer with extreme social anxiety, and Mike Legg, a former insult comedian turned life coach. It's very funny, IMHO. Also, incidentally, this site is one of the first dynamic websites that I built myself using PHP and MySQL."
        },
        {
          "id": 6,
          "name": "Project Real World - Podcast",
          "timeline": "2015",
          "status": "Inactive",
          "categories": ["Podcast", "Comedy", "Audio"],
          "technologies": ["Reaper", "Ableton Live"],
          "link": "http://projectrealworld.com",
          "src_link": "",
          "description": "A 13-episode half-hour podcast based on the webseries that aired bi-weekly throughout 2015. Again, I performed in it, co-wrote, co-edited, co-produced, sound-designed, engineered etc, etc. Episodes include sketches, prank calls, documentary footage and field recordings, original music, call-ins, the works."
        },
        {
          "id": 7,
          "name": "Articulate",
          "timeline": "Jan 2017 - current",
          "status": "In Progress",
          "categories": ["Web"],
          "technologies": ["Rails", "Ruby", "React", "Javascript"],
          "link": "https://articulately.herokuapp.com/",
          "src_link": "https://github.com/AlexGio18/articulate-final-project",
          "description": "A web app for practicing public speeches and presentations. A user can hit 'start', perform their speech, and get immediate results on both their performance and content. We used the Web Speech API to parse speech to text in-browser, then sent that text to IBM Watson's Alchemy (RIP) and Tone Analyzer APIs to be analyzed. Once the data comes back from Watson, our server parses and interprets it into useful, human-readable feedback. Built by a team of four over the course of a week using Rails, React, and PostgreSQL. Unfortunately, do to the recent demise of the Alchemy API, service will be suspended until we adapt our server to the new Natural Language Understanding API."
        },
        {
          "id": 8,
          "name": "Overnight Sensation",
          "timeline": "2009 - 2016",
          "status": "Inactive",
          "categories": ["Music", "Podcast"],
          "technologies": ["Pro Tools", "Reaper"],
          "link": "http://www.btrtoday.com/listen/overnightsensation/",
          "src_link": "",
          "description": "A very long-running podcast that I produced and hosted on a weekly-basis for the BTRtoday (formerly Breakthru Radio) podcast network. I mostly played bands (punk, indiepop, lofi, hometaper, bedroom pop, DIY, and more production/distribution-based genres) that didn't have any records out and didn't have any fans and probably didn't expect too many people to hear their music. I typically found them by digging through online distribution channels like bandcamp and soundcloud and giving most anything a chance. I wish more people would do that, but they don't. Hopefully I will start up another version of this show soon."
        }
      ]
    }
    """
