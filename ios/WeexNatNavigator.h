//
//  NatNavigator.h
//  WeexDemo
//
//  Created by HOOLI-008 on 17/2/18.
//  Copyright © 2017年 taobao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <WeexSDK/WeexSDK.h>


@protocol WeexNatNavigatorPro <WXModuleProtocol>

- (void)push:(NSDictionary *)params :(WXModuleCallback)callback;
- (void)pop:(NSDictionary *)params :(WXModuleCallback)callback;
- (void)setTitle:(NSDictionary *)params :(WXModuleCallback)callback;
- (void)setColor:(NSDictionary *)params :(WXModuleCallback)callback;
- (void)setBackgroungColor:(NSDictionary *)params :(WXModuleCallback)callback;
- (void)init:(NSDictionary *)params :(WXModuleCallback)callback;
- (void)hide:(WXModuleCallback)callback;
- (void)show:(WXModuleCallback)callback;


@end

@interface WeexNatNavigator : NSObject<WeexNatNavigatorPro>


@end
