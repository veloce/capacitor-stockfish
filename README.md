# Capacitor Stockfish plugin

[Stockfish](https://stockfishchess.org/) chess engine interface for Ionic
Capacitor.

## Example usage

- https://github.com/veloce/lichobile/blob/master/src/stockfish.ts
- https://github.com/veloce/lichobile/blob/master/src/ui/analyse/ceval/StockfishClient.ts

## API

<docgen-index>

* [`getMaxMemory()`](#getmaxmemory)
* [`getCPUArch()`](#getcpuarch)
* [`start()`](#start)
* [`cmd(...)`](#cmd)
* [`exit()`](#exit)

</docgen-index>

<docgen-api>
<!--Update the source file JSDoc comments and rerun docgen to update the docs below-->

### getMaxMemory()

```typescript
getMaxMemory() => Promise<{ value: number; }>
```

Returns the maximum number of MB that can be used by the engine.

**Returns:** <code>Promise&lt;{ value: number; }&gt;</code>

--------------------


### getCPUArch()

```typescript
getCPUArch() => Promise<{ value: string; }>
```

Returns CPU architecture.
Possible values are: armeabi, armeabi-v7a, arm64-v8a, x86, x86_64, mips, mips64.

**Returns:** <code>Promise&lt;{ value: string; }&gt;</code>

--------------------


### start()

```typescript
start() => Promise<void>
```

Initialize the engine. You must call this method before sending commands.

--------------------


### cmd(...)

```typescript
cmd(options: { cmd: string; }) => Promise<void>
```

Sends a command to the engine. You can listen to the output using the
"stockfish" window event.

| Param         | Type                          |
| ------------- | ----------------------------- |
| **`options`** | <code>{ cmd: string; }</code> |

--------------------


### exit()

```typescript
exit() => Promise<void>
```

Stops the engine.

--------------------

</docgen-api>
