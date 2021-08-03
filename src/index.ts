import { registerPlugin } from '@capacitor/core';

import type { StockfishPlugin } from './definitions';

const Stockfish = registerPlugin<StockfishPlugin>('Stockfish', {
  web: () => import('./web').then(m => new m.StockfishWeb()),
});

export * from './definitions';
export { Stockfish };
