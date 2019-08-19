## Compiling v8

1. Install depot_tools
2. `fetch v8`
3. `git checkout` to the latest v8 `lkgr` version which can be compiled to a static library
4. `build/install-build-deps-android.sh`
5. Add `target_os = ['android']` into `.gclient`
6. `gclient sync`
7. cd `v8`
8. `tools/dev/v8gen.py arm.release`
9. `gn args out.gn/arm.release`
10. `ninja -C out.gn/arm.release v8_monolith`

For step `9.` provide options:

```
is_debug = false
target_os = "android"
target_cpu = "arm64"
v8_target_cpu = "arm64"
is_component_build = false
v8_enable_i18n_support = false
symbol_level = 0
v8_use_external_startup_data = false
v8_monolithic = true
v8_use_snapshot=true
v8_static_library=true
use_debug_fission=false
is_clang = true
use_custom_libcxx_for_host=false
use_custom_libcxx=false
v8_enable_lite_mode=false
```

Generated `libv8_monolith.a` file copy to the `jni/libs/arm64-v8a` folder.

Repeat steps 9. and 10. for other targets: `arm`, `x86`, `x64`.

Copy v8 `include` folder into `jni`.

To build `libneft.so` file use `ndk-build` from `v8/third_party` inside the `src/main/jni` folder: `v8/third_party/android_tools/ndk/ndk-build`.

In case, the `libv8_monolith.a` file doesn't work, you can try to build one manually using `ar -rcsD`: `ar -rcsD libv8_monolith.a ~/v8/out.gn/arm.release/obj/v8_base_without_compiler/*.o`.
