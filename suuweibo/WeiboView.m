//
//  WeiboView.m
//  suuweibo
//
//  Created by suusatoshigi on 15-5-11.
//  Copyright (c) 2015年 weihaoxu. All rights reserved.
//

#import "WeiboView.h"
#import "UIFactory.h"
#import "WeiboModel.h"
#import "UIImageView+WebCache.h"
#import "ThemeImageView.h"
#import "NSString+URLEncoding.h"//处理中文
#import "UIUtils.h"
#define LIST_FONT   14.0f           //列表中文本字体
#define LIST_REPOST_FONT  13.0f;    //列表中转发的文本字体
#define DETAIL_FONT  18.0f          //详情的文本字体
#define DETAIL_REPOST_FONT 17.0f    //详情中转发的文本字体

@implementation WeiboView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self _initView];
        //全局属性的对象不能交给自动释放池管理
        _parseLink = [[NSMutableString string]retain];
    }
    return self;
}

//frame在layout中设置
- (void)_initView {
    //可以用initwithframe,微博内容
    _textLabel = [[RTLabel alloc] init];
    _textLabel.delegate = self;
    _textLabel.font = [UIFont systemFontOfSize:14.0f];
    _textLabel.linkAttributes = [NSDictionary dictionaryWithObject:@"blue" forKey:@"color"];
    _textLabel.selectedLinkAttributes = [NSDictionary dictionaryWithObject:@"darkGray" forKey:@"color"];
    [self addSubview:_textLabel];
//    微博图片
//    _image = [[UIImageView alloc] initWithFrame:CGRectZero];
//    _image.backgroundColor = [UIColor clearColor];
//    _image.image = [UIImage imageNamed:@"page_image_loading.png"];
//    //设置图片的内容显示模式：等比例缩/放（不会被拉伸或压缩）
//    _image.contentMode = UIViewContentModeScaleAspectFit;
//    [self addSubview:_image];

    _image = [[UIImageView alloc] initWithFrame:CGRectZero];
    _image.backgroundColor = [UIColor clearColor];
    _image.image = [UIImage imageNamed:@"clan_img_bottommask_normal.png"];
    [self addSubview:_image];
    
    _repostBackgroundImage = [UIFactory createThemeImageView:@"timeline_retweet_background"];
    //拉伸，在某个点向右拉伸，不改变圆角形状
    UIImage *image = [_repostBackgroundImage.image stretchableImageWithLeftCapWidth:25 topCapHeight:10];
    _repostBackgroundImage.image = image;
    _repostBackgroundImage.backgroundColor = [UIColor clearColor];
    _repostBackgroundImage.leftCapWidth = 25;
    _repostBackgroundImage.topCapHeight = 10;
    //因为是背景，所以应该插入到最下层
    [self insertSubview:_repostBackgroundImage atIndex:0];
}

- (void)setWeiboModel:(WeiboModel *)weiboModel {
    if (_weiboModel != weiboModel) {
        [_weiboModel release];
        _weiboModel = [weiboModel retain];
    }
    
    //创建转发微博视图
    if (_repostView ==nil ) {
        _repostView = [[WeiboView alloc] initWithFrame:CGRectZero];
        _repostView.isRepost = YES;
        _repostView.isDetail = self.isDetail;
        [self addSubview:_repostView];
    }
}

//解析超链接
- (void) parseLink {
    [_parseLink setString:@""];
    if (_isRepost) {
        NSString * nickName = _weiboModel.user.screen_name;
        NSString *enco = [nickName URLEncodedString];
        [_parseLink appendFormat:@"<a href='user://%@'>%@</a>:",enco,nickName];
    }
    
    NSString *text = _weiboModel.text;
    text = [UIUtils parseLink:text];
    
    if (text != nil) {
        [_parseLink appendString:text];
        
    }
    
}

