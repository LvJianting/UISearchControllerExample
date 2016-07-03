//
//  UIAppearance+Swift.h
//  UISearchController
//
//  Created by 吕建廷 on 16/7/3.
//  Copyright © 2016年 吕建廷. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (UIBarButtonItemAppearance_Swift)
/// appearanceWhenContainedIn: is not available in Swift. This fixes that, for supporting IOS8 and earlier
+ (instancetype)my_appearanceWhenContainedIn:(Class<UIAppearanceContainer>)containerClass;
@end
