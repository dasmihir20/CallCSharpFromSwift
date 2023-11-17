//
//  CSharpConsume.h
//  NAtiveC#
//
//  Created by Mihir Das on 10/11/23.
//

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
void consumeCSharp(void);
