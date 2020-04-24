//
//  RNUnifiedPush.h
//  HelloWorldReactNative
//
//  Created by Massimiliano Ziccardi on 24/04/2020.
//

#ifndef RNUnifiedPush_h
#define RNUnifiedPush_h

#import <React/RCTBridgeModule.h>

@interface RNUnifiedPush : NSObject <RCTBridgeModule>

+ (void)didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken;

@end


#endif /* RNUnifiedPush_h */
