export function countInversions(arr: number[]): number {
  let count = 0;

  let mergeSort: (arr: number[]) => number[] = (arr: number[]): number[] => {
    if (arr.length <= 1) {
      return arr;
    }
    const mid = Math.floor(arr.length / 2);
    const left = mergeSort(arr.slice(0, mid));
    const right = mergeSort(arr.slice(mid));
    return merge(left, right);
  };

  let merge: (left: number[], right: number[]) => number[] = (left: number[], right: number[]): number[] => {
    const mergedArr: number[] = [];
    let i = 0, j = 0;
    while (i < left.length && j < right.length) {
      if (left[i] <= right[j]) {
        mergedArr.push(left[i]);
        i++;
      } else {
        mergedArr.push(right[j]);
        j++;
        count += left.length - i;
      }
    }
    return mergedArr.concat(left.slice(i)).concat(right.slice(j));
  };

  mergeSort(arr);
  return count;
}