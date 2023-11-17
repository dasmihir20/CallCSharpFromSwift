//
//  CSharpConsume.m
//  NAtiveC#
//
//  Created by Mihir Das on 10/11/23.
//
#import <Foundation/Foundation.h>
#import "CSharpConsume.h"


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
    char *path = strdup ([[[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"Frameworks"] UTF8String]);
    setenv ("DOTNET_LIBRARY_ASSEMBLY_PATH", path, 1);
    //int a = Add(8,9);
   // char* result = SumString("Mihir", "Das");

   // GCHandle handle = StructReturn();
   // UpdateFirstName(handle, "Rahul");
   // initialize();
    InitializeLibrary("path", "path2", Info, MyStarkey);
    //NSLog(@"Sum: %d result: %s", a, result);
}

