//
//  ShowNetworkMessage.swift
//  AudioWeather
//
//  Created by Christopher Combes on 6/20/17.
//  Copyright © 2017 Christopher Combes. All rights reserved.
//

import SwiftMessages

func showNetworkOutage(view: UIView) {
    // Instantiate a message view from the provided card view layout. SwiftMessages searches for nib
    // files in the main bundle first, so you can easily copy them into your project and make changes.
    let view = MessageView.viewFromNib(layout: .StatusLine)
    
    // Theme message elements with the warning style.
    view.configureTheme(.error)
    
    // Add a drop shadow.
    view.configureDropShadow()
    
    // Set message title, body, and icon. Here, we're overriding the default warning
    // image with an emoji character.
    view.configureContent(body: "Network disconnected")
    
    // Show the message.
    SwiftMessages.show(view: view)
}
