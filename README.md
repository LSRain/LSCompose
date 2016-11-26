# LSCompose
## 使用说明
### 第三方依赖

```
# pop 动画
pod 'pop'
# YYModel
pod 'YYModel'
```

### 点击屏幕即可调用
```
/* 点击屏幕即可触发pop动画 */
override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
let composeView = LSComposeView()
        
composeView.show(target: self)
    }
```

### 效果
![LSCompose](http://upload-images.jianshu.io/upload_images/2329629-84cef905e61e05e6.gif?imageMogr2/auto-orient/strip)
