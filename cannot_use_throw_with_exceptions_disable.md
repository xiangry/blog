[cannot use 'throw' with exceptions disabled](http://zengrong.net/post/2168.htm)

在为 [DragonBonesCPP/refactoring][1] 的 cocos2d-x-3.2 demo 增加 Android 编译时，NDK 报了一个编译错误：

>error: cannot use 'throw' with exceptions disabled
>throw std::invalid_argument("Invalid data.");

这是由于 DragonBonesCPP 库使用了 C++ 标准异常，而 Android NDK 编译器默认不支持 C++ 异常控制导致。

但是，从Android NDK r5 版本开始，NDK 就开始支持 C++ 异常控制了，我的版本是 r9d ，为什么还会出现这个错误呢？

原来，NDK 编译器的 C++ 异常控制特性支持默认是关闭的。要打开它，可以这样做：<!--more-->

编辑 Android.mk 文件，加入下面的代码：

    LOCAL_CPP_FEATURES += exceptions

或者：

    LOCAL_CPPFLAGS += -fexceptions

这样可以对当前项目开启 C++ 异常控制编译支持。

如果想偷懒，也可以编辑 Application.mk 文件，加入下面的代码：

    APP_CPPFLAGS += -fexceptions

这样，所有模块的 C++ 异常控制编译支持都会被打开。

上面的两个 mk 文件位于 `proj.android/jni` 文件夹中。

参考文章：

* [解决NDK出现error: exception handling disabled, use -fexceptions to enable的问题][1]
* [Enable Exception C++][2]

[1]: https://github.com/DragonBones/DragonBonesCPP/tree/refactoring
[2]: http://stackoverflow.com/questions/3217925/enable-exception-c
