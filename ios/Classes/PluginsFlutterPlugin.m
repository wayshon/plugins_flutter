#import "PluginsFlutterPlugin.h"

@implementation PluginsFlutterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"plugins_flutter"
            binaryMessenger:[registrar messenger]];
  PluginsFlutterPlugin* instance = [[PluginsFlutterPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"getPlatformVersion" isEqualToString:call.method]) {
    result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
  } else if ([@"share" isEqualToString:call.method]) {
      NSString *textToShare = @"hahahahaha";
      NSURL *urlToShare = [NSURL URLWithString:@"http://www.baidu.com"];
//      UIImage *imageToShare = [UIImage imageNamed:@"doudou.jpeg"];
//      NSArray *activityItems = @[textToShare,imageToShare, urlToShare];
      NSArray *activityItems = @[textToShare, urlToShare];
      UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:activityItems applicationActivities:nil];
      activityVC.excludedActivityTypes = @[UIActivityTypePrint, UIActivityTypeCopyToPasteboard,UIActivityTypeAssignToContact,UIActivityTypeSaveToCameraRoll];
      [[self getCurrentVC] presentViewController:activityVC animated:YES completion:nil];
      activityVC.completionWithItemsHandler = ^(UIActivityType  _Nullable activityType, BOOL completed, NSArray * _Nullable returnedItems, NSError * _Nullable activityError) {
          if (completed) {
              result(@(YES));
          } else  {
              result(@(NO));
          }
      };
  } else {
    result(FlutterMethodNotImplemented);
  }
}

- (UIViewController *)getCurrentVC

{

    UIViewController *result = nil;

    

    UIWindow * window = [[UIApplication sharedApplication] keyWindow];

    if (window.windowLevel != UIWindowLevelNormal)

    {

        NSArray *windows = [[UIApplication sharedApplication] windows];

        for(UIWindow * tmpWin in windows)

        {

            if (tmpWin.windowLevel == UIWindowLevelNormal)

            {

                window = tmpWin;

                break;

            }

        }

    }

    

    UIView *frontView = [[window subviews] objectAtIndex:0];

    id nextResponder = [frontView nextResponder];

    

    if ([nextResponder isKindOfClass:[UIViewController class]])

        result = nextResponder;

    else

        result = window.rootViewController;

    

    return result;

}

@end
