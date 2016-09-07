# SLAnimations
`Core Animation`是一组非常强大的动画处理API，使用它能做出非常炫丽的动画效果，而且往往是事半功倍。使用它需要先添加`QuartzCore.framework`和引入对应的框架`<QuartzCore/QuartzCore.h>`。

# 使用步骤
1. 初始化一个动画对象(CAAnimation)并设置一些动画相关属性
2. CALayer中很多属性都可以通过CAAnimation实现动画效果，包括：opacity、position、transform、bounds、contents等（可以在API文档中搜索：CALayer Animatable Properties）
3. 添加动画对象到层（CALayer）中，开始执行动画
4. 通过调用CALayer的addAnimation:forKey增加动画到层（CALayer）中，这样就能触发动画了。通过调用removeAnimationForKey可以停止层中的动画
5. Core Animation的动画执行过程都是在后台操作的，不会阻塞主线程

# 属性说明
- duration：动画的持续时间
- repeatCount：重复次数，无限循环可以设置HUGE_VALF或者MAXFLOAT
- repeatDuration：重复时间
- removedOnCompletion：默认为YES，代表动画执行完毕后就从图层上移除，图形会恢复到动画执行前的状态。如果想让图层保持显示动画执行后的状态，那就设置为NO，不过还要设置fillMode为kCAFillModeForwards
- fillMode：决定当前对象在非active时间段的行为。比如动画开始之前或者动画结束之后
- beginTime：可以用来设置动画延迟执行时间，若想延迟2s，就设置为CACurrentMediaTime()+2
- CACurrentMediaTime()为图层的当前时间
- timingFunction：速度控制函数，控制动画运行的节奏
- delegate：动画代理

# CAAnimation动画填充模式
`fillMode`属性值（要想fillMode有效，最好设置removedOnCompletion = NO）
- kCAFillModeRemoved 这个是默认值，也就是说当动画开始前和动画结束后，动画对layer都没有影响，动画结束后，layer会恢复到之前的状态
- kCAFillModeForwards 当动画结束后，layer会一直保持着动画最后的状态 
- kCAFillModeBackwards 在动画开始前，只需要将动画加入了一个layer，layer便立即进入动画的初始状态并等待动画开始。
- kCAFillModeBoth 这个其实就是上面两个的合成.动画加入后开始之前，layer便处于动画初始状态，动画结束后layer保持动画最后的状态











