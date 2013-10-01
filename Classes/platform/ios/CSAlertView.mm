//
//  CSAlertView.m
//  nozomi
//
//  Created by  stc on 13-8-27.
//
//

#import "CSAlertView.h"

#import "CCDirector.h"
#import "support/user_default/CCUserDefault.h"

@implementation CSAlertView

- (id)initWithTitle:(NSString *)title content:(NSString *)content button1:(int)button1 button1Text:(NSString *)button1Text button2:(int)button2 button2Text:(NSString *)button2Text
{
    if(self = [super init]){
        button[0] = button1;
        button[1] = button2;
        UIAlertView* alertView;
        
        [self retain];
        if(button2>0){
            alertView = [[UIAlertView alloc] initWithTitle:title message:content delegate:self cancelButtonTitle:button1Text otherButtonTitles:button2Text,nil];
        }
        else{
            alertView = [[UIAlertView alloc] initWithTitle:title message:content delegate:self cancelButtonTitle:button1Text otherButtonTitles:nil];
        }
        [alertView show];
        [alertView release];
    }
    return self;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    int type = button[buttonIndex];
    if (type==2){
        cocos2d::CCDirector::sharedDirector()->end();
        exit(0);
    }
    else if(type==3){
        NSString* url = [NSString stringWithUTF8String:cocos2d::CCUserDefault::sharedUserDefault()->getStringForKey("versionUpdateUrl").c_str()];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
        cocos2d::CCDirector::sharedDirector()->end();
        exit(0);
    }
    [self release];
}

@end
