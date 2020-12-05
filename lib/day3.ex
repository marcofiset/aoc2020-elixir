defmodule Aoc2020.Day3 do
  def part1 do
    slope = parsed_input()
    path = generate_path(3, 1)

    count_trees_on_path(slope, path)
  end

  def part2 do
    slope = parsed_input()
    paths = [[1, 1], [3, 1], [5, 1], [7, 1], [1, 2]]

    paths
    |> Enum.map(&apply(__MODULE__, :generate_path, &1))
    |> Enum.map(&count_trees_on_path(slope, &1))
    |> Enum.reduce(& &1 * &2)
  end

  def count_trees_on_path(slope, path) do
    Enum.reduce_while(path, 0, fn coords, tree_count ->
      case value_at(slope, coords) do
        nil -> {:halt, tree_count}
        "." -> {:cont, tree_count}
        "#" -> {:cont, tree_count + 1}
      end
    end)
  end

  def generate_path(x_offset, y_offset) do
    Stream.unfold([0, 0], fn
      [x, y] -> {[x, y], [x + x_offset, y + y_offset]}
    end)
  end

  def value_at(arr, [x, y]) do
    if y >= length(arr) do
      nil
    else
      width = arr
      |> Enum.at(0)
      |> length()

      arr
      |> Enum.at(y)
      |> Enum.at(rem(x, width))
    end
  end

  def parsed_input do
    input()
    |> String.split("\n")
    |> Enum.map(fn line ->
      line
      |> String.split("")
      |> Enum.filter(& &1 != "")
    end)
  end

  def input do
    ".#..............##....#.#.####.
