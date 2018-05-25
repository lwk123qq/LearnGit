//
//
//

#import "LEEMessageNumTipView.h"

@implementation UIView (lwk_Extension)
#pragma mark - frame
- (void)setX:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setY:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)x {
    return self.frame.origin.x;
}

- (CGFloat)y {
    return self.frame.origin.y;
}

- (void)setCenterX:(CGFloat)centerX {
    
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
    
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)origin {
    return self.frame.origin;
}
- (CGFloat)top {
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)top {
    CGRect frame = self.frame;
    frame.origin.y = top;
    self.frame = frame;
}

- (CGFloat)left {
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)left {
    CGRect frame = self.frame;
    frame.origin.x = left;
    self.frame = frame;
}


- (CGFloat)bottom {
    return self.frame.size.height + self.frame.origin.y;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)right {
    return self.frame.size.width + self.frame.origin.x;
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}
@end


@interface ERIMMessageNumberModel()
/// 字符串长度
@property (nonatomic ,assign) CGFloat width;
@end

@implementation ERIMMessageNumberModel

-(NSString *)imageName
{
    if (!_imageName) {
        _imageName = @"IM_UpLogo";
    }
    return _imageName;
}

-(UIColor *)textColor
{
    if (!_textColor) {
        return HEXCOLOR(0xF4571E);
    }
    return _textColor;
}

- (UIFont *)textFont
{
    if (!_textFont) {
        return FontSize(12);
    }
    return _textFont;
}

- (UIColor *)backGroundColor
{
    if (_backGroundColor == nil) {
        return [UIColor whiteColor];
    }
    return _backGroundColor;
}

-(CGFloat)duration
{
    if (_duration == 0) {
        return 0.7;
    }
    return _duration;
}

-(UIView *)superView
{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    if (_superView) {
        return _superView;
    }
    return keyWindow;
}

-(CGFloat)height
{
    if (_height == 0) {
        return 36;
    }
    return _height;
}

-(CGFloat)width
{
    if (_width == 0 && [_message isEqualToString:@""]) {
        return 100;
    }else
    {
        // 根据字符串大小计算label的大小
        if (_message) {
            UILabel *tempLab = [UILabel new];
            tempLab.font = _textFont;
            tempLab.text = _message;
            [tempLab sizeToFit];
            return tempLab.width;
        }
        return _width;
    }
}

-(CGFloat)locationY
{
    ///默认Y轴位置
    if (_locationY == 0 ) {
        return ScreenHeight/2;
    }
    return _locationY;
}
@end

const CGFloat logoImageViewWidth = 10;

///label左右边界
const CGFloat space = 4;

@interface LEEMessageNumTipView()
{
    ///初始化X 回弹位置
    CGFloat _initializeX;
    
    CGFloat _locationY;
    CGFloat _width;
    CGFloat _height;
    
    UIFont *_textFont;
    UIColor *_textColor;
    
    NSString *_imageName;
    
    ///动画时长
    CGFloat _duration;
    ///keep状态标识 一半|完全显示
    bool    _isShow;
    
    
    ERIMMessageNumberViewLocationTpye _locationType;
    ERIMMessageNumberViewShowType _showType;
    NSString *_titleStr;
}
@property (nonatomic ,strong) UIButton *centerButton;
@property (nonatomic ,strong) UILabel *titleLabel;
@property (nonatomic ,strong) UIImageView *logoImageView;

@end

@implementation LEEMessageNumTipView

+ (LEEMessageNumTipView *)showWithModel:(ERIMMessageNumberModel *)model
                            buttonAction:(ButtonClickBlock)block;
{
    LEEMessageNumTipView *tempView = [[LEEMessageNumTipView alloc]initWithModel:model buttonAction:block];
    return tempView;
}

- (instancetype)initWithModel:(ERIMMessageNumberModel *)model
                 buttonAction:(ButtonClickBlock)block;

{
        self = [super init];
        if (self) {

            _titleStr = model.message;
            _locationType = model.locationType;
            _showType = model.showType;
            _locationY = model.locationY;
            _textFont = model.textFont;
            _textColor = model.textColor;
            _width = model.width;
            _height = model.height;
            _duration = model.duration;
            _imageName = model.imageName;
            self.buttonAction = block;
            self.backgroundColor = model.backGroundColor;
            [model.superView addSubview:self];

            self.width = model.width + logoImageViewWidth/*logoWidth*/ + model.height/2/*圆角半径*/ + space/*image与lable*/ + space/*label 与边界*/;
            
            [self addSubview:self.logoImageView];
            [self addSubview:self.titleLabel];
            [self addSubview:self.centerButton];
            //实际上只需要设置大小
            ///重新调整宽度以后要重新调整相对距离
            [self reAdjustFrame:model];

        }
        return self;
}

-(void)reAdjustFrame:(ERIMMessageNumberModel *)model
{

    [self drawCor];
    
    self.centerButton.frame = CGRectMake(0, 0, self.frame.size.width, model.height);
    switch (_locationType) {
        case ERIMMessageNumberViewLocationLeftType:
        {
            CGRect tempRect1;
            tempRect1.origin.x = self.frame.size.width - model.height/2 - logoImageViewWidth;
            tempRect1.origin.y = 0;
            tempRect1.size.width = logoImageViewWidth;
            tempRect1.size.height = logoImageViewWidth;
            self.logoImageView.frame = tempRect1;
            self.logoImageView.centerY = model.height/2 ;
            
            CGRect tempRect2;
            tempRect2.origin.x = self.logoImageView.x - space - model.width;
            tempRect2.origin.y = 0;
            tempRect2.size.width = model.width;
            tempRect2.size.height = model.height;
            self.titleLabel.frame = tempRect2;
            
        }
            break;
        case ERIMMessageNumberViewLocationRightType:
        {
            self.logoImageView.frame = CGRectMake(model.height/2/*圆角半径*/, 0, logoImageViewWidth, logoImageViewWidth);
            self.logoImageView.centerY = model.height/2 ;
            self.titleLabel.frame = CGRectMake(self.logoImageView.right + space, 0, model.width, model.height);
        }
            break;
            
        default:
            break;
    }
}

