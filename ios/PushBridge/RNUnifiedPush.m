//
//  RNUnifiedPush.m
//  HelloWorldReactNative
//
//  Created by Massimiliano Ziccardi on 24/04/2020.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AeroGearPush/AeroGearPush-Swift.h>
#import <React/RCTLog.h>

#import "RNUnifiedPush.h"

static NSData* _deviceToken;
static NSDictionary* _config;
static RCTResponseSenderBlock _callback;

@implementation RNUnifiedPush

RCT_EXPORT_MODULE();

+ (void)didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
  _deviceToken = deviceToken;
  if (_callback != nil) {
    [RNUnifiedPush registerToUPS: _callback];
  }
}

RCT_EXPORT_METHOD(initialize: (NSDictionary*)config onSuccess: (RCTResponseSenderBlock)callback) {
  _config = config;
  if (_config != nil) {
    [RNUnifiedPush registerToUPS:callback];
  } else {
    _callback = callback;
  }
}

+ (void)registerToUPS: (RCTResponseSenderBlock)callback {
  DeviceRegistration *d = [[DeviceRegistration alloc] initWithServerURL:[NSURL URLWithString:_config[@"url"]]];
  [d registerWithClientInfo:^(id<ClientDeviceInformation> clientInfo) {
    [clientInfo setDeviceToken:_deviceToken];
    [clientInfo setVariantID:_config[@"variantId"]];
    [clientInfo setVariantSecret:_config[@"secret"]];
    
    UIDevice *currentDevice = [UIDevice currentDevice];
    // set some 'useful' hardware information params
    [clientInfo setOperatingSystem:[currentDevice systemName]];
    [clientInfo setOsVersion:[currentDevice systemVersion]];
    [clientInfo setDeviceType:[currentDevice model]];
  } success:^{
    NSLog(@"UnifiedPush Server registration worked");
    callback(@[[NSNull null], @"Wow! Done!"]);
  } failure:^(NSError * err) {
    NSLog(@"UnifiedPush Server registration Error: %@", err);
    callback(@[err]);
  }];
}

@end
