[各视频站做到自动切换flash和html5播放器的难度有多大？](http://zengrong.net/post/2155.htm)

The difficulty of change video player from flash to html5.

这是一个知乎上的回答，原文在这里：<http://www.zhihu.com/question/25259832/answer/30319472>

问：

1. 做到根据操作系统、浏览器或者用户自定义来使用不同的播放器是否有难度？
2. 如果有难度，问题点在哪里？
3. 如果不算难，为什么不做？

答：

判断操作系统和浏览器种类和版本，这个不难。

目前的主流平台一共5个：

桌面平台：

* Windows（完美支持H5和 Flash Player）
* Mac OS X（完美支持 H5和 Flash Player）
* Linux（支持 H5，Flash Player支持到11.2，Chrome对 Flash Player 支持更好）

移动平台：

* Android（支持 H5，Adobe已经放弃Flash Player支持）
* iOS（支持 H5， 不支持 Flash Player）

<!--more-->
从上面可以看到，有半数以上的平台（包括已经放弃支持的）支持 Flash Player。既然超过了半数，就有进行切换的需求与可能。

最完美的情况，就是检测操作系统和浏览器版本，根据不同情况进行适配，例如：

* Windows XP 系统，IE6浏览器，使用 Flash Player 来播放视频；
* Mac OS X 系统，使用 H5 来播放视频；
* 移动平台，必须使用 H5 ；
* ……

虽然在前端开发上有一定的成本（例如 Flash Player 和 H5 的界面适配、Desktop 和 Mobile 的界面适配，以及各种浏览器和平台的组合之类的），但也不是不可承受。

让我们来看看 Flash Player 与 H5 以及各个浏览器支持的视频格式吧（下表来自 [HTML5 Video][1] ）：

![HTML5 video][51]

也就是说，在支持 video 标签的 H5 浏览器中，并没有一种视频格式是所有浏览器通吃的。

如果觉得这个表不够详(zhuan)细(ye)的话，还可以看看下面这张图（下表来自 [wikipedia HTML5 video][2] ）：

![HTML5 video][52]


如果抛弃掉可爱又可怜的 Opera ，以及不考虑 Firefox 在 OS X 和 Linux 上的问题，我们确实可以说，MP4格式已经是所有现代浏览器能够直接支持的视频格式（下表来自 [A/V Formats | The State of HTML5 Video Report][3] ）：

![A/V Formats][53]

而实际上，已经有公司在做这件事（而且做了好久），JWPlayer 是一个优秀的 Flash Player 视频播放器，后来开始支持 H5，下面是它的一些介绍：

* [HTML5 Video Player & Flash Video Player][4]
* [HTML5 Video Attributes & Market Share Report][5]

所以，技术上并不是问题。做还是不做，我猜测最大的原因是视频格式转换成本。

这些视频网站已经积累的大量的视频资源，早期基本上是 Flash Only 的 FLV 格式。后期如果继续用Flash Player 来播放视频，为了实现高清的支持，很可能使用的是 MP4 的马甲 F4V 格式。这两种文件格式的标准可以看这里： [F4V/FLV Technology Center][6]。

FLV 格式早期使用过两种编码，分别是 Sorenson Spark 和 On2 VP6 （下表来自 [抛弃FLV，迎接MP4——制作Flash Player支持的H.264视频格式][7]），这两种格式 H5 肯定是不支持的。

![FLV 格式对照表][54]

因此，要将现有的海量视频数据转换成 MP4，需要一个相当的过程，视频网站可能考虑过这个过程比较漫长，就暂时将该工作搁置（或者正在平稳进行中）。

比如，YouTube 就已经把自己的所有视频转向 WebM（这是 Google 推动的视频格式），可以看这里：[YouTube Swiftly Converts Videos in WebM Format][8]

但 Google 毕竟是钞票多到用不完，牛人多到一个团，从标准到产品到实现一条龙的一流公司。对于天朝这些小公司比如 爱X艺优X库马铃薯之类来说，除了技术市场钞票广告之外，还必须考虑国情。

在伟大而神奇的中国，大量的平台依然是Windows XP + IE6 组合，让这些系统升级到 IE8都嫌困难，更别提安装 Chrome 和 Firefox 这种现代浏览器了。针对于它们，Flash Player 是唯一的选择。既然用 Flash Player 来播放视频，那么 FLV 还是 MP4 显然就无所谓了。

不过，一切都会改变的，至少在我们的有生之年，它们是一定会改过来的。

相比用 H5 全平台看视频，我更期待在有生之年登上月球（火星太远就不考虑了）。不过就目前科技的发展速度来看，有点儿悬。

另外吐槽题主3点：

1. 不是所有人都买得起 MBP 的……
2. 发热不能全怪在Flash Player 头上……
3. 就算你一定要怪在 Flash Player 头上，也不要仅仅是怪在视频播放器头上……

[1]: http://www.w3schools.com/html/html5_video.asp
[2]: http://en.wikipedia.org/wiki/HTML5_video
[3]: http://www.jwplayer.com/html5/formats/
[4]: http://www.jwplayer.com/html5-flash/
[5]: http://www.jwplayer.com/html5/
[6]: http://www.adobe.com/devnet/f4v.html
[7]: http://zengrong.net/post/393.htm
[8]: http://www.pcworld.com/article/225685/YouTube_Swiftly_Converts_Videos_in_WebM_Format.html

[51]: /wp-content/uploads/2014/09/htmlvideo1.png
[52]: /wp-content/uploads/2014/09/htmlvideo2.png
[53]: /wp-content/uploads/2014/09/htmlvideo3.png
[54]: /wp-content/uploads/2014/09/flashvideo.png
