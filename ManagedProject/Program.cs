using System;
using System.Globalization;
using System.Runtime.InteropServices;
using System.Timers;

namespace ManagedProject
{
	public class MyPerson(string fName, string lName)
    {
    	public string first = fName;
    	public string last = lName;

        public void UpdateFirstName(string fName) 
		{
			this.first = fName;
		}
		public void UpdateLastName(string lName) 
		{
			this.last = lName;
		}
		
		public void PrintName() 
		{
			Console.WriteLine($" {first} : { last }");
		}
	}


public enum AppBrand: byte
{
    Thrive,
    KIND,
    ProAkustik,
    MyStarkey,
    MyAudibel
}

public enum LogLevel: byte
{
    None = 0,
    Error,
    Warning,
    Info,
    Debug
}

    class HiaLibrary
    {
		

		  [UnmanagedCallersOnly(EntryPoint = "InitializeLibrary")]
    	public static int InitializeLibrary(IntPtr hiaAssetsPath, IntPtr writableDataPath, LogLevel logLevel, AppBrand appBrand)
    	{
        var hiaPath = Marshal.PtrToStringAnsi(hiaAssetsPath);
        var writePath = Marshal.PtrToStringAnsi(writableDataPath);

        Console.WriteLine($" hiaAssetsPath: {hiaPath},  {writePath} {logLevel}, {appBrand} ");
        return 1;
    	}
		[UnmanagedCallersOnly(EntryPoint = nameof(SayHello))]
		public static void SayHello()
		{
			Console.WriteLine($"Called from native!  Hello!");
			try
			{
				throw new NullReferenceException("Null pointer Exception");
			}
			catch (System.Exception)
			{
				Console.WriteLine("Caught null pointer");
				throw;
			}
		}

		[UnmanagedCallersOnly(EntryPoint = nameof(Add))]
        public static int Add(int a, int b)
        {
            return a + b;
        }

		[UnmanagedCallersOnly(EntryPoint = nameof(SumString))]
		public static IntPtr SumString(IntPtr path1, IntPtr path2) 
		{
			string str1 = Marshal.PtrToStringAnsi(path1);
			string str2 = Marshal.PtrToStringAnsi(path2);
			
			Console.WriteLine($"String1 { str1 }");
			Console.WriteLine($"String2 { str2 }");

			string sum = str1 + " " + str2;

			Console.WriteLine($"Sum string { sum }");
			IntPtr sumPointer = Marshal.StringToCoTaskMemAnsi(sum);
			return sumPointer;

		}

		[UnmanagedCallersOnly(EntryPoint = nameof(UpdateFirstName))]
		public static void UpdateFirstName(IntPtr obj, IntPtr firstName) 
		{
			string fName = Marshal.PtrToStringAnsi(firstName);
			var person = (MyPerson) GCHandle.FromIntPtr (obj).Target;
			person.UpdateFirstName(fName);
			person.PrintName();
		}

		[UnmanagedCallersOnly(EntryPoint = nameof(StructReturn))]
		public static IntPtr StructReturn() 
		{
			var obj = new MyPerson("Mihir", "Das");
			return GCHandle.ToIntPtr (GCHandle.Alloc (obj));
		}

		[UnmanagedFunctionPointer(CallingConvention.ThisCall)]
		delegate void FunctionCallback(int a);

		static FunctionCallback functionCallback;
		[UnmanagedCallersOnly (EntryPoint = "set_native_callback")]
		static void SetNativeCallback (IntPtr functionPointer)
		{
			Console.WriteLine($"set_native_callback called: {functionPointer}");
			functionCallback = Marshal.GetDelegateForFunctionPointer<FunctionCallback> (functionPointer);
			StartTimer();
		}
		static System.Timers.Timer timer;
		private static void StartTimer() 
		{
			// Create a timer with a two second interval.
    			timer = new System.Timers.Timer(2000);
    // Hook up the Elapsed event for the timer. 
    			timer.Elapsed += OnTimedEvent;
    			timer.AutoReset = true;
    			timer.Enabled = true;
		}

		private static void OnTimedEvent(Object source, ElapsedEventArgs e)
		{
    		Console.WriteLine("The Elapsed event was raised at {0:HH:mm:ss.fff}", e.SignalTime);
			NotifyNativeCode(2);
		}

		public static void NotifyNativeCode (int value)
		{
			functionCallback (value);
		}

		public static void Main(string[] args)
		{

		}
	}

        
}
