#import <Foundation/Foundation.h>
#import <Capacitor/Capacitor.h>
#import "StockfishSendOutput.h"

@interface StockfishBridge : NSObject

@property(strong, nonatomic) CAPPlugin *plugin;

+ (NSString*) getCPUType;

- (instancetype)initWithPlugin:(CAPPlugin *)plugin;

- (void) start;
- (void) cmd: (NSString*)command;
- (void) exit;


@end
