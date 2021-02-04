#include <string>
#include <sys/types.h>
#include <sys/sysctl.h>
#include <mach/machine.h>
#import <Capacitor/CAPPlugin.h>
#import <CapacitorStockfish/CapacitorStockfish-Swift.h>
#import "StockfishBridge.h"
#import "Stockfish.hpp"

@implementation StockfishBridge

- (instancetype)initWithPlugin:(Stockfish *)plugin {
    self = [super init];
    if (self) {
        _plugin = plugin;
    }
    return self;
}

- (void) start {
    CapacitorStockfish::init((__bridge void*)self);
}

- (void) cmd: (NSString*)command {
    CapacitorStockfish::cmd(std::string([command UTF8String]));
}

- (void) exit {
    CapacitorStockfish::exit();
}

- (void) sendOutput: (NSString*)output {
    [_plugin sendOutput:output];
}

+ (NSString*) getCPUType {
    NSMutableString *cpu = [[NSMutableString alloc] init];
    size_t size;
    cpu_type_t type;
    cpu_subtype_t subtype;
    size = sizeof(type);
    sysctlbyname("hw.cputype", &type, &size, NULL, 0);

    size = sizeof(subtype);
    sysctlbyname("hw.cpusubtype", &subtype, &size, NULL, 0);

    // values for cputype and cpusubtype defined in mach/machine.h
    if (type == CPU_TYPE_X86_64) {
        [cpu appendString:@"x86_64"];
    } else if (type == CPU_TYPE_X86) {
        [cpu appendString:@"x86"];
        switch (subtype) {
            case CPU_SUBTYPE_X86_ALL:
            case CPU_SUBTYPE_X86_64_H:
                [cpu appendString:@"_64"];
                break;
        }
    } else if (type == CPU_TYPE_ARM) {
        [cpu appendString:@"ARM"];
        switch(subtype)
        {
            case CPU_SUBTYPE_ARM_V6:
                [cpu appendString:@"V6"];
                break;
            case CPU_SUBTYPE_ARM_V7:
                [cpu appendString:@"V7"];
                break;
            case CPU_SUBTYPE_ARM_V8:
                [cpu appendString:@"V8"];
                break;
        }
    }
    return cpu;
}


void StockfishSendOutput (void *bridge, const char *output)
{
  [(__bridge id) bridge sendOutput:[NSString stringWithUTF8String:output]];
}

@end

