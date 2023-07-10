//
//  main.m
//  NAtiveC#
//
//  Created by Mihir Das on 10/07/23.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

void SayHello(void);

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
        
        SayHello();
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}

