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

    func speakWeather(_ weatherModel : WeatherModel ) {
        
        var speechText = "The current weather for "
        
        // Build text based on conditions
        speechText += weatherModel.city + ". "
        speechText += "The temperature is" + weatherModel.temperature + " degrees. "

        // Start speech synthesis
        let utterance = AVSpeechUtterance(string: speechText)
        synthesizer.stopSpeaking(at: AVSpeechBoundary.immediate)
        synthesizer.speak(utterance)
    }
    
    func speakForecast() {
        let utterance = AVSpeechUtterance(string: "The weather forecast")
        synthesizer.stopSpeaking(at: AVSpeechBoundary.immediate)
        synthesizer.speak(utterance)
    }
}
