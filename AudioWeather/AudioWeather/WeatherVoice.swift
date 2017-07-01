//
//  WeatherVoice.swift
//  AudioWeather
//
//  Created by Christopher Combes on 6/27/17.
//  Copyright © 2017 Christopher Combes. All rights reserved.
//

import AVFoundation

class WeatherVoice {
    static let shared = WeatherVoice()
    let synthesizer = AVSpeechSynthesizer()

    func speakWeather(_ weatherModel : WeatherModel) {
        
        var speechText = "The current weather for "
        
        // Build text based on conditions
        speechText += weatherModel.city + ". "
        speechText += "The temperature is " + weatherModel.temperature + " degrees. "
        speechText += "The wind chill is " + weatherModel.windChill + " degrees, from the "
        + weatherModel.windDirection.compassDirection(fullDescription: true) + " at " + UnitsViewModel.formattedSpeed(weatherModel.windSpeed) + ". "
        speechText += "Sunrise is at " + weatherModel.sunrise + ". "
        speechText += "Sunset is at " + weatherModel.sunset + ". "
        
        // Start speech synthesis
        let utterance = AVSpeechUtterance(string: speechText)
        synthesizer.stopSpeaking(at: AVSpeechBoundary.immediate)
        synthesizer.speak(utterance)
    }
    
    func speakForecast(_ weatherModel : WeatherModel) {
        var speechText = "The weather forecast for "
        
        // Build text based on forecast
        speechText += weatherModel.city + ". "
        
        for day in weatherModel.forecast {
            speechText += UnitsViewModel.fullDay(day.day) + " will be " + day.condition + ", "
            speechText += " with a high of " + day.high + " degrees, and "
            speechText += " low of " + day.low + " degrees. "
        }

        let utterance = AVSpeechUtterance(string: speechText)
        synthesizer.stopSpeaking(at: AVSpeechBoundary.immediate)
        synthesizer.speak(utterance)
    }
}
