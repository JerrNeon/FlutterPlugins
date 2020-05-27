#package开发
https://flutter.cn/docs/development/packages-and-plugins/developing-packages

#创建纯 Dart 库的 package
flutter create --template=package plugin_name

#创建原生插件 package
#使用 --org 选项，以反向域名表示法来指定你的组织。该值用于生成的 Android 及 iOS 代码。
#使用 -a 选项指定 Android 的语言，或使用 -i 选项指定 iOS 的语言。不指定默认Android为kotlin，IOS为swift
flutter create --org com.example --template=plugin plugin_name
flutter create --org com.example --template=plugin -a kotlin plugin_name
flutter create --org com.example --template=plugin -a java plugin_name
flutter create --org com.example --template=plugin -i objc plugin_name
flutter create --org com.example --template=plugin -i swift plugin_name