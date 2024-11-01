export class subImage {
  position: number = 0;
  truePosition: number = 0;
  pixelMap: PixelMap | null = null;

  constructor(position: number, truePosition: number, pixelMap: PixelMap | null) {
    this.position = position;
    this.truePosition = truePosition;
    this.pixelMap = pixelMap;
  }
}