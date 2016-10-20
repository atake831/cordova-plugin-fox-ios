#import "FOXiOS.h"

@interface FOXiOS ()
@end

@implementation FOXiOS {
}

- (void)pluginInitialize 
{
    NSLog(@"Starting FOX iOS plugin");
}

- (void)sendLTV:(CDVInvokedUrlCommand *)command
{
    NSString* conversionID = [command.arguments objectAtIndex:0];
    
    if (conversionID != nil) {
        [self.commandDelegate runInBackground:^{
            AppAdForceLtv *ltv = [[AppAdForceLtv alloc] init];
            [ltv sendLtv:[conversionID intValue]];
            CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];;
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }];
    } else {
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"conversionID was null"];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
}

- (void)sendLTVPurchase:(CDVInvokedUrlCommand *)command
{
    NSString* conversionID = [command.arguments objectAtIndex:0];
    NSString* price = [command.arguments objectAtIndex:1];
    NSString* currency = [command.arguments objectAtIndex:2];
    NSString* itemName = [command.arguments objectAtIndex:3];
    
    if (conversionID != nil && price != nil && currency != nil) {
        [self.commandDelegate runInBackground:^{
            AppAdForceLtv *ltv = [[AppAdForceLtv alloc] init];
            [ltv addParameter:LTV_PARAM_PRICE:price];
            [ltv addParameter:LTV_PARAM_CURRENCY:currency];
            [ltv sendLtv:[conversionID intValue]];

            [ForceAnalyticsManager sendEvent:@"purchase" action:nil label:nil orderID:nil sku:nil itemName:itemName price:[price intValue] quantity:1 currency:currency];

            CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];;
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }];
    } else {
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"args were null"];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
}


@end


