[在quick-cocos2d-x中对非2的幂纹理进行平铺操作](http://zengrong.net/post/2054.htm)

tile use NPOT texture in quick-cocos2d-x

本文基于 [quick 2.2.1rc][1] 版本

在 quick 的 framework.display 包中，有这样一个方法实现图片的平铺：<!--more-->

<pre lang="lua">
function display.newTilesSprite(filename, rect)
    if not rect then
        rect = CCRect(0, 0, display.width, display.height)
    end
    local sprite = CCSprite:create(filename, rect)
    if not sprite then
        echoError("display.newTilesSprite() - create sprite failure, filename %s", tostring(filename))
        return
    end

    local tp = ccTexParams()
    tp.minFilter = 9729
    tp.magFilter = 9729
    tp.wrapS = 10497
    tp.wrapT = 10497
    sprite:getTexture():setTexParameters(tp)
    CCSpriteExtend.extend(sprite)

    display.align(sprite, display.LEFT_BOTTOM, 0, 0)

    return sprite
end
</pre>

这里直接通过调整 OpenGL ES 的纹理渲染参数来实现平铺，性能相当好。

但使用这个方法有个限制，就是被平铺的纹理必须是2的幂(POT, Power Of Two)。

于是，我尝试使用 CCSpriteBatchNode 来对纹理进行平铺，达到不用2的幂(NPOT）的纹理即可进行平铺的目的。

但是这个方法也有一个问题。当对这个 CCSpriteBatchNode 进行缩放的时候，平铺的纹理之间会出现非常细的空隙，导致最终看起来的效果像是栅栏一样，无法实现无缝平铺的效果。

这种缩放并不一定需要主动进行。假设你的游戏做了多分辨率处理（在如今的世界，这是不可避免的），在不同的设备分辨率中，cocos2d-x 会根据分辨率进行缩放处理。 这种情况下也会出现这个问题。

一个可行的办法，是制作平铺图的时候，在图像边缘留1个像素的重复像素。在拼接的时候，将两个相邻的纹理互相覆盖1个像素。

我把这个功能封装成了 display.newTiledBatchNode 方法：

<pre lang="lua">
-- 创建一个可平铺的 CCSpriteBatchNode，纹理的大小可以是非2的幂
-- @param __fileName 与 display.newSprite 的第一个参数相同
-- @param __texture plist文件，因为使用了BatchNode，必须传递plist文件
-- @param __size 一个CCSize对象
-- @param __hPadding 横向覆盖几个像素
-- @param __vPadding 纵向覆盖几个像素
-- @return a CCSpriteBatchNode

function display.newTiledBatchNode(__fileName, __texture, __size, __hPadding, __vPadding)
	__size = __size or cc.size(display.width, display.height)
	__hPadding = __hPadding or 0
	__vPadding = __vPadding or 0
	local __sprite = display.newSprite(__fileName)
	local __sliceSize = __sprite:getContentSize()
	__sliceSize.width = __sliceSize.width - __hPadding
	__sliceSize.height = __sliceSize.height - __vPadding
	local __xRepeat = math.ceil(__size.width/__sliceSize.width)
	local __yRepeat = math.ceil(__size.height/__sliceSize.height)
	-- how maney sprites we need to fill in tiled node?
	local __capacity = __xRepeat * __yRepeat
	local __batch = display.newBatchNode(__texture, __capacity)
	local __newSize = cc.size(0,0)
	--printf("newTileNode xRepeat:%u, yRepeat:%u", __xRepeat, __yRepeat)
	for y=0,__yRepeat-1 do
		for x=0,__xRepeat-1 do
			__newSize.width = __newSize.width + __sliceSize.width
			__sprite = display.newSprite(__fileName)
				:align(display.LEFT_BOTTOM,x*__sliceSize.width, y*__sliceSize.height)
				:addTo(__batch)
				--print("newTileNode:", x*__sliceSize.width, y*__sliceSize.height)
		end
		__newSize.height = __newSize.height + __sliceSize.height
	end
	__batch:setContentSize(__newSize)
	return __batch, __newSize.width, __newSize.height
end
</pre>

这个方法已经加入了 quick 官方仓库的 develop 分支。

但是，这个方法无法处理这样的情景——平铺带有透明度的纹理。

[1]: https://github.com/dualface/quick-cocos2d-x/tree/2.2.1-rc
