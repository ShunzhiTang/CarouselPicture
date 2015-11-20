//  main.m
//  指针和数组
//  Created by Tsz on 15/11/20.
//  Copyright © 2015年 Tsz. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        int array[5] = {11,22,33,44,55};
        
        char *p = (char *)(&array + 1);  // array
        
         NSLog(@" &array  = %p" , (&array));
        
        NSLog(@" &array + 1 = %p" , (&array + 1));
        
         NSLog(@"p = %p" ,p);
        
        NSLog(@"%d", *(int *)(p - 1));
        
          NSLog(@"p - 1 = %p" ,p + 1);
        
//          NSLog(@"p de cha  = %zd" ,p - (p - 1));
        
    }
    return 0;
}
