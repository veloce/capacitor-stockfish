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
getMaxMemory() => any
```

Returns the maximum number of MB that can be used by the engine.

**Returns:** <code>any</code>

--------------------


### getCPUArch()

```typescript
getCPUArch() => any
```

Returns CPU architecture.
Possible values are: armeabi, armeabi-v7a, arm64-v8a, x86, x86_64, mips, mips64.

**Returns:** <code>any</code>

--------------------


### start()

```typescript
start() => any
```

Initialize the engine. You must call this method before sending commands.

**Returns:** <code>any</code>

--------------------


### cmd(...)

```typescript
cmd(options: { cmd: string; }) => any
```

Sends a command to the engine. You can listen to the output using the
"stockfish" window event.

| Param         | Type                          |
| ------------- | ----------------------------- |
| **`options`** | <code>{ cmd: string; }</code> |

**Returns:** <code>any</code>

--------------------


### exit()

```typescript
exit() => any
```

Stops the engine.

**Returns:** <code>any</code>

--------------------

</docgen-api>
