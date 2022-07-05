// Import dart:ffi.
import 'dart:ffi' as ffi;
import 'dart:io' show Platform;

// Utilities for working with ffi like String

// Create a typedef with the FFI type signature of the C function.
// Commonly used types defined by dart:ffi library include Double, Int32, NativeFunction, Pointer, Struct, Uint8, and Void.
typedef play_once_func = ffi.Void Function();

// Create a typedef for the variable that you’ll use when calling the C function.
typedef PlayOnce = void Function();

main() {
  late ffi.DynamicLibrary dylib;
  // Open the dynamic library that contains the C function.
  if (Platform.isMacOS) {
    dylib = ffi.DynamicLibrary.open("target/debug/libplay_once.dylib");
  }

  if (Platform.isWindows) {
    dylib = ffi.DynamicLibrary.open("target/debug/libplay_once.dll");
  }

  if (Platform.isLinux) {
    dylib = ffi.DynamicLibrary.open("target/debug/libplay_once.so");
  }

  // Get a reference to the C function, and put it into a variable. This code uses the typedefs defined in steps 2 and 3, along with the dynamic library variable from step 4.
  final PlayOnce playOnce = dylib
      .lookup<ffi.NativeFunction<play_once_func>>('play_once')
      .asFunction();

  // Convert a Dart [String] to a Utf8-encoded null-terminated C string.
  //final ffi.Pointer<Utf8> song = ffi.Utf8.("data/beep.wav");

  // Call the C function.
  playOnce();
}
