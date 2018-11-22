# wechat可以和Python这样玩

如今微信已成为我们日常生活的主要交流工具，但是微信自身的功能有时候可能并不能满足我们的需要，因此我会会想是否可以进行微信功能的拓展呢，比如群发、定时发送等功能。

而现在，有了itchat库，这些功能我们都可以利用它进行实现。废话不多说，接下来我们正式开始讲解如何使用这个库。

## 搭建环境

一个好的环境至关重要。我这里使用的是最流行的pipenv来创建一个隔离的python环境

```
pipenv shell
```

安装itchat库：

```
pipenv install itchat
```

## 编写脚本

```python
# 作者: me

import itchat
import time

def qunfa():
    itchat.auto_login(hotReload=True)
    friendList = itchat.get_friends(update=True)[1:]
    
    SINCERE_WISH = u'祝%s发大财！'
    
    for friend in friendList:
        itchat.send(SINCERE_WISH % (friend['DisplayName'] or friend['NickName'],friend['UserName'])
        time.sleep(5)
    
    print('----end----')

if __name__ == '__main__':
    qunfa()
```

## 结语

*大爷，不来试一下？*