//
//  NotificationEmitter.h
//  HelloWorldReactNative
//
//  Created by Massimiliano Ziccardi on 24/04/2020.
//

#ifndef NotificationEmitter_h
#define NotificationEmitter_h

#import <React/RCTBridgeModule.h>
#import <React/RCTEventEmitter.h>

@interface NotificationEmitter : RCTEventEmitter <RCTBridgeModule>

+ (void)emitEvent:(NSDictionary*) payload;

@end


#endif /* NotificationEmitter_h */