///初始化位置 画圆角
- (void)drawCor
{
    switch (_locationType) {
        case ERIMMessageNumberViewLocationLeftType:
        {
            CGRect tempRect;
            tempRect.origin.x = - _width;
            tempRect.origin.y = _locationY;
            tempRect.size.width = self.width;
            tempRect.size.height = _height;
            self.frame = tempRect;
            [self addRoundedCorners:UIRectCornerTopRight|UIRectCornerBottomRight withRadii:CGSizeMake(_height/2, _height/2)];
            
        }
            break;
        case ERIMMessageNumberViewLocationRightType:
        {
            CGRect tempRect;
            tempRect.origin.x = kScreenWidth + _width;
            tempRect.origin.y = _locationY;
            tempRect.size.width = self.width;
            tempRect.size.height = _height;
            self.frame = tempRect;
            [self addRoundedCorners:UIRectCornerTopLeft|UIRectCornerBottomLeft withRadii:CGSizeMake(_height/2, _height/2)];
        }
            break;
        default:
            break;
    }
}

#pragma mark - Getter
-(UIButton *)centerButton
{
    if (!_centerButton) {
        _centerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _centerButton.frame = CGRectMake(0, 0, self.size.width, self.size.height);
        [_centerButton addTarget:self action:@selector(centerButtonButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _centerButton;
}

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = _titleStr;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = _textFont;
        _titleLabel.textColor = _textColor;
        _titleLabel.backgroundColor = [UIColor clearColor];
    }
    return _titleLabel;
}

-(UIImageView *)logoImageView
{
    if (!_logoImageView) {
        UIImage *logoImage = [UIImage imageNamed:_imageName];
        _logoImageView = [[UIImageView alloc]initWithImage:logoImage];
        _logoImageView.userInteractionEnabled = NO;
    }
    return _logoImageView;
}

#pragma mak - Action
- (void)centerButtonButtonClick:(id)sender
{
    if (self.buttonAction) {
        self.buttonAction(self);
    }
}

#pragma mark - Method
- (void)show
{
    switch (_locationType) {
        case ERIMMessageNumberViewLocationLeftType:
        {
            [UIView animateWithDuration:_duration animations:^{
                self.origin = CGPointMake(0, self.y);
            }];
        }
            break;
        case ERIMMessageNumberViewLocationRightType:
        {
            [UIView animateWithDuration:_duration animations:^{
                self.origin = CGPointMake(kScreenWidth - self.width, self.y);
            }];
        }
            break;
            
        default:
            break;
    }
    _initializeX = self.x;

}

- (void)disMiss
{
    switch (_locationType) {
        case ERIMMessageNumberViewLocationLeftType:
        {
            switch (_showType) {
                case ERIMMessageNumberViewTypeKeep:
                {
                    [self left_keepTypeAnimate];
                }
                    break;
                case ERIMMessageNumberViewTypeHiden:
                {
                    [self left_HidenTypeAnimate];
                }
                    
                default:
                    break;
            }
        }
            break;
        case ERIMMessageNumberViewLocationRightType:
        {
            switch (_showType) {
                case ERIMMessageNumberViewTypeKeep:
                {
                    [self right_keepTypeAnimate];
                }
                    break;
                case ERIMMessageNumberViewTypeHiden:
                {
                    [self right_HidenTypeAnimate];
                }
                default:
                    break;
            }
        }
            break;
            
        default:
            break;
    }

}


#pragma mark - animate
///回弹
- (void)reset
{
    [UIView animateWithDuration:_duration animations:^{
        self.x = self->_initializeX;
    }];
}

- (void)right_keepTypeAnimate
{
    if (!_isShow) {
        [UIView animateWithDuration:_duration animations:^{
            self.origin = CGPointMake(kScreenWidth - self.logoImageView.width - 4 , self.y);
        }];
    }else
    {
        [self reset];
    }
    _isShow = !_isShow;
}

- (void)right_HidenTypeAnimate
{
    [UIView animateWithDuration:_duration animations:^{
        self.origin = CGPointMake(kScreenWidth, self.y);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)left_keepTypeAnimate
{
    if (!_isShow) {
        [UIView animateWithDuration:_duration animations:^{
            self.origin = CGPointMake(- (self.width - self.logoImageView.width - 4), self.y);
        }];
    }else
    {
        [self reset];
    }
    _isShow = !_isShow;
}

- (void)left_HidenTypeAnimate
{
    [UIView animateWithDuration:_duration animations:^{
        self.origin = CGPointMake(- self.width, self.y);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - 设置部分圆角
/**
 *  设置部分圆角(绝对布局)
 *
 *  @param corners 需要设置为圆角的角 UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerAllCorners
 *  @param radii   需要设置的圆角大小 例如 CGSizeMake(20.0f, 20.0f)
 */
- (void)addRoundedCorners:(UIRectCorner)corners
                withRadii:(CGSize)radii {
    
    UIBezierPath* rounded = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:radii];
    CAShapeLayer* shape = [[CAShapeLayer alloc] init];
    [shape setPath:rounded.CGPath];
    
    self.layer.mask = shape;
}
@end


















