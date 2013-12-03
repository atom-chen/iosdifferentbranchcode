//
//  CCNative.mm
//  nozomi
//
//  Created by  stc on 13-5-4.
//
//

#include "platform/CCNative.h"
#include "platform/ios/CSAlertView.h"

#include "support/CCNotificationCenter.h"
#include "support/user_default/CCUserDefault.h"

NS_CC_EXT_BEGIN

void CCNative::openURL(const char *url)
{
    NSString *urlStr = [NSString stringWithUTF8String:url];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
}

void CCNative::sendEmail(const char *receiver, const char *title, const char *message)
{
    NSString* mail = [NSString stringWithUTF8String:receiver];
    NSString* nTitle = [NSString stringWithUTF8String:title];
    NSString* nMessage = [NSString stringWithUTF8String:message];
    NSString* device = [UIDevice currentDevice].model;
    NSString* sys = [UIDevice currentDevice].systemVersion;
    NSString* mailUrl = [NSString stringWithFormat:@"mailto:%@?subject=%@&body=%@\nDevice:%@\nSystem version:%@\n---------------", mail, nTitle, nMessage,device,sys];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[mailUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
}

void CCNative::postNotification(int duration, const char *content)
{
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    if (notification!=nil){
        NSLog(@">> support local notification");
        NSDate *dt = [NSDate new];
        notification.fireDate=[dt dateByAddingTimeInterval:duration];
        [dt release];
        notification.timeZone=[NSTimeZone defaultTimeZone];
        notification.alertBody = [NSString stringWithCString:content encoding:NSUTF8StringEncoding];
        notification.applicationIconBadgeNumber = notification.applicationIconBadgeNumber+1;
        notification.alertAction = @"Ok";
        notification.soundName = UILocalNotificationDefaultSoundName;
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
        [notification autorelease];
    }
}

void CCNative::clearLocalNotification()
{
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}

void CCNative::buyProductIdentifier(const char *productId)
{
}

void CCNative::initStore(CCDictionary* dict)
{
    /*
	NSMutableSet* set = [NSMutableSet setWithCapacity:6];
	CCArray* keys = dict->allKeys();
	CCObject* key;
	CCARRAY_FOREACH(keys, key)
	{
		[set addObject:[NSString stringWithCString:((CCString*)key)->getCString() encoding:NSUTF8StringEncoding]];
	}
	[[IAPHelper sharedHelper] requestProducts:set];
	CCUserDefault* udefault = CCUserDefault::sharedUserDefault();
	udefault->setIntegerForKey("cnum0", 500);
	udefault->setIntegerForKey("cnum1", 1200);
	udefault->setIntegerForKey("cnum2", 2500);
	udefault->setIntegerForKey("cnum3", 6500);
	udefault->setIntegerForKey("cnum4", 14000);
	udefault->setIntegerForKey("cnum5", 200);
     */
}

void CCNative::showAchievements() {
    //[[GCHelper sharedGameCenter] showAchievements];
}
void CCNative::reportAchievement(const char *identifer, float percent) {
    //[[GCHelper sharedGameCenter] reportAchievementIdentifier: [NSString stringWithUTF8String:identifer] percentComplete:percent];
}

void CCNative::showAlert(const char* title, const char* content, int button1, const char* button1Text, int button2, const char* button2Text)
{
    NSString* nsTitle = [NSString stringWithUTF8String:title];
    NSString* nsContent  = [NSString stringWithUTF8String:content];
    NSString* nsButton1Text = [NSString stringWithUTF8String:button1Text];
    NSString* nsButton2Text = [NSString stringWithUTF8String:button2Text];
    [[[CSAlertView alloc] initWithTitle:nsTitle content:nsContent button1:button1 button1Text:nsButton1Text button2:button2 button2Text:nsButton2Text] autorelease];
}

NS_CC_EXT_END