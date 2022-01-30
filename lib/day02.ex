defmodule Day02 do
  def run(program) do
    run(0, program)
  end

  def run(pc, program) do
    opcode = program[pc]
    # IO.puts("pc=#{pc} op=#{opcode}")

    case opcode do
      99 -> program
      _ -> run(pc, program, 4)
    end
  end

  def run(pc, program, 4) do
    opcode = program[pc]
    op1 = program[pc + 1]
    op2 = program[pc + 2]
    op3 = program[pc + 3]
    arg1 = program[op1]
    arg2 = program[op2]

    prog =
      case opcode do
        1 -> Arrays.replace(program, op3, arg1 + arg2)
        2 -> Arrays.replace(program, op3, arg1 * arg2)
      end

    run(pc + 4, prog)
  end

  def input() do
    File.read!("input/day02.txt")
    |> String.trim()
    |> String.split(",", trim: true)
    |> Enum.map(&String.to_integer/1)
    |> Arrays.new()
  end

  def run_with_args(program, noun, verb) do
    program
    |> Arrays.replace(1, noun)
    |> Arrays.replace(2, verb)
    |> run
  end

  def part1() do
    input()
    |> run_with_args(12, 2)
    |> Arrays.get(0)
  end

  def part2() do
    program = input() |> Arrays.new()

    Enum.find_value(0..99, fn noun ->
      Enum.find_value(0..99, fn verb ->
        result = program
        |> run_with_args(noun, verb)
        |> Arrays.get(0)

        if result == 1969_07_20 do
          noun * 100 + verb
        else
          false
        end
      end)
    end)
  end
end
