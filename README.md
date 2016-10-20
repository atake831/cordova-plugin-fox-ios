# cordova-plugin-fox-ios

## Install

```
cordova plugin add cordova-plugin-fox-ios
```

AppAdForce.plistをxcodeプロジェクトに追加する。
参照：https://github.com/cyber-z/public-fox-ios-sdk/blob/3.x-master/lang/ja/README.md


AppDelegate.mを編集。以下を追記する。

```
- (BOOL)application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions
{
    self.viewController = [[MainViewController alloc] init];

add>>    [[AppAdForceManager sharedManager] cacheDefaultUserAgent];
add>>    [[AppAdForceManager sharedManager] sendConversionWithStartPage:@"default"];

    return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

```

```
#import "AdManager.h"
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
      sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    [[AppAdForceManager sharedManager] setUrlScheme:url];
    return YES;
}
```

URLSchemeを追加。

info.plistに以下を追加

```
App Transport Security Settings
  ▽Exception Domains
    ▽app-adforce.jp
      NSExceptionAllowsInsecureHTTPLoads Boolean YES
      NSIncludesSubdomains               Boolean YES
    ▽forceoperationx.com
      NSExceptionAllowsInsecureHTTPLoads Boolean YES
      NSIncludesSubdomains               Boolean YES
```

アクセス解析を行う場合、さらに以下を追記。

```
- (BOOL)application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions
{
    self.viewController = [[MainViewController alloc] init];

    [[AppAdForceManager sharedManager] cacheDefaultUserAgent];
    [[AppAdForceManager sharedManager] sendConversionWithStartPage:@"default"];

///// add /////
    if ([application applicationState] == UIApplicationStateBackground) {
        //バックグラウンド時の処理
    } else {
        //バックグラウンド時は起動計測が呼ばれないようにする
        [ForceAnalyticsManager sendStartSession];
    }
///// add /////

    return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

```

```
#import "AnalyticsManager.h"
- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [ForceAnalyticsManager sendStartSession];
}
```

## Usage

sendLTV(conversionID)

sendLTVPurchase(conversionID, price, currencty)



## libAppAdForceがnot foundでlinkerエラーになる場合
一度Link Binary With Librariesから削除して、platforms/ios/cabakuru/Plugins/cordova-plugin-fox-ios/libAppAdForce.aを追加する。

