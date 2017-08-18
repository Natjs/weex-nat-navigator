//
//  NatNavigator.m
//
//  Created by Huangyake on 17/2/18.
//  Copyright (c) 2017 Instapp. All rights reserved.
//

#import "WeexNatNavigator.h"


@implementation WeexNatNavigator
@synthesize weexInstance;
WX_EXPORT_METHOD(@selector(push::))
WX_EXPORT_METHOD(@selector(pop::))
WX_EXPORT_METHOD(@selector(setTitle::))
WX_EXPORT_METHOD(@selector(setColor::))
WX_EXPORT_METHOD(@selector(setBackgroundColor::))
WX_EXPORT_METHOD(@selector(setFontSize::))
WX_EXPORT_METHOD(@selector(init::))
WX_EXPORT_METHOD(@selector(hide:))
WX_EXPORT_METHOD(@selector(show:))


- (void)push:(NSDictionary *)params :(WXModuleCallback)callback{
    
    
    NSString *urlStr = params[@"url"];
     NSString *title;
    if (params[@"title"]) {
        title = params[@"title"];
    }else{
        title = @"";
    }
     BOOL animated;
    if (params[@"animated"]) {
        animated = [params[@"animated"] boolValue];
    }else{
        animated = YES;
    }
    
    NSString *color;
    if (!params[@"color"]) {
        color = @"#ffffff";
    }else{
        color = params[@"color"];
    }
    
    UIViewController *vc = [self getCurrentVC];
    UINavigationController *nav;
    if ([vc isKindOfClass:[UINavigationController class]]) {
        nav = (UINavigationController *)vc;
    }else{
        nav = vc.navigationController;
    }
    WXBaseViewController *baseVC = [[WXBaseViewController alloc]initWithSourceURL:[NSURL URLWithString:urlStr]];
    baseVC.title = title;
    baseVC.view.backgroundColor = [WeexNatNavigator UIColor:color];
    [nav pushViewController:baseVC animated:animated];
    
}
- (void)pop:(NSDictionary *)params :(WXModuleCallback)callback{
    UIViewController *vc = [self getCurrentVC];
    UINavigationController *nav;
    BOOL animated;
    if ([vc isKindOfClass:[UINavigationController class]]) {
        nav = (UINavigationController *)vc;
    }else{
        nav = vc.navigationController;
    }
    if (params[@"animated"]) {
        animated = [params[@"animated"] boolValue];
    }else{
        animated = YES;
    }
    [nav popViewControllerAnimated:animated];
}
- (void)setTitle:(NSDictionary *)params :(WXModuleCallback)callback{
    UIViewController *vc = [self getCurrentVC];
//    UINavigationController *nav;
    if ([vc isKindOfClass:[UINavigationController class]]) {
        vc = [[(UINavigationController *)vc viewControllers] lastObject];
    }
    
    NSString *title;
    if (params[@"title"]) {
        title = params[@"title"];
    }else{
        title = @"";
    }

    vc.title = title;
}
- (void)setColor:(NSDictionary *)params :(WXModuleCallback)callback{
    UIViewController *vc = [self getCurrentVC];
    UINavigationController *nav;
    if ([vc isKindOfClass:[UINavigationController class]]) {
        nav = (UINavigationController *)vc ;
    }else{
        nav = vc.navigationController;
    }
    if (params[@"color"]) {
        NSMutableDictionary *titleAtt = nav.navigationBar.titleTextAttributes.mutableCopy;
        [titleAtt setValue:[WeexNatNavigator UIColor:params[@"color"]] forKey:NSForegroundColorAttributeName];
        [nav.navigationBar setTitleTextAttributes:titleAtt];
    }
    
    
}
- (void)setBackgroundColor:(NSDictionary *)params :(WXModuleCallback)callback{
    UIViewController *vc = [self getCurrentVC];
    UIViewController *nextVC;
    if ([vc isKindOfClass:[UINavigationController class]]) {
        nextVC = [[(UINavigationController *)vc viewControllers] lastObject];
    }else{
        nextVC = vc;
    }
    if (params[@"color"]) {
        [nextVC.navigationController.navigationBar setBarTintColor:[WeexNatNavigator UIColor:params[@"color"]]];
    }
}