##..........#.....##...........
.......#....##...........#.#...
.........#.#...#..........#....
.........#..#................##
..#...#..#..#...........#......
...................#...##..##..
........#.....##...#.#.#...#...
#..#.##......#.#..#..........#.
......#.#...#.#...#........##.#
.....#.####........#...........
...###..#............#.........
.....#.......##......#...#.....
#......##......................
......#..............#.........
..##...#....###.##.............
#...#..........#.#.........#...
...........#........#...#......
.....##.........#......#..#....
#..............#....#.....#....
.#......#....#...#............#
.####..........##..#.#.........
....#...#......................
....................#....#.#...
..........###.#...............#
.#...........#...##............
.#.#..#.....#...#....#.......#.
.##........#..#....#...........
.........#.....#......###......
..............#..#.......#.....
........#..#.#...........#..#..
#.........#......#.....##.#.#..
........#.#.#....#.............
........#........#.#.##........
#......#.#..........#..#.......
..#....#...##......###..#..#...
............#..#.#.........#...
....#.#...........#..........##
.......#.#.#..#......#...#.....
..#.........##.#.........#...#.
......#....#.#....#........#.#.
.#....###....#..............#..
.#....#.......#....#..#.....#..
.....#.....#...................
..#.....#......#......#........
......##.##...#...#...#...#.##.
##...#....#...#..#...#...#.....
..#.....#...#...##.##...#......
.....#.............##...#......
.....................#.##..#...
#...#....#....#........#.....#.
..#...#.........#...#..#.....#.
#.#......#...................#.
..#...........##...............
..#....#........#..#...........
...........#...................
.............###......#....#...
...........#...#....#..#....#..
.....##............#.#.......#.
.....#..#....#...#....#........
...............##........#.#...
.........#...#.#....#.......#..
#..#.......#.......#...#.......
..#...........................#
......#.......#..#......#......
.#.......#..................##.
..#.........#..#.##.#....#...##
...#..#....#...#....#.#........
.#...#........##..#..#.......#.
.....#........#....#....#..#...
............#...........#......
..###.......#..#....#......#...
.....#...#.......#..#..........
..#........##.#....##..........
#....#.............#..##......#
....#.................##.......
...#.......#........#....##.#.#
##..##..#.....#.....#..........
...#...............#....#..#...
.#...##....#....#.....#....##..
...#.....#......#......#.......
#.....#.......##.....#..#....##
.....#.#...##.#......##....#.#.
..........#....#.#...#.........
.#..##...#.....................
...........##..#...#....#......
...#......#........#.......#...
.#......#..#........#.....#..#.
.......#........##..#.##....#..
.##..........#..#...#.....#....
.....##...............#.#......
..##.....#..#......#..##.#.#...
....#......#.##...........#....
#.#..#.......#......#.#........
...#.#..#....#............#..#.
...#..........###....#....#...#
........##...#.......#..#....#.
..#...#.....#..#........##.....
...#..#.##.#.#.##..............
.......#...#.........#.....#..#
..#.....#.#..........#..#......
......#..........#......#.....#
.#...........#........#......##
..##............#......#...#..#
#..................#...........
#....#..#.........#........#..#
..#.#....###..#...#...##...##..
...#....#..#.....#.............
.#........##.##...#....#...#...
.........#.......##.#.....##...
#.#.....##...#........#...#...#
.....#.#.##...#.....#.##..#....
........#...##...#...#.#..#..#.
.##....#.##...#.......#........
...#..#................#..#....
....#.......#......#...#.##....
#......###..#...#......#.......
..#...#...##...........##......
.......#...#..##....##......#..
....#.#.............#.#...##..#
..........#........#...#......#
............#.#.#....###.......
#..#...#.#.####...#..#...#.....
.##.......#.##...#.............
#..#...........#.#.##.......#..
...#..#.#...#...###..#.#..#.#..
..#...#.....#..#....#....#.....
.........##.......#............
.........##.##......###........
.............#.#....#..#.....#.
...#....#.#.......#......##....
............#..................
....##...#..........#...#..#...
#..#....#.....#.......#.##.#..#
.....#.........##.............#
#.....#.#...#............##..##
..............#....#.....#.....
.#....###..#.#.....###.#..#....
.....#....##...#....#......#...
..........#...#....#...........
............#....#..#.........#
..##.....#.#...#.......#...#...
...#...#..#......##...#.....##.
......#.##............##.#....#
....#......#...##.....#.....###
.#.###...............#...#.#...
..#....................##...#..
.......#.....##...........#....
#.........#....#....#....#....#
..#.#..##.#.#..................
.....#.......#................#
...........#.......#........#..
#...#.........#.#.....#.....#..
..........#..#...........#.....
#..#.##..##..#.#.##.........#..
#..#..#....##..#.........#.....
#.#.......................#.#..
.##......#.#...#......#....#...
..#.#................#..##.....
.......#..................#...#
.....#.........##.#....#.......
#..........#..#.#..........#..#
..#..#.....#.........#...#.....
..............#.....#..#...#.##
...............................
...#............##......#.....#
.......#..#.............#.#....
...........#..........#........
...#.####..#......#...#....#...
##......#.##.....#.............
....#.........#...#...........#
...#........#.......#.#..#.#.#.
..#.......#.........#....#.....
................#.#.#.##...#..#
#.##...#...#..#.....#.....#..#.
...............#...........#...
.....##.#...............##...#.
.#..##.##......................
.......#.........#..#..#.......
...#......#..................#.
...#.#..#....#....#............
...........#...#..#....##......
.....#...#..#.#....#....#....#.
.......#...#...#.#.#...........
....#......#......#...##..#....
##...#.#.....#..#.##...........
#.#..#.....#..#................
...#..#.#......#.#...........##
##....#...#.....###..#...#....#
...#.....#.#.#......##...#...#.
............#.......#..........
....#..........###.......#.....
.................##..##....#...
...........#........##..#......
...#.#...#.....#........#...#..
#...#.#......#.#...........#...
..#..........#....#..........#.
..#................#...........
#...#.#....#.#.......#.........
.#...........##..#....#....#..#
.##........#.....#...#..#....#.
......#......#...#.............
.......#..#...#.##....#..#.#...
.......#......#....#....#.#.#..
..........##.....#....##.#.....
.........##..#...#.....#..#....
...#....#..........#..#...#..#.
.......#.....##.#..#.....#...#.
#...#......#......#...#........
#..#....#.#......#......#......
.......#.##....................
...##...#.....#......##......#.
.#...................###.......
....#........###...#........#..
...#............#.....#..#.....
..................#......#....#
..##......#..##..##......#.#...
........##....##.......#...#...
.#.#....#.....#.....#....#....#
...##.#.............#....##....
.........#.....#...#......#....
..#.....#............#....##...
..##.....#.....##.##...........
#....#.#.......#..#......#.....
##.......#.....#.....####....#.
##...#.......#...#.....#.......
#.....#..##.##...##..#.....#..#
..........#......#..#.#........
..##.#......#..............#...
.#...#..........#.......#....#.
..#....##...#...........#....#.
..#.........#..#......#......#.
.##....#......#.#.........#..##
.......#...#....##............#
.##.................#.#........
...#.#...#..#..#.....#.#.......
.#.#.......#...................
..#..#.....#......#.....##..##.
.#........#.##......#..........
....##...#............#.#....#.
.......#.#..#....##.#....#....#
......####...#..#.....#........
..........#..#.........#.#..#.#
..........##.........#.##......
.##..#.#.....#.....#....#......
............#..#...............
.....##.........#...#...##...##
........#.##.#...#.....#....#.#
#......##.#.##..........##.....
#..#..#........#.........#..#..
...............#.#..##.........
.#.......##.#..#....#...#....##
.#..##.....##......#....#...#.#
........#...#.........#.....#.#
...........#............#...#..
................#...........#..
..............##........#....#.
..........#.....##.....#..#....
#......#....###..#..#..........
.....#.#.....##....#.#.......#.
...#...#...............#.#.....
.............#.......#.........
.....#.....#..#......#.....#...
.........#.................#.##
.#.....#.##..#.................
..#......#.......#.....#...#..#
..#..#.#.#...#.......#.##......
..........#..#.........#.......
.#..........#...#....#..#...##.
.#.#.#.###.....#...#.#.#.......
....##............#............
.#.#.............#..#......#.#.
.#.#..........##..#.....#..#.#.
...........#.##..#...#.#.....#.
...........#..#....#...........
..#................#.#...#....#
...............##........##....
....#.............#........#...
...#......#.#.#........#.......
#..............#..##.#..##.....
.#.#.###................##.....
.............#..#.........#....
.......##..#............#...#..
...#...#...........#.....#.....
........#......#.#.#......#..#.
#.##.......#......#..#..#.#....
...#........#...........#...#..
..#...........#.........#......
.............#....#....#.......
....#.........#........#......#
..#............##..#.........#.
.#...#...#..#...#........#..#..
...#....##..............#......
...........#...#....#.#.##..###
..#....#......#.........#..#...
.......#...#...................
.#...#.#...................#...
.#.....##.#.......#.#.#...##..#
.....#..#.#.........#...#..##..
.#..#.##.#......#......#.#...#.
......#..#....##..#....##....##
#...#......##........##........
.#.........###................#
.................#..###..#.#...
..#.#........#..#........#...#.
#.#....#....#..#...#.#......#..
.#.#.............###.........#.
.....#...............##...#...#
..............#...#........#..#
...................#..#.......#
#......................#.....#.
...#.........#..##...#...#.##..
.....#..........#.........#....
.....#...#............#..#.....
.............#............#....
...#.........#.................
#...........#.#...............#
.....#...#.....#..#.##.......##
...#....#.#...........#........
.........................#.#...
.#..#...........#.#........#...
.............#.#.....#..#....#.
.....#...#.###...#..#........#."
  end
end
