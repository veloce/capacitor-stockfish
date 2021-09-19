#import <Foundation/Foundation.h>
#import <Capacitor/Capacitor.h>
#import "StockfishSendOutput.h"

@class StockfishVariants;

@interface StockfishBridge : NSObject

@property(strong, nonatomic) StockfishVariants *plugin;

+ (NSString*) getCPUType;

- (instancetype)initWithPlugin:(StockfishVariants *)plugin;

- (void) start;
- (void) cmd: (NSString*)command;
- (void) exit;


@end