- (void)setFontSize:(NSDictionary *)params :(WXModuleCallback)callback{
    UIViewController *vc = [self getCurrentVC];
    UINavigationController *nav;
    if ([vc isKindOfClass:[UINavigationController class]]) {
        nav = (UINavigationController *)vc ;
    }else{
        nav = vc.navigationController;
    }
    if (params[@"fontSize"]) {
        NSMutableDictionary *titleAtt = nav.navigationBar.titleTextAttributes.mutableCopy;
        [titleAtt setValue:[UIFont systemFontOfSize:[params[@"fontSize"] floatValue]] forKey:NSFontAttributeName];
        [nav.navigationBar setTitleTextAttributes:titleAtt];
    }
    
}
- (void)init:(NSDictionary *)params :(WXModuleCallback)callback{
    UIViewController *vc = [self getCurrentVC];
    UINavigationController *nav;
    if ([vc isKindOfClass:[UINavigationController class]]) {
        nav = (UINavigationController *)vc;
        vc = [nav.viewControllers lastObject];
    }else{
        nav = vc.navigationController;
    }

    
    if (params[@"color"] && params[@"fontSize"]) {
//        [[UINavigationBar appearance] setTitleTextAttributes:@{
//                                                               NSForegroundColorAttributeName:[WXConvert UIColor:params[@"color"]]}];
        
        [nav.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:[params[@"fontSize"] integerValue]],NSForegroundColorAttributeName:[WXConvert UIColor:params[@"color"]]}];
    }else if (params[@"color"]){
        [nav.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[WXConvert UIColor:params[@"color"]]}];
    }else if (params[@"fontSize"]){
        [nav.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:[params[@"fontSize"] integerValue]]}];
    }
    
    if (params[@"backgroundColor"]) {
//        [UINavigationBar appearance].barTintColor = [WeexNatNavigator UIColor:params[@"backgroundColor"]];
        nav.navigationBar.barTintColor = [WeexNatNavigator UIColor:params[@"backgroundColor"]];
    }
    
    if (params[@"backIcon"]) {
        UIImage *image = [WeexNatNavigator getImageFromURL:params[@"backIcon"]];
        [UINavigationBar appearance].backIndicatorTransitionMaskImage = image;
        [UINavigationBar appearance].backIndicatorImage = image;
    }
    
    if (params[@"showBackTitle"]) {
        if (![params[@"showBackTitle"] boolValue]) {
            [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                                 forBarMetrics:UIBarMetricsDefault];
        }
    }
    
}
- (void)hide:(WXModuleCallback)callback{
    UIViewController *vc = [self getCurrentVC];
    UINavigationController *nav;
    if ([vc isKindOfClass:[UINavigationController class]]) {
        nav = (UINavigationController *)vc;
    }else{
        nav = vc.navigationController;
    }
    [nav setNavigationBarHidden:YES];
}
- (void)show:(WXModuleCallback)callback{
    UIViewController *vc = [self getCurrentVC];
    UINavigationController *nav;
    if ([vc isKindOfClass:[UINavigationController class]]) {
        nav = (UINavigationController *)vc;
    }else{
        nav = vc.navigationController;
    }
    [nav setNavigationBarHidden:NO];
}


