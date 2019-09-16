//
//  main.m
//  NewXcode11Scene
//
//  Created by yumengzhen on 2019/8/29.
//  Copyright © 2019 yumengzhen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "YMZAppDelegate.h"

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([YMZAppDelegate class]);
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
