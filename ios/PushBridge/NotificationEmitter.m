//
//  NotificationEmitter.m
//  HelloWorldReactNative
//
//  Created by Massimiliano Ziccardi on 24/04/2020.
//

#import "NotificationEmitter.h"

@implementation NotificationEmitter

RCT_EXPORT_MODULE();


- (NSArray<NSString *> *)supportedEvents {
    return @[@"onUPSPushNotificationReceived"];
}


- (void)startObserving
{
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(sendEvent:)
                                               name:@"event-emitted"
                                              object:nil
   ];
}

- (void)stopObserving
{
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)sendEvent:(NSNotification *)notification {
  [self sendEventWithName:@"onUPSPushNotificationReceived" body:notification.userInfo];
}

+ (void)emitEvent:(NSDictionary*) payload
{
  [[NSNotificationCenter defaultCenter] postNotificationName:@"event-emitted"
                                                      object:self
                                                    userInfo:payload
   ];
}

@end