- (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

+ (UIImage *) getImageFromURL:(NSString *)fileURL
{
    UIImage * result;
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    result = [UIImage imageWithData:data];
    return result;
}


+ (UIColor *)UIColor:(id)value
{
    // 1. check cache
    static NSCache *colorCache;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        colorCache = [[NSCache alloc] init];
        colorCache.countLimit = 64;
    });
    
    if ([value isKindOfClass:[NSNull class]] || !value) {
        return nil;
    }
    
    UIColor *color = [colorCache objectForKey:value];
    if (color) {
        return color;
    }
    
    // Default color is white
    double red = 255, green = 255, blue = 255, alpha = 1.0;
    
    if([value isKindOfClass:[NSString class]]){
        // 2. check if is color keyword or transparent
        static NSDictionary *knownColors;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            knownColors = @{
                            // https://www.w3.org/TR/css3-color/#svg-color
                            @"aliceblue": @"#f0f8ff",
                            @"antiquewhite": @"#faebd7",
                            @"aqua": @"#00ffff",
                            @"aquamarine": @"#7fffd4",
                            @"azure": @"#f0ffff",
                            @"beige": @"#f5f5dc",
                            @"bisque": @"#ffe4c4",
                            @"black": @"#000000",
                            @"blanchedalmond": @"#ffebcd",
                            @"blue": @"#0000ff",
                            @"blueviolet": @"#8a2be2",
                            @"brown": @"#a52a2a",
                            @"burlywood": @"#deb887",
                            @"cadetblue": @"#5f9ea0",
                            @"chartreuse": @"#7fff00",
                            @"chocolate": @"#d2691e",
                            @"coral": @"#ff7f50",
                            @"cornflowerblue": @"#6495ed",
                            @"cornsilk": @"#fff8dc",
                            @"crimson": @"#dc143c",
                            @"cyan": @"#00ffff",
                            @"darkblue": @"#00008b",
                            @"darkcyan": @"#008b8b",
                            @"darkgoldenrod": @"#b8860b",
                            @"darkgray": @"#a9a9a9",
                            @"darkgrey": @"#a9a9a9",
                            @"darkgreen": @"#006400",
                            @"darkkhaki": @"#bdb76b",
                            @"darkmagenta": @"#8b008b",
                            @"darkolivegreen": @"#556b2f",
                            @"darkorange": @"#ff8c00",
                            @"darkorchid": @"#9932cc",
                            @"darkred": @"#8b0000",
                            @"darksalmon": @"#e9967a",
                            @"darkseagreen": @"#8fbc8f",
                            @"darkslateblue": @"#483d8b",
                            @"darkslategray": @"#2f4f4f",
                            @"darkslategrey": @"#2f4f4f",
                            @"darkturquoise": @"#00ced1",
                            @"darkviolet": @"#9400d3",
                            @"deeppink": @"#ff1493",
                            @"deepskyblue": @"#00bfff",
                            @"dimgray": @"#696969",
                            @"dimgrey": @"#696969",
                            @"dodgerblue": @"#1e90ff",
                            @"firebrick": @"#b22222",
                            @"floralwhite": @"#fffaf0",
                            @"forestgreen": @"#228b22",
                            @"fuchsia": @"#ff00ff",
                            @"gainsboro": @"#dcdcdc",
                            @"ghostwhite": @"#f8f8ff",
                            @"gold": @"#ffd700",
                            @"goldenrod": @"#daa520",
                            @"gray": @"#808080",
                            @"grey": @"#808080",
                            @"green": @"#008000",
                            @"greenyellow": @"#adff2f",
                            @"honeydew": @"#f0fff0",
                            @"hotpink": @"#ff69b4",
                            @"indianred": @"#cd5c5c",
                            @"indigo": @"#4b0082",
                            @"ivory": @"#fffff0",
                            @"khaki": @"#f0e68c",
                            @"lavender": @"#e6e6fa",
                            @"lavenderblush": @"#fff0f5",
                            @"lawngreen": @"#7cfc00",
                            @"lemonchiffon": @"#fffacd",
                            @"lightblue": @"#add8e6",
                            @"lightcoral": @"#f08080",
                            @"lightcyan": @"#e0ffff",
                            @"lightgoldenrodyellow": @"#fafad2",
                            @"lightgray": @"#d3d3d3",
                            @"lightgrey": @"#d3d3d3",
                            @"lightgreen": @"#90ee90",
                            @"lightpink": @"#ffb6c1",
                            @"lightsalmon": @"#ffa07a",
                            @"lightseagreen": @"#20b2aa",
                            @"lightskyblue": @"#87cefa",
                            @"lightslategray": @"#778899",
                            @"lightslategrey": @"#778899",
                            @"lightsteelblue": @"#b0c4de",
                            @"lightyellow": @"#ffffe0",
                            @"lime": @"#00ff00",
                            @"limegreen": @"#32cd32",
                            @"linen": @"#faf0e6",
                            @"magenta": @"#ff00ff",
                            @"maroon": @"#800000",
                            @"mediumaquamarine": @"#66cdaa",
                            @"mediumblue": @"#0000cd",
                            @"mediumorchid": @"#ba55d3",
                            @"mediumpurple": @"#9370db",
                            @"mediumseagreen": @"#3cb371",
                            @"mediumslateblue": @"#7b68ee",
                            @"mediumspringgreen": @"#00fa9a",
                            @"mediumturquoise": @"#48d1cc",
                            @"mediumvioletred": @"#c71585",
                            @"midnightblue": @"#191970",
                            @"mintcream": @"#f5fffa",
                            @"mistyrose": @"#ffe4e1",
                            @"moccasin": @"#ffe4b5",
                            @"navajowhite": @"#ffdead",
                            @"navy": @"#000080",
                            @"oldlace": @"#fdf5e6",
                            @"olive": @"#808000",
                            @"olivedrab": @"#6b8e23",
                            @"orange": @"#ffa500",
                            @"orangered": @"#ff4500",
                            @"orchid": @"#da70d6",
                            @"palegoldenrod": @"#eee8aa",
                            @"palegreen": @"#98fb98",
                            @"paleturquoise": @"#afeeee",
                            @"palevioletred": @"#db7093",
                            @"papayawhip": @"#ffefd5",
                            @"peachpuff": @"#ffdab9",
                            @"peru": @"#cd853f",
                            @"pink": @"#ffc0cb",
                            @"plum": @"#dda0dd",
                            @"powderblue": @"#b0e0e6",
                            @"purple": @"#800080",
                            @"rebeccapurple": @"#663399",
                            @"red": @"#ff0000",
                            @"rosybrown": @"#bc8f8f",
                            @"royalblue": @"#4169e1",
                            @"saddlebrown": @"#8b4513",
                            @"salmon": @"#fa8072",
                            @"sandybrown": @"#f4a460",
                            @"seagreen": @"#2e8b57",
                            @"seashell": @"#fff5ee",
                            @"sienna": @"#a0522d",
                            @"silver": @"#c0c0c0",
                            @"skyblue": @"#87ceeb",
                            @"slateblue": @"#6a5acd",
                            @"slategray": @"#708090",
                            @"slategrey": @"#708090",
                            @"snow": @"#fffafa",
                            @"springgreen": @"#00ff7f",
                            @"steelblue": @"#4682b4",
                            @"tan": @"#d2b48c",
                            @"teal": @"#008080",
                            @"thistle": @"#d8bfd8",
                            @"tomato": @"#ff6347",
                            @"turquoise": @"#40e0d0",
                            @"violet": @"#ee82ee",
                            @"wheat": @"#f5deb3",
                            @"white": @"#ffffff",
                            @"whitesmoke": @"#f5f5f5",
                            @"yellow": @"#ffff00",
                            @"yellowgreen": @"#9acd32",
                            
                            // https://www.w3.org/TR/css3-color/#transparent
                            @"transparent": @"rgba(0,0,0,0)",
                            };
        });
        NSString *rgba = knownColors[value];
        if (!rgba) {
            rgba = value;
        }
        
        if ([rgba hasPrefix:@"#"]) {
            // #fff
            if ([rgba length] == 4) {
                unichar f =   [rgba characterAtIndex:1];
                unichar s =   [rgba characterAtIndex:2];
                unichar t =   [rgba characterAtIndex:3];
                rgba = [NSString stringWithFormat:@"#%C%C%C%C%C%C", f, f, s, s, t, t];
            }
            
            // 3. #rrggbb
            uint32_t colorValue = 0;
            sscanf(rgba.UTF8String, "#%x", &colorValue);
            red     = ((colorValue & 0xFF0000) >> 16) / 255.0;
            green   = ((colorValue & 0x00FF00) >> 8) / 255.0;
            blue    = (colorValue & 0x0000FF) / 255.0;
        } else if ([rgba hasPrefix:@"rgb("]) {
            // 4. rgb(r,g,b)
            int r,g,b;
            sscanf(rgba.UTF8String, "rgb(%d,%d,%d)", &r, &g, &b);
            red = r / 255.0;
            green = g / 255.0;
            blue = b / 255.0;
        } else if ([rgba hasPrefix:@"rgba("]) {
            // 5. rgba(r,g,b,a)
            int r,g,b;
            sscanf(rgba.UTF8String, "rgba(%d,%d,%d,%lf)", &r, &g, &b, &alpha);
            red = r / 255.0;
            green = g / 255.0;
            blue = b / 255.0;
        }
        
    } else if([value isKindOfClass:[NSNumber class]]) {
        NSUInteger colorValue = [value unsignedIntegerValue];
        red     = ((colorValue & 0xFF0000) >> 16) / 255.0;
        green   = ((colorValue & 0x00FF00) >> 8) / 255.0;
        blue    = (colorValue & 0x0000FF) / 255.0;
    }
    
    color = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    // 6. cache color
    if (color && value) {
        [colorCache setObject:color forKey:value];
    }
    
    return color;
}

@end
