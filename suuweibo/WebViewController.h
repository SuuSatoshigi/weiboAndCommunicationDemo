//
//  WebViewController.h
//  suuweibo
//
//  Created by suusatoshigii on 15-5-27.
//  Copyright (c) 2015年 weihaoxu. All rights reserved.
//

#import "BaseViewController.h"

@interface WebViewController : BaseViewController <UIWebViewDelegate>{
    NSString *_urlString;
}
@property (retain, nonatomic) IBOutlet UIWebView *webaView;

- (IBAction)goBack:(id)sender;
- (IBAction)reload:(id)sender;
- (IBAction)goForward:(id)sender;


- (id)initWithUrl:(NSString *)url;
@end
