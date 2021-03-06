[让旧版本的Flash支持更新的Flash Player功能](http://zengrong.net/post/1568.htm)

今天在论坛上看到一篇文章：[H264VideoStreamSettings无法在cs4里面使用吗？](http://bbs.9ria.com/viewthread.php?tid=107792)，并做了回复。记录在这里，希望对更多的人有帮助。

H264VideoStreamSettings是Flash Player 11才开始支持的功能，但目前Aodbe发布的最新版的Flash CS5.5，都不支持将Flash Player 11作为目标播放器版本发布。这个问题很容易解决，但涉及到的东西却比较多，我在这里将一一讲解。

首先来个Setp by Step，这里以Flash Player CS5.5为例，但Flash CS4也没有问题（Flash CS3我就不确定了）：<!--more-->

**第一步** 首先下载最新的[playerglobal.swc](http://fpdownload.macromedia.com/pub/flashplayer/updaters/11/playerglobal11_0.swc)（基于Flash Player11）：

**第二步** 将其复制到 `FlashCS5.5\Common\Configuration\ActionScript 3.0\FP11.1`，没有这个文件夹请自行建立；

**第三步** 复制 `FlashCS5.5\Common\Configuration\Players\FlashPlayer10_1.xml` 为 `FlashPlayer11_1.xml`；

**第四步** 用 **NotePad++/EditPlus/UltraEdit** （但不要用windows Notepad，避免换行符问题）之类的软件打开 `FlashPlayer11_1.xml` ，修改以下内容：

第3行修改为：

    <player id="FlashPlayer11.1" version="14" asversion="3">

第4行修改为：

    <name>Flash Player 11.1</name>

第8行修改为：

    <playerDefinitionPath as2="$(UserConfig)/Classes/FP10;$(UserConfig)/Classes/FP9;$(UserConfig)/Classes/FP8;$(UserConfig)/Classes/FP7" as3="$(AppConfig)/ActionScript 3.0/FP11_1/playerglobal.swc" />

这是我修改好的，可以直接用：

<pre lang="XML" file="FlashPlayer11_1.xml" colla="-">
<?xml version="1.0" encoding="UTF-8"?>
<players>
  <player id="FlashPlayer11.1" version="14" asversion="3">
   <name>Flash Player 11.1</name>
   <path builtin="true"/>
   <path platform="WIN">Device Central/adcdl.exe</path>
   <path platform="MAC">Device Central/adcdl</path>
   <playerDefinitionPath as2="$(UserConfig)/Classes/FP10;$(UserConfig)/Classes/FP9;$(UserConfig)/Classes/FP8;$(UserConfig)/Classes/FP7" as3="$(AppConfig)/ActionScript 3.0/FP11_1/playerglobal.swc" />
   <feature name="multiScreenPublish" 		        supported="true" />
   <feature name="mobileAuthoringIntegration"           supported="true" />
   <feature name="deviceSound"             		supported="false"/>
   <feature name="exportStreamingSound"    		supported="true"/>
   <feature name="exportEventSound"        		supported="true"/>
   <feature name="FSCommand2"              		supported="false"/>
   <feature name="gradient_linearRGB" 			supported="true" />
   <feature name="gradient_overflow" 			supported="true" />
   <feature name="shape_strokeHint" 			supported="true" />
   <feature name="shape_cap" 				supported="true" />
   <feature name="shape_join" 				supported="true" />
   <feature name="shape_mitre" 				supported="true" />
   <feature name="shape_scale" 				supported="true" />
   <feature name="linkage_exportForActionscript" 	supported="true" />
   <feature name="linkage_exportForRuntimeSharing" 	supported="true" />
   <feature name="linkage_exportInFirstFrame" 		supported="true" />
   <feature name="linkage_importForRuntimeSharing" 	supported="true" />
   <feature name="linkage_importAndAddToCache" 		supported="false" />
   <feature name="publish_localPlaybackSecurity" 	supported="true" />
   <feature name="publish_hardwareAcceleration" 	supported="true" />
   <feature name="symbol_blendMode" 			supported="true" /> 
   <feature name="actionScript_documentClass" 		supported="true" />
   <feature name="symbol_blendMode" 			supported="true" />
   <feature name="filters" 				supported="true" />
   <feature name="component_binding" 			supported="true" />
   <feature name="component_schema" 			supported="true" />
   <feature name="screens" 				supported="true" />
   <feature name="video" 				supported="true" />
   <feature name="deviceVideo"				supported="false"/>
   <feature name="accessibility" 			supported="true" />
   <feature name="dynamic_text_kerning" 		supported="true" />
   <feature name="static_text_charwidth_nondeviceFont"	supported="true" /> 
   <feature name="static_text_charwidth_deviceFont"	supported="true" />
   <feature name="advanced_anti_alias_text" 		supported="true" /> 
   <feature name="nine_slice_scaling" 			supported="true" />
   <feature name="runtimeNumberMinMax" 			supported="true" />
   <feature name="use8kSampleRate"                      supported="true" />
   <feature name="useDefineFont4ForDeviceText"          supported="true" />
   <feature name="useDefineFont4ForEmbeddedFonts"       supported="true" />
   <feature name="textLayoutFramework"       supported="true" />
   <encodingPresets>
	    <preset uuid="da5cac1a-417a-4d86-b7f7-ef21010a5d7d"  name="FLV - Match Source Attributes (High Quality)" ext="flv" default="true"/>
	</encodingPresets>
   
   <testmenu> 
	<menu name="ID_testInFlash" default="true"/>
	<menu name="ID_testInDeviceCentral" />
   </testmenu>

   <debugmenu>
	<menu name="ID_debugtInFlash" default="true"/> 
	<menu name="ID_debugInDeviceCentral"/> 
  </debugmenu>


   </player>
</players>
</pre>

**第五步** 重新启动Flash CS5.5， 就可以看到新的发布设置生效了，在新建Fla文件的时候选择这个发布设置，就可以支持Flash Player 11.1新增的功能。如下图：

<a href="http://zengrong.net/wp-content/uploads/2012/03/flash_publish.png"><img src="http://zengrong.net/wp-content/uploads/2012/03/flash_publish.png" alt="" title="flash_publish" width="567" height="488" class="aligncenter size-full wp-image-1569" /></a>

**第六步** 为了能够播放和调试新生成的Flash Player 11文件，还需要更新DebugFlashPlayer，在这里下载：<http://www.adobe.com/support/flashplayer/downloads.html>。注意必须下载Debug版本：Windows Flash Player 11.1 Projector content debugger。如果不知道这些版本之间的区别，可以看看我写的这篇文章：[有史以来关于Flash Player的最详细说明](http://zengrong.net/post/1188.htm)。

**第七步** 下载了上面的文件后，将其复制到 `FlashCS5.5\Adobe Flash CS5.5\Players\Debug`，替换原来的FlashPlayerDebugger.exe。

**下面是原理讲解（Flash IDE代指Flash CS4/CS5/CS5.5）：**

在Flash 8时代，编译器和Flash Player是完全同步的。因为那时，只有Flash IDE可以生成swf文件。而Flex问世，以及MacroMedia被Adobe收购以后，Flash的发展就变得多样了，FlashIDE和Flex都可以生成swf文件，Flash Player的发展也更加独立。现在的情况，Flash CS，Flash Builder，Flex SDK，Flash Player的发布已经完全不同步了。尤其是当Adobe将Flex SDK交给Apache发展后，SDK的更新速度估计会更快。Adobe自己又会紧紧将Flash Player攥在手里，保持自己的步调来更新。

Flex SDK/Flash IDE可以和不同版本的Flash Player相配。即使是使用Flex SDK 3.6/Flash CS4，同样也可以开发出Flash Player 11.1支持的swf程序。通过使用不同版本Flash Player提供的playerglobal.swc文件，就可以让旧的Flex SDK/Flash IDE兼容新的Flash Player提供的功能，方法就是修改编译属性中的-swf-version和 -target-player编译属性。当然，也可以让新的Flex SDK兼容旧的Flash Player功能。

以上这段来自我写的这篇文章：[Flex编译器参数中-swf-version与-target-player之关系](http://zengrong.net/post/1486.htm)，有修改。

