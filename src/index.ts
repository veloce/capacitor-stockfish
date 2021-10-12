import { registerPlugin } from '@capacitor/core';

import type { StockfishPlugin } from './definitions';

const Stockfish = registerPlugin<StockfishPlugin>('Stockfish');

export * from './definitions';
export { Stockfish };
