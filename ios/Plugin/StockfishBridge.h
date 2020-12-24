#import <Foundation/Foundation.h>
#import "StockfishSendOutput.h"

@interface StockfishBridge : NSObject
    - (void) start;
    - (void) cmd: (NSString*)command;
    - (void) exit;
@end
