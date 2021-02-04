#import <Foundation/Foundation.h>
#import <Capacitor/Capacitor.h>
#import "StockfishSendOutput.h"

@class Stockfish;

@interface StockfishBridge : NSObject

@property(strong, nonatomic) Stockfish *plugin;

+ (NSString*) getCPUType;

- (instancetype)initWithPlugin:(Stockfish *)plugin;

- (void) start;
- (void) cmd: (NSString*)command;
- (void) exit;


@end