//----------------展示数据，设置布局
//layoutSubviews有可能会被调用多次，[self setneeddisplay]也会调用到｀这里｀
- (void)layoutSubviews {
    [super layoutSubviews];
    
    //获取字体大小
    float fontSize = [WeiboView getFontSize:self.isDetail isRepost:self.isRepost];
    _textLabel.font = [UIFont systemFontOfSize:fontSize];
    [self parseLink];
    _textLabel.text = [NSString stringWithString:_parseLink];
//    NSLog(@"+++++++++%d",_parseLink.length);
    //文本内容尺寸
    CGSize textSize = _textLabel.optimumSize;
    
    
//   -- 子视图微博内容－－
    _textLabel.frame = CGRectMake(0, 0, self.frame.size.width, textSize.height);
    
    //    判断当前微博是否为转发
    if (self.isRepost) {
        _textLabel.frame = CGRectMake(10, 10, self.frame.size.width -20,  textSize.height);
        
    }
    
//----------size和height都是只读的
//    _textLabel.text = _weiboModel.text;
//    //文本内容尺寸
//    CGSize textSize = _textLabel.optimumSize;
//    _textLabel.frame = textSize.height;

    
    
//   -- 转发视图微博内容－－不为空就显示转发视图
    WeiboModel *repostWeibo = _weiboModel.relWeibo;
    if (repostWeibo != nil) {
        _repostView.weiboModel = repostWeibo;
        _repostView.hidden = NO;
       
        float relheight = [WeiboView getWeiboViewHeight:repostWeibo isRepost:YES isDetail:self.isDetail];
        _repostView.frame = CGRectMake(0,  CGRectGetMaxY(_textLabel.frame), self.frame.size.width, relheight);
        
    } else {
        _repostView.hidden = YES;
    }
    //   -- 转发视图微博背景－－
    if (self.isRepost) {
        _repostBackgroundImage.frame = self.bounds;
        _repostBackgroundImage.hidden = NO;
    } else {
        _repostBackgroundImage.hidden = YES;
    }
    
    //   -- 图片视图微博内容－－

    if (self.isDetail) {
        NSString *midPic = _weiboModel.bmiddleImage;
        //如果字符串长的会影响性能
        if (midPic != nil&& ![midPic isEqualToString:@""]) {
            _image.hidden = NO;
            _image.frame = CGRectMake(10, CGRectGetMaxY(_textLabel.frame)+10, 280, 200);
            [_image setImageWithURL:[NSURL URLWithString:midPic]];
        } else {
            _image.hidden = YES;
        }
    } else {
        NSString *picName = _weiboModel.thumbnailImage;
        //如果字符串长的会影响性能
        if (picName != nil&& ![picName isEqualToString:@""]) {
            _image.hidden = NO;
            _image.frame = CGRectMake(10, CGRectGetMaxY(_textLabel.frame)+10, 70, 80);
            [_image setImageWithURL:[NSURL URLWithString:picName]];
        } else {
            _image.hidden = YES;
        }
    }
   
    
    

}

+ (CGFloat)getFontSize:(BOOL)isDetail isRepost:(BOOL)isRepost {
    float fontSize = LIST_FONT;
    
    if (!isDetail && !isRepost) {
        return LIST_FONT;
    } else if (!isDetail && isRepost) {
        return LIST_REPOST_FONT;
    } else if (isDetail && !isRepost) {
        return DETAIL_FONT;
    } else if (isDetail && isRepost) {
        return DETAIL_REPOST_FONT;
    }
    return fontSize;
}


+ (CGFloat)getWeiboViewHeight:(WeiboModel *)weibo isRepost:(BOOL)isRepost isDetail:(BOOL)isdetail{
    /**
     *   实现思路：计算每个子视图的高度，然后相加。
     **/
    float height = 0;
    
    //－－－－－－－－－计算微博内容的高度－－－－－－－
    RTLabel *textLabel = [[RTLabel alloc] initWithFrame:CGRectZero];
    float fontSize = [WeiboView getFontSize:isdetail isRepost:isRepost];
    textLabel.font = [UIFont systemFontOfSize:fontSize];
    
    if (isdetail) {
        textLabel.frame = [SuuUitil setWidth:textLabel.frame sendWidth:kWeibo_Width_Detail];
        // 2. 给这个变量赋值。因为变量都是L-Value，可以被赋值
    } else {
        textLabel.frame = [SuuUitil setWidth:textLabel.frame sendWidth:kWeibo_Width_List];
    }
    textLabel.text = weibo.text;
    height += textLabel.optimumSize.height;
    
    //----------------计算微博图片高度－－－－－－－－－
    if (isdetail) {
        NSString *midPic = weibo.bmiddleImage;
        //如果字符串长的会影响性能
        if (midPic != nil&& ![midPic isEqualToString:@""]) {
            height += (200+10);
        }
    } else {
        NSString *picName = weibo.thumbnailImage;
        //如果字符串长的会影响性能
        if (picName != nil&&![picName isEqualToString:@""]) {
            //加上10的间隙
            height += (80+30);
        }
    }
    
    
    //----------------计算转发微博高度－－－－－－－－－
    WeiboModel *reWeibo = weibo.relWeibo;
    if (reWeibo != nil) {
        //转发微博高度
        float relheight = [WeiboView getWeiboViewHeight:reWeibo isRepost:YES isDetail:isdetail];
        height += relheight;
    }

    if (isRepost) {
        height += 30;
    }
    
    [textLabel release];
    
    
    
    return height;
}

#pragma mark -- delegate
- (void)rtLabel:(id)rtLabel didSelectLinkWithURL:(NSURL*)url {
    NSString *urlString = [url absoluteString];
    if ([urlString hasPrefix:@"user"]) {
        NSString *urlHost = [url host];
        urlHost = [urlHost URLDecodedString];//
        NSLog(@"user:%@",urlHost);
    } else if ([urlString hasPrefix:@"http"]) {
        NSLog(@"connection::%@",url);
    } else if ([urlString hasPrefix:@"topic"]) {
        NSString *urlHost = [url host];
        urlHost = [urlHost URLDecodedString];//
        NSLog(@"topic:%@",urlHost);
    }
}

@end
