//
//  AppDelegate.m
//  LCEiTimerDiary
//
//  Created by 妖狐小子 on 2017/9/26.
//  Copyright © 2017年 妖狐小子. All rights reserved.
//

#import "AppDelegate.h"
#import "LCEHomeViewController.h"
#import "LCEAppManager.h"
#import <MagicalRecord/MagicalRecord.h>
//#import "SensorsAnalyticsSDK.h"

//#define SA_SERVER_URL @"YOUR_SERVER_URL"
//#define SA_DEBUG_MODE SensorsAnalyticsDebugOnly

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //适配iOS11导航问题
    if (@available(iOS 11.0, *)) {
        if (LCE_SYSTEM_VERSION >= 11.0) {
            [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
        }
    }
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.tabBarController = [[LCETabBarViewController alloc] init];
    self.naviController = [[LCENavigationController alloc] initWithRootViewController:self.tabBarController];
    self.window.rootViewController = self.naviController;
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    NSDictionary *attribute = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:18],
                                NSForegroundColorAttributeName : [UIColor whiteColor]};
    UINavigationBar *navBar = [UINavigationBar appearance];
    [navBar setTitleTextAttributes:attribute];
    [navBar setTintColor:[UIColor whiteColor]];
    [navBar setBarTintColor:LCE_NAV_COLOR];
    
    
//    [SensorsAnalyticsSDK sharedInstanceWithServerURL:SA_SERVER_URL
//                                    andLaunchOptions:launchOptions
//                                        andDebugMode:SA_DEBUG_MODE];
//    // 设置公共属性示例代码
//    [[SensorsAnalyticsSDK sharedInstance] registerSuperProperties:@{@"appName": @"iTimer"}];
//    [[SensorsAnalyticsSDK sharedInstance] enableTrackScreenOrientation:YES]; // CoreMotion 采集屏幕方向
//    [[SensorsAnalyticsSDK sharedInstance] enableTrackGPSLocation:YES];
//    [[SensorsAnalyticsSDK sharedInstance] enableAutoTrack:SensorsAnalyticsEventTypeAppStart |
//     SensorsAnalyticsEventTypeAppEnd |
//     SensorsAnalyticsEventTypeAppViewScreen |
//     SensorsAnalyticsEventTypeAppClick];
    
    // 配置文件
    [LCEAppManager shareInstance];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [MagicalRecord cleanUp];
    [self saveContext];
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"LCEiTimerDiary"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
