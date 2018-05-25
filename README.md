# LearnGit



# 创建代码：
    #ERIMMessageNumberModel *model = [ERIMMessageNumberModel new];
    model.message = @"00000回弹消失";
    model.textFont = FontSize(30);
    model.locationY = 150;
    model.locationType = ERIMMessageNumberViewLocationRightType;
    model.showType = ERIMMessageNumberViewTypeHiden;
    model.superView = self.view;
    [[LEEMessageNumTipView showWithModel:model buttonAction:^(LEEMessageNumTipView *numberView) {
    [numberView disMiss];
    }]show];


  
  # 聊天中消息数量提示   
      #通过model进行配置(空值为默认配置)
      #字符长度自动匹配
      #字符前logo传图片名即可(默认大小10*10)
      
      
![效果图](https://github.com/lwk123qq/LearnGit/blob/master/效果图.png)

