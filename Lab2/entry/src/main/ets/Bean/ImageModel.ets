import image from '@ohos.multimedia.image'
import { subImage } from '../Bean/SubImage'
import { countInversions } from '../Utils/CountInversions'

export class imageModel {
  steps: number = 0;

  async splitPicByImageSource(imgSource: image.ImageSource, row_col_num: number): Promise<subImage[]> {
    let subImageTemp: subImage[] = [];
    const imageInfo = await imgSource.getImageInfo();
    const ImageLength = Math.min(imageInfo.size.width, imageInfo.size.height);
    const subImageLength = ImageLength / row_col_num;

    for (let i = 0; i < row_col_num; i++) {
      for (let j = 0; j < row_col_num; j++) {
        let p = await imgSource.createPixelMap();
        let y0 = i * subImageLength;
        let x0 = j * subImageLength;
        await p.crop({ x: x0, y: y0, size: { width: subImageLength, height: subImageLength } });
        subImageTemp.push(new subImage(subImageTemp.length + 1, subImageTemp.length + 1, p));
      }
    }
    return subImageTemp;
  }

  shuffleArray(array: subImage[]): subImage[] {
    while (true) {
      for (let i = array.length - 1; i > 0; i--) {
        const j = Math.floor(Math.random() * (i + 1));
        let temp = array[i];
        array[i] = array[j];
        array[j] = temp;
      }
      let nums: number[] = [];
      let flag = false;
      for (let i = 0; i < array.length; i++) {
        array[i].position = i + 1;
        nums.push(array[i].truePosition);
        if (i > 0 && array[i].truePosition < array[i - 1].truePosition) {
          flag = true;
        }
      }
      if (countInversions(nums) % 2 == 0 && flag) {
        return array;
      }
    }
    return array;
  }

  exchangePic(truePosition: number, array: subImage[], row_col_num: number): subImage[] {
    let index = 0;
    for (let i = 0; i < array.length; i++) {
      if (array[i].truePosition == truePosition) {
        index = i;
        break;
      }
    }
    let minIndex = 0;
    let maxIndex = row_col_num * row_col_num;
    if (array[index].truePosition == maxIndex) {
      return array;
    }
    let Nums: number[] = [];
    Nums.push((index) % row_col_num == 0 ? -1 : index - 1);
    Nums.push((index + 1) % row_col_num == 0 ? -1 : index + 1);
    Nums.push(index + row_col_num);
    Nums.push(index - row_col_num);
    for (let i = 0; i < Nums.length; i++) {
      if (Nums[i] >= minIndex && Nums[i] < maxIndex && array[Nums[i]].truePosition == maxIndex) {
        array[Nums[i]] = new subImage(Nums[i] + 1, array[index].truePosition, array[index].pixelMap);
        array[index] = new subImage(index + 1, maxIndex, null);
        this.steps += 1;
        break;
      }
    }
    for (let i = 0; i < array.length; i++) {
      array[i].position = i + 1;
    }
    return array;
  }

  isSuccess(array: subImage[]): boolean {
    for (let i = 0; i < array.length; i++) {
      if (array[i].position != array[i].truePosition) {
        return false;
      }
    }
    return true;
  }
}