/**
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

#import "AppDelegate.h"

#import <React/RCTBridge.h>
#import <React/RCTBundleURLProvider.h>
#import <React/RCTRootView.h>

/* ADICIONADO */
/* ADICIONADO */
  #import <FBSDKCoreKit/FBSDKCoreKit.h>
/* ADICIONADO */
/* ADICIONADO */

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  RCTBridge *bridge = [[RCTBridge alloc] initWithDelegate:self launchOptions:launchOptions];
  RCTRootView *rootView = [[RCTRootView alloc] initWithBridge:bridge
    moduleName:@"authFacebook"
    initialProperties:nil];
    
  /* ADICIONADO */
  /* ADICIONADO */
    [[FBSDKApplicationDelegate sharedInstance] application:application 
    didFinishLaunchingWithOptions:launchOptions];
  /* ADICIONADO */
  /* ADICIONADO */

  rootView.backgroundColor = [[UIColor alloc] initWithRed:1.0f green:1.0f blue:1.0f alpha:1];

  self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
  UIViewController *rootViewController = [UIViewController new];
  rootViewController.view = rootView;
  self.window.rootViewController = rootViewController;
  [self.window makeKeyAndVisible];
  return YES;
}


/* ADICIONADO */
/* ADICIONADO */
  - (BOOL)application:(UIApplication *)application 
      openURL:(NSURL *)url 
      options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options { 
  BOOL handled = [[FBSDKApplicationDelegate sharedInstance] application:application 
  openURL:url 
  sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey] 
  annotation:options[UIApplicationOpenURLOptionsAnnotationKey] 
  ]; 
  // Add any custom logic here. 
  return handled; 
  }
/* ADICIONADO */
/* ADICIONADO */


- (NSURL *)sourceURLForBridge:(RCTBridge *)bridge
{
#if DEBUG
  return [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index" fallbackResource:nil];
#else
  return [[NSBundle mainBundle] URLForResource:@"main" withExtension:@"jsbundle"];
#endif
}

@end


    

    