defmodule Day05 do
  def run(program, input) do
    run(0, program, input, [])
  end

  def run(program, input, output) do
    run(0, program, input, output)
  end

  defp decode(instruction) do
    opcode = rem(instruction, 100)
    mode1 = rem(div(instruction, 100), 10)
    mode2 = rem(div(instruction, 1000), 10)
    mode3 = rem(div(instruction, 10000), 10)
    {opcode, mode1, mode2, mode3}
  end

  defp load(program, arg, mode) do
    case mode do
      0 -> program[program[arg]]
      1 -> program[arg]
    end
  end

  defp store(program, addr, value) do
    Arrays.replace(program, addr, value)
  end

  def run(pc, program, input, output) do
    instruction = decode(program[pc])
    opcode = elem(instruction, 0)
    # IO.inspect(pc)
    # IO.inspect(instruction)
    # IO.puts("pc=#{pc} op=#{instruction}")

    cond do
      opcode == 99 -> output
      opcode == 1 || opcode == 2 -> op_binary(pc, program, 4, input, output)
      opcode == 3 || opcode == 4 -> op_io(pc, program, 2, input, output)
      opcode == 5 || opcode == 6 -> op_jump(pc, program, input, output)
      opcode == 7 || opcode == 8 -> op_compare(pc, program, input, output)
    end
  end

  def op_io(pc, program, 2, input, output) do
    instruction = decode(program[pc])
    opcode = elem(instruction, 0)
    op1 = program[pc + 1]
    arg1 = load(program, pc + 1, elem(instruction, 1))

    case opcode do
      3 -> run(pc + 2, store(program, op1, hd(input)), tl(input), output)
      4 -> run(pc + 2, program, input, [arg1 | output])
    end
  end

  def op_binary(pc, program, 4, input, output) do
    instruction = decode(program[pc])
    opcode = elem(instruction, 0)
    arg1 = load(program, pc + 1, elem(instruction, 1))
    arg2 = load(program, pc + 2, elem(instruction, 2))
    op3 = program[pc + 3]
    # IO.inspect(arg1)
    # IO.inspect(arg2)

    prog =
      case opcode do
        1 -> store(program, op3, arg1 + arg2)
        2 -> store(program, op3, arg1 * arg2)
      end

    run(pc + 4, prog, input, output)
  end

  defp op_jump(pc, program, input, output) do
    instruction = decode(program[pc])
    opcode = elem(instruction, 0)
    arg1 = load(program, pc + 1, elem(instruction, 1))
    arg2 = load(program, pc + 2, elem(instruction, 2))

    case opcode do
      # op_jump-if-true
      5 -> run(if(arg1 != 0, do: arg2, else: pc + 3), program, input, output)
      # op_jump-if-false
      6 -> run(if(arg1 == 0, do: arg2, else: pc + 3), program, input, output)
    end
  end

  def op_compare(pc, program, input, output) do
    instruction = decode(program[pc])
    opcode = elem(instruction, 0)
    arg1 = load(program, pc + 1, elem(instruction, 1))
    arg2 = load(program, pc + 2, elem(instruction, 2))
    arg3 = program[pc + 3]

    prog =
      case opcode do
        # less-than
        7 -> store(program, arg3, if(arg1 < arg2, do: 1, else: 0))
        # equals
        8 -> store(program, arg3, if(arg1 == arg2, do: 1, else: 0))
      end

    run(pc + 4, prog, input, output)
  end

  def input() do
    File.read!("input/day05.txt")
    |> new_program
  end

  def new_program(input) do
    String.trim(input)
    |> String.split(",", trim: true)
    |> Enum.map(&String.to_integer/1)
    |> Arrays.new()
  end

  def part1() do
    input()
    |> run([1])
    |> hd
  end

  def part2() do
    input()
    |> run([5])
    |> hd
  end
end
