#import <Foundation/Foundation.h>
#import <Cordova/CDV.h>
#import "AppDelegate.h"
#import "AdManager.h"

@interface FOXiOS : CDVPlugin 
- (void)sendLTV:(CDVInvokedUrlCommand *)command;
- (void)sendLTVPurchase:(CDVInvokedUrlCommand *)command;
@end
