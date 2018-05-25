//
//  
//

#import <UIKit/UIKit.h>
#define HEXCOLOR(hex) [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16)) / 255.0 green:((float)((hex & 0xFF00) >> 8)) / 255.0 blue:((float)(hex & 0xFF)) / 255.0 alpha:1]
#define FontSize(size) [UIFont systemFontOfSize:AUTO_PT(size)]
#define BoldFontSize(Size)  ([UIFont fontWithName:@"Helvetica-Bold" size:AUTO_PT(Size)])

#define kScreenWidth  [[UIScreen mainScreen] bounds].size.width //(e.g. 320)
#define kScreenSize   [[UIScreen mainScreen] bounds].size //(e.g. 320,480)
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height
#define ScreenHeight  [[UIScreen mainScreen] bounds].size.height //屏幕高度

#define KPROPOR (kScreenWidth/375.0)
#define AUTO_PT(w) (((float)(w)) * KPROPOR)
#define AUTO_PX(w) (((float)(w))/2.0f * KPROPOR)
#define PX(w) (((float)(w))/2.0f)

///点击后是否停留
typedef NS_ENUM(NSInteger, ERIMMessageNumberViewShowType) {
    ERIMMessageNumberViewTypeKeep = 0,
    ERIMMessageNumberViewTypeHiden = 1
};

///左侧|右侧
typedef NS_ENUM(NSInteger, ERIMMessageNumberViewLocationTpye) {
    ERIMMessageNumberViewLocationRightType = 0,
    ERIMMessageNumberViewLocationLeftType = 1
};

@interface UIView (lwk_Extension)
/**  起点x坐标  */
@property (nonatomic, assign) CGFloat x;
/**  起点y坐标  */
@property (nonatomic, assign) CGFloat y;
/**  中心点x坐标  */
@property (nonatomic, assign) CGFloat centerX;
/**  中心点y坐标  */
@property (nonatomic, assign) CGFloat centerY;
/**  宽度  */
@property (nonatomic, assign) CGFloat width;
/**  高度  */
@property (nonatomic, assign) CGFloat height;
/**  顶部  */
@property (nonatomic, assign) CGFloat top;
/**  底部  */
@property (nonatomic, assign) CGFloat bottom;
/**  左边  */
@property (nonatomic, assign) CGFloat left;
/**  右边  */
@property (nonatomic, assign) CGFloat right;
/**  size  */
@property (nonatomic, assign) CGSize size;
/**  origin */
@property (nonatomic, assign) CGPoint origin;
@end


@interface ERIMMessageNumberModel : NSObject
@property (nonatomic ,copy) NSString *imageName;

@property (nonatomic ,copy) NSString *message;
@property (nonatomic ,strong) UIFont *textFont;
@property (nonatomic ,strong) UIColor *textColor;

///位置类型
@property (nonatomic ,assign) ERIMMessageNumberViewLocationTpye locationType;
///展示类型
@property (nonatomic ,assign) ERIMMessageNumberViewShowType showType;
///动画时长 默认0.7
@property (nonatomic ,assign) CGFloat duration;
///父视图 不设置，默认在window添加
@property (nonatomic ,strong) UIView *superView;

///背景色
@property (nonatomic ,strong) UIColor *backGroundColor;
///自身高度
@property (nonatomic ,assign) CGFloat height;
///位置
@property (nonatomic ,assign) CGFloat locationY;
@end

@interface LEEMessageNumTipView : UIView

typedef void(^ButtonClickBlock)(LEEMessageNumTipView *numberView);

/**
 消息数量提示
 示例:
 ERIMMessageNumberModel *model = [ERIMMessageNumberModel new];
 model.message = @"test";
 model.locationY = 250;
 model.locationType = ERIMMessageNumberViewLocationRightType;
 model.showType = ERIMMessageNumberViewTypeHiden;
 [[ERIMMessageNumberView showWithModel:model buttonAction:^(ERIMMessageNumberView *numberView) {
 [numberView disMiss];
 }]show];

 @param model 参数
 @param block 点击事件回调
 @return 自身对象
 */
+ (LEEMessageNumTipView *)showWithModel:(ERIMMessageNumberModel *)model
                            buttonAction:(ButtonClickBlock)block;

@property (nonatomic, copy) ButtonClickBlock buttonAction;
- (void)show;
- (void)disMiss;
@end
