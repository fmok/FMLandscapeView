# FMLandscapeView

<br>

便于集成的 横向拖动的视图控件，两种弹性停靠效果

<br>

<br>

## 基本效果如下：

<br>

![](https://github.com/fmok/FMLandscapeView/raw/master/ScreenShots/1.png)
![](https://github.com/fmok/FMLandscapeView/raw/master/ScreenShots/2.png)

<br>

## 集成方法：

<br>

<br>

1、将 LandscapeView 添加到工程中

<br>

<br>

2、实例化时，调用如下配置方法。注意：如果在你的VC上，随着数据的变动，需要控制视图的显隐的话，需要调用
[_landscapeView configueImgHeight:H_JMAuthorCell imgWidth:H_JMAuthorCell*2 Gap:GAP_JMAuthorCell] 更新配置

<br>

![](https://github.com/fmok/FMLandscapeView/raw/master/ScreenShots/5.png)

<br>

3、实现代理方法

<br>

![](https://github.com/fmok/FMLandscapeView/raw/master/ScreenShots/3.png)

<br>

4、自定义cell模板，在代理方法中添加即可

<br>

![](https://github.com/fmok/FMLandscapeView/raw/master/ScreenShots/4.png)





