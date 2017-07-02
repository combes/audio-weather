# audio-weather
A simple weather app with voice and audio effects.
## Requirements
1. Build a really cool weather app
2. Receive data from a real weather service provider. Some examples...
a. [Wunderground](https://www.wunderground.com/weather/api/d/docs)
b. [AccuWeather](http://apidev.accuweather.com/developers/)
c. [OpenWeatherMap](https://openweathermap.org/api)
d. [Yahoo Weather](https://developer.yahoo.com/weather/)
3. Must display current weather for a location submitted by the user
4. Should incorporate a 'weather forecast' UI that is separate from the 'current weather'
5. Must update the weather data in the background at least every 1 hours
6. When weather data is fetched a notification must be displayed to the user that new weather data is available
7. Must persist the user’s location across app starts/stops
8. Must have a unit test to verify the objects used for fetching weather data

## Weather Elements

Yahoo Weather appears easiest to parse.
Example URL: https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%20in%20(select%20woeid%20from%20geo.places(1)%20where%20text%3D%22austin%2C%20tx%22)&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys

The first iteration of this app will include only basic elements:

* title ("Yahoo! Weather - Austin, TX, US")
* condition
    * text ("Partly Cloudy")
    * code [https://developer.yahoo.com/weather/documentation.html](https://developer.yahoo.com/weather/documentation.html)
    * temp ("98")
* wind
    * chill ("99")
    * direction ("180")
    * speed ("22")
* astronomy
    * sunrise ("6:29 am")
    * sunset ("8:35 pm")
* background image related to weather. Most likely include a handful of images due to time constraints.
* forecast (10 days - including today)
    * code [https://developer.yahoo.com/weather/documentation.html](https://developer.yahoo.com/weather/documentation.html)
    * date ("17 Jun 2017")
    * day ("Sat")
    * high ("99")
    * low ("77")
    * text ("Partly Cloudy")    

Also parse the following:
* units
    * distance ("mi")
    * pressure ("in")
    * speed ("mph")
    * temperature ("F")
