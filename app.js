/**
 * @param {string[]} field - описание поля в виде массива строк
 * @param {string} moves - строка со всеми движениями змейки
 * @returns {[number[], number]}
 */
function solution(field, moves) {
  let size;
  let x = 0;
  let y = 2;
  const parts = moves.split(' ');
  const result = [];

  for (let i = 0; i < parts.length; i += 2) {
    result.push({
      action: parts[i],
      value: Number(parts[i + 1]),
    });
  }

  for (const [key, value] of Object.entries(result)) {
    console.log(key, value);
  }

  return [[x, y], size]; // [x, y] - координаты головы змейки, N - размер змейки
}

const field = [
  'ooo------Y--AND------',
  '-----EXY--A--N---D--E',
  '-X-----Y--A-N---D----',
  '------EXY----A---N---',
  '--DE--X---------YA---',
  '-----ND---EXY--AN--D-',
  '----E-----X-Y----A--N',
  'D-----E-XY---AN---D--',
  'E--------------------',
  '-------X---Y------A-N',
  '----D-EX----------YA-',
  '--N-DEX--Y-A--N-----D',
  'E------X--Y----------',
];

const moves = `R 12 D 2 R 2 U 1 R 2`;
console.log(solution(field, moves)); // [[x, y], N]
