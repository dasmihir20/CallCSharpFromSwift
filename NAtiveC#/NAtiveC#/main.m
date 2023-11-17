//
//  main.m
//  NAtiveC#
//
//  Created by Mihir Das on 10/07/23.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

enum AppBrand
{
       Thrive = 1,
       KIND,
       ProAkustik,
       MyStarkey,
       MyAudibel
};

enum LogLevel
{
     None = 0,
     Error,
     Warning,
     Info,
     Debug
};

typedef void* GCHandle;

void SayHello(void);
//void SumCall(void);
int Add(int a, int b);
char* SumString(char const * a, char const * b);

GCHandle StructReturn(void);
void UpdateFirstName(GCHandle object, char const * fName);


typedef void(*callbackFunction)(int value);
void set_native_callback (callbackFunction function);
int InitializeLibrary(char* hiaAssetsPath, char* writableDataPath, enum LogLevel logLevel, enum AppBrand appBrand);
void callback (int value)
{
    printf("value: %i\n", value);
}

void initialize(void)
{
    set_native_callback (&callback);
}


void consumeCSharp(void)
{
    int a = Add(8,9);
    char* result = SumString("Mihir", "Das");

    GCHandle handle = StructReturn();
    UpdateFirstName(handle, "Rahul");
    initialize();
    InitializeLibrary("path", "path2", Info, MyStarkey);
    NSLog(@"Sum: %d result: %s", a, result);
}
int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
//    char *path = strdup ([[[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"Frameworks"] UTF8String]);
//    setenv ("DOTNET_LIBRARY_ASSEMBLY_PATH", path, 1);
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
    }
    
    // SayHello();
     //SumCall();
    consumeCSharp();
    //InitializeLibrary("path", "path2", Info, MyStarkey);
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}

