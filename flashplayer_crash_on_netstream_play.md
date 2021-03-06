[FlashPlayer在执行NetStream.play的时候崩溃的解决办法](http://zengrong.net/post/1390.htm)

这是个隐藏非常深的BUG，我都怀疑如果再做一次，我能不能把它找出来。它耗费了我宝贵的三天时间，三天啊……

##BUG表现

在使用NetStream连接FMS发布的流时，在执行NetStream.play('streamName')方法时，FlashPlayer会崩溃。独立版、调试版以及基于浏览器的插件版均如此。

但是，这还不是全部。必须满足以下几点，该BUG才会出现。

* 使用Windows 7操作系统。也就是说，Windows XP不会出现这个问题；
* 播放的必须是RTMP流，RTMP流可以由[Flash Media Server](http://www.adobe.com/products/flashmediaserver/)或者[Red5](http://www.red5.org/)来发布。也就是说，使用NetStream播放本地的flv/f4v/mp4视频不会出现这个问题；
* 播放的流包含音频。也就是说，如果该流只包含视频，不会出现这个问题；
* 播放的流中包含的音频声音较大。也就是说，即使该流包含音频，但如果发布方没有发出声音，或者发出的声音很小，该问题不会出现；当然，不需要很大的声音就能让播放端立即崩溃；
* 使用了Frame标签来做预加载。不了解Frame标签预加载的，看这篇文章：[Preloaders in AS3](http://www.bit-101.com/blog/?p=946);
* 在预加载完毕之后，使用removeChild移除了预加载类的实例（**BUG就在这里**）。

##开发和测试平台(出现BUG的平台)

* Flex SDK 4.5.1
* Flash Media Server 4.0
* Flash Player 10.3独立版/调试版/插件版
* Windows 7 旗舰版
* Chrome12/Opera11.5/Firefox5/IE9


##BUG再现

我写了两个简单的Demo（一个发布端，一个接收端）来重现这个BUG。Demo需要FMS的支持。

错误的重点在于预加载类(PreloaderNSPlay.as)。由于预加载类在完成加载后就不再需要，一般的处理方法是将其从Stage中移除。只要将移除，就会出现这个BUG（并非移除后立即出现，而是在接收音频流的视频出现）。而如果使用visible将预加载类隐藏，就不会出现这个问题。

Demo的使用方法（服务端以FMS为例）：

1. 安装FMS，在安装目录下建立 `/applications/testspeed/` 文件夹；
2. 编译NSPulish和NSPlay，或者[在这里直接下载](https://github.com/zrong/blog/tree/master/flashplayer_crash_on_netstream_play/project/bin)；
3. 确认本机安装了摄像头和麦克风，运行NSPublish.swf，单击“连接”按钮，查看log信息确定连接正常，见下图：
![发布流](flashplayer_crash_on_netstream_play/img/nspub.png)
4. 运行NSPlay.swf，单击“连接”按钮，查看log信息确认连接正常。此时会看到发布端的摄像头视频。如果FlashPlaye没有崩溃的话，就向着麦克风吹口气……呼……整个世界清静了……
![播放流](flashplayer_crash_on_netstream_play/img/nsplay.png)

下面只贴出了 `PreloaderNSPlay.as` 的源码，需要整个项目源码可以在这里下载：<https://github.com/zrong/blog/tree/master/flashplayer_crash_on_netstream_play/project>

<pre lang="actionscript" line="1" colla="+" file="PreloaderNSPlay.as">
package
{
import flash.display.MovieClip;
import flash.display.DisplayObject;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.events.ProgressEvent;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.utils.getDefinitionByName;

public class PreloaderNSPlay extends MovieClip 
{
	public function PreloaderNSPlay()
	{
		_mainClassName = 'NSPlay';
		stage.scaleMode = StageScaleMode.NO_SCALE;
		stage.align = StageAlign.TOP_LEFT;
		stage.showDefaultContextMenu = false;
		_tf = new TextField();
		_tf.defaultTextFormat = new TextFormat(null,12,0,null,null,null,null,null,"center");
		_tf.mouseEnabled = false;
		_tf.height = 20;
		_tf.x = (stage.stageWidth-_tf.width)*.5;
		_tf.y = stage.stageHeight*.5;
		this.addChild(_tf);

		this.loaderInfo.addEventListener(ProgressEvent.PROGRESS,progress);
		this.loaderInfo.addEventListener(Event.COMPLETE,complete);
	}

	protected var _tf:TextField;
	protected var _mainClassName:String;
	
	private function progress(e:ProgressEvent):void
	{
		_tf.text = int(e.bytesLoaded/e.bytesTotal*100)+"% 载入中……";
	}

	private function complete(e:Event):void
	{
		gotoAndStop(2);
		var mainClass:Class = Class(getDefinitionByName(_mainClassName));
		stage.addChild(new mainClass() as DisplayObject);
		destroy();
	}

	private function destroy():void
	{
		this.loaderInfo.removeEventListener(ProgressEvent.PROGRESS,progress);
		this.loaderInfo.removeEventListener(Event.COMPLETE,complete);
		//将预加载类从舞台移除(parent.removeChild也一样，因为parent就是舞台），就会导致Flash Player崩溃
		stage.removeChild(this);
		//parent.removeChild(this);

		//如果只移除显示进度的文本，或者只将自身隐藏而不移除，就不会出现这个Bug
		//this.removeChild(_tf);
		//this.visible = false;
	}
}
}
</pre>
