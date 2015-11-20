//  ViewController.m
//  CarouselPicture
//  Created by Tsz on 15/11/20.
//  Copyright © 2015年 Tsz. All rights reserved.

#import "ViewController.h"

  //定义图片的数量
static NSUInteger imageCount =  6;

@interface ViewController () <UIScrollViewDelegate>



@property (weak, nonatomic) IBOutlet UIScrollView *scrollerView;

@property (weak, nonatomic) IBOutlet UIPageControl *pageController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.scrollerView.delegate  = self;
    //
    [self setupImageView];
}

//加载的时间传入图片「」

- (void)setupImageView{
    
    //计算图片的frame
    CGFloat imageW = self.view.frame.size.width;
    CGFloat imageH = 130;
    
    CGFloat imageY = 0;
    for ( int i = 0; i < imageCount; i++) {
        //创建 imageView
       UIImageView *imageView =  [[UIImageView alloc] init];
        
        NSString *imageName = [NSString stringWithFormat:@"%d.jpg" , i];
        imageView.image = [UIImage imageNamed:imageName];
        CGFloat  imageX = i * imageW;
        
        imageView.frame = CGRectMake(imageX , imageY, imageW, imageH) ;
        [self.scrollerView addSubview:imageView];
    }
    
    //一定要设置 UIScrollView
    self.scrollerView.contentSize = CGSizeMake(imageCount * imageW, 0);
    
    //隐藏滚动条
    self.scrollerView.showsHorizontalScrollIndicator = NO;
    
    //分页
    self.scrollerView.pagingEnabled = YES;
    
}

//滚动就会调用

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    //根据scroller 的offset 属性计算页数
    CGPoint offset = scrollView.contentOffset;
    
    CGFloat scrollerW = scrollView.frame.size.width;
    
    int page = (offset.x  +  scrollerW * 0.5) / scrollerW;
    
    self.pageController.currentPage = page;
    
    
}


@end
