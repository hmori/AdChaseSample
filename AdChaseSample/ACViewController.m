//
//  ACViewController.m
//  AdChaseSample
//
//  Created by Hidetoshi Mori on 12/10/02.
//  Copyright (c) 2012年 Hidetoshi Mori. All rights reserved.
//

#import "ACViewController.h"
#import <iAd/iAd.h>

@interface ACViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet ADBannerView *bannerView;
@property CGPoint adjustOffset;
- (void)resetOffsetBannerView:(UIScrollView *)scrollView;
- (CGFloat)offsetYBannerView;
@end

@implementation ACViewController
@synthesize adjustOffset = _adjustOffset;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL *url = [NSURL URLWithString:@"http://d.hatena.ne.jp/h_mori"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    self.webView.scrollView.delegate = self;
    self.bannerView.backgroundColor = [UIColor blueColor]; // for debug
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat newOffsetY = [self offsetYBannerView] + self.adjustOffset.y - scrollView.contentOffset.y;
    self.bannerView.frame = CGRectMake(self.bannerView.frame.origin.x,
                                       newOffsetY,
                                       self.bannerView.frame.size.width,
                                       self.bannerView.frame.size.height);
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
	if(!decelerate) {
        [self resetOffsetBannerView:scrollView];
	}
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self resetOffsetBannerView:scrollView];
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
    [self resetOffsetBannerView:scrollView];
}

#pragma mark - Private methods

- (void)resetOffsetBannerView:(UIScrollView *)scrollView {
    if (scrollView) {
        self.adjustOffset = scrollView.contentOffset;
    }
    self.bannerView.frame = CGRectMake(self.bannerView.frame.origin.x,
                                       [self offsetYBannerView],
                                       self.bannerView.frame.size.width,
                                       self.bannerView.frame.size.height);
}

- (CGFloat)offsetYBannerView {
    CGRect screen = [[UIScreen mainScreen] applicationFrame];
    return (screen.size.height - self.bannerView.frame.size.height);
}

@end
