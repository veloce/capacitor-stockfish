declare module '@capacitor/core' {
  interface PluginRegistry {
    Stockfish: StockfishPlugin;
  }
}

export interface StockfishPlugin {
  echo(options: { value: string }): Promise<{ value: string }>;
}
