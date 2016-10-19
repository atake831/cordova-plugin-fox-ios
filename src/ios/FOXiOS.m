#import "FOXiOS.h"

@interface FOXiOS ()
@property (strong, nonatomic) NSString* loginCallbackId;
@end

@implementation FOXiOS {
}

- (void)pluginInitialize 
{
    NSLog(@"Starting FOX iOS plugin");
}

- (void)sendLTV:(CDVInvokedUrlCommand *)command
{
}

- (void)sendLTVPurchase:(CDVInvokedUrlCommand *)command
{
}


@end


