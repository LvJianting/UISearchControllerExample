//
//  UIAppearance+Swift.m
//  UISearchController
//
//  Created by 吕建廷 on 16/7/3.
//  Copyright © 2016年 吕建廷. All rights reserved.
//

#import "UIAppearance+Swift.h"

@implementation UIBarButtonItem (UIBarButtonItemAppearance_Swift)
+ (instancetype)my_appearanceWhenContainedIn:(Class<UIAppearanceContainer>)containerClass {
    return [self appearanceWhenContainedIn: containerClass, nil];
}
@end
