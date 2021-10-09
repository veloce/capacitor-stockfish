# Capacitor Stockfish plugin

[Stockfish](https://stockfishchess.org/) chess engine interface for Ionic
Capacitor.

## API

| Method                                            | Returns         |
| ------------------------------------------------- | --------------- |
| getCPUArch()                                      | `Promise<{ value: string }>` |
| getMaxMemory()                                    | `Promise<{ value: number }>` |
| start()                                           | `Promise<void>` |
| cmd(options: { cmd: string })                     | `Promise<void>` |
| exit()                                            | `Promise<void>` |

## Example usage

- https://github.com/veloce/lichobile/blob/master/src/stockfish.ts
- https://github.com/veloce/lichobile/blob/master/src/ui/analyse/ceval/StockfishClient.ts

