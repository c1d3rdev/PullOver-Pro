//
//  IPC.h
//  MessageHub
//
//  Created by Will Smillie on 1/19/19.
//

#import <Foundation/Foundation.h>
#import <rocketbootstrap/rocketbootstrap.h>

@interface CPDistributedMessagingCenter
+ (instancetype)centerNamed:(NSString *)name;
-(void)runServerOnCurrentThread;
- (BOOL)sendMessageName:(NSString *)messageName userInfo:(NSDictionary *)userInfo;
- (NSDictionary *)sendMessageAndReceiveReplyName:(NSString *)messageName userInfo:(NSDictionary *)userInfo;
- (NSDictionary *)sendMessageAndReceiveReplyName:(NSString *)messageName userInfo:(NSDictionary *)userInfo error:(NSError **)error;
-(void)registerForMessageName:(id)arg1 target:(id)arg2 selector:(SEL)arg3 ;
@end

@interface NSConcreteNotification
-(id)name;
-(id)userInfo;
-(id)object;
@end

@interface NSDistributedNotificationCenter
+ (id)defaultCenter;
- (void)postNotificationName:(id)arg1 object:(id)arg2 userInfo:(id)arg3;
@end
