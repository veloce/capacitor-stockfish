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
