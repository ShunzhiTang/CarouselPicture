//
//  3DAdvertisementBanner.h
//  CarouselPicture
//
//  Created by Tsz on 15/11/20.
//  Copyright © 2015年 Tsz. All rights reserved.
//

#import <UIKit/UIKit.h>
#define MainScreenH [UIScreen mainScreen].bounds.size.height
#define MainScreenW [UIScreen mainScreen].bounds.size.width

@protocol ClickImgDelegate

-(void)ClickImg:(int)index;

@end

@interface AdvertisementBanner_3D : UIView

@property (nonatomic, assign)int currentIndex;//当前图片的下标

@property (nonatomic, strong)UIImageView *imageView;//图片

@property (nonatomic, strong)NSArray *imageArr;//图片数组

@property (assign, nonatomic) id <ClickImgDelegate> delegate;

- (void)show3DBannerView;


@end
