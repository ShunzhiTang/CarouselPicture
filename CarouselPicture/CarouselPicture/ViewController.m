//  ViewController.m
//  CarouselPicture
//  Created by Tsz on 15/11/20.
//  Copyright © 2015年 Tsz. All rights reserved.

#import "ViewController.h"
#import "AdvertisementBanner_3D.h"

  //定义图片的数量
static NSUInteger imageCount =  6;

//ID
static NSString * const ID = @"cell";

@interface ViewController () <UIScrollViewDelegate , UITableViewDataSource , UITableViewDelegate ,ClickImgDelegate>
{
    UIImageView *_imageView;
    int _currentIndex;
}

@property (nonatomic ,strong)NSTimer *timer;

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@property (weak, nonatomic) IBOutlet UIScrollView *scrollerView;

@property (weak, nonatomic) IBOutlet UIPageControl *pageController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.scrollerView.delegate  = self;
    self.tableView.delegate  = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
    
    //添加定时器s
    
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(addCurrentTimer) object:nil];
    
    [thread start];
    //显示 图片
    [self setupImageView];
    
    //显示3D
    [self set3DAdvertisement];
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


#pragma mark: 实现3D的广告
- (void)set3DAdvertisement{
     AdvertisementBanner_3D *Banner_View = [[AdvertisementBanner_3D alloc]initWithFrame:CGRectMake(0, 300, self.view.frame.size.width, 180)];
    
    Banner_View.delegate = self;
    [Banner_View show3DBannerView];
    [self.view addSubview:Banner_View];
}

//点击了第几张图片
- (void)ClickImg:(int)index{
    NSLog(@"点击了第%d张",index);
}

#pragma mark: UIScrollViewDelegate 代理方法

//滚动就会调用 UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    //根据scroller 的offset 属性计算页数
    CGPoint offset = scrollView.contentOffset;
    
    CGFloat scrollerW = scrollView.frame.size.width;
    
    int page = (offset.x  +  scrollerW * 0.5) / scrollerW;
    
    self.pageController.currentPage = page;
    
}

//开始拖拽注销 定时器
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    // 使无效
    [self.timer invalidate];
    
    self.timer = nil;
}

//当我 拖拽完成后要重新开启这个定时器
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    
    [self addCurrentTimer];
}


- (void)nextImage{
    //当前的page
    
    NSInteger page = self.pageController.currentPage;
    
    //最后一页
    if(page == self.pageController.numberOfPages -1){
        page = 0;
    }else{
        page++;
    }
    
    //设置image的位置
    CGFloat offset = page * self.scrollerView.frame.size.width;
    
    //进行滚动
    [self.scrollerView setContentOffset:CGPointMake(offset, 0) animated:YES];
}

//添加控制器
- (void)addCurrentTimer{
    //添加定时器
    self.timer  = [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];

    
    //加入主运行循环
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

#pragma mark: 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return  40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)   indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    cell.textLabel.text = @"1";
    
    return cell;
}


@end
