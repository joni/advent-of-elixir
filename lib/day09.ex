defmodule Day09 do
  def part1() do
    File.read!("input/day09.txt")
    |> run
  end

  def part2() do
    program =
      File.read!("input/day09.txt")
      |> new_program

    child = spawn_link(Day09, :run, [program, self()])
    send(child, 2)

    doLoop([])
    |> Enum.reverse()
  end

  def run(text) do
    program = new_program(text)
    child = spawn_link(Day09, :run, [program, self()])
    send(child, 1)

    doLoop([])
    |> Enum.reverse()
  end

  defp doLoop(acc) do
    receive do
      :end ->
        acc

      output ->
        # IO.inspect(output)
        doLoop([output | acc])
    end
  end

  def run(program, ppid) do
    run(0, 0, program, ppid)
  end

  defp decode(instruction) do
    opcode = rem(instruction, 100)
    mode1 = rem(div(instruction, 100), 10)
    mode2 = rem(div(instruction, 1000), 10)
    mode3 = rem(div(instruction, 10000), 10)
    {opcode, mode1, mode2, mode3}
  end

  defp load(program, bp, arg, mode) do
    case mode do
      # position mode
      0 -> Arrays.get(program, Arrays.get(program, arg))
      # immediate mode
      1 -> Arrays.get(program, arg)
      # relative mode
      2 -> Arrays.get(program, bp + Arrays.get(program, arg))
    end
  end

  defp store(program, bp, addr, acc, mode) do
    case mode do
      0 -> Arrays.replace(program, addr, acc)
      2 -> Arrays.replace(program, bp + addr, acc)
    end
  end

  def run(pc, bp, program, ppid) do
    instruction = decode(program[pc])
    opcode = elem(instruction, 0)
    # IO.inspect(pc)
    # IO.inspect(instruction)
    # IO.puts("pc=#{pc} bp=#{bp} op=#{inspect(instruction)}")

    cond do
      opcode == 99 -> send(ppid, :end)
      opcode == 1 || opcode == 2 -> op_binary(pc, bp, program, 4, ppid)
      opcode == 3 || opcode == 4 -> op_io(pc, bp, program, 2, ppid)
      opcode == 5 || opcode == 6 -> op_jump(pc, bp, program, ppid)
      opcode == 7 || opcode == 8 -> op_compare(pc, bp, program, ppid)
      opcode == 9 -> op_change_base(pc, bp, program, ppid)
    end
  end

  def op_io(pc, bp, program, 2, ppid) do
    instruction = decode(program[pc])
    opcode = elem(instruction, 0)
    mode = elem(instruction, 1)
    op1 = program[pc + 1]
    arg1 = load(program, bp, pc + 1, elem(instruction, 1))

    case opcode do
      3 ->
        receive do
          input -> run(pc + 2, bp, store(program, bp, op1, input, mode), ppid)
        end

      4 ->
        send(ppid, arg1)
        run(pc + 2, bp, program, ppid)
    end
  end

  def op_binary(pc, bp, program, 4, ppid) do
    instruction = decode(program[pc])
    opcode = elem(instruction, 0)
    arg1 = load(program, bp, pc + 1, elem(instruction, 1))
    arg2 = load(program, bp, pc + 2, elem(instruction, 2))
    op3 = program[pc + 3]
    mode = elem(instruction, 3)
    # IO.inspect(arg1)
    # IO.inspect(arg2)

    prog =
      case opcode do
        1 -> store(program, bp, op3, arg1 + arg2, mode)
        2 -> store(program, bp, op3, arg1 * arg2, mode)
      end

    run(pc + 4, bp, prog, ppid)
  end

  defp op_jump(pc, bp, program, ppid) do
    instruction = decode(program[pc])
    opcode = elem(instruction, 0)
    arg1 = load(program, bp, pc + 1, elem(instruction, 1))
    arg2 = load(program, bp, pc + 2, elem(instruction, 2))

    case opcode do
      # op_jump-if-true
      5 -> run(if(arg1 != 0, do: arg2, else: pc + 3), bp, program, ppid)
      # op_jump-if-false
      6 -> run(if(arg1 == 0, do: arg2, else: pc + 3), bp, program, ppid)
    end
  end

  def op_compare(pc, bp, program, ppid) do
    instruction = decode(program[pc])
    opcode = elem(instruction, 0)
    arg1 = load(program, bp, pc + 1, elem(instruction, 1))
    arg2 = load(program, bp, pc + 2, elem(instruction, 2))
    arg3 = program[pc + 3]
    mode = elem(instruction, 3)

    prog =
      case opcode do
        # less-than
        7 -> store(program, bp, arg3, if(arg1 < arg2, do: 1, else: 0), mode)
        # equals
        8 -> store(program, bp, arg3, if(arg1 == arg2, do: 1, else: 0), mode)
      end

    run(pc + 4, bp, prog, ppid)
  end

  def op_change_base(pc, bp, program, ppid) do
    instruction = decode(program[pc])
    arg1 = load(program, bp, pc + 1, elem(instruction, 1))
    run(pc + 2, bp + arg1, program, ppid)
  end

  def new_program(input) do
    String.trim(input)
    |> String.split(",", trim: true)
    |> Enum.map(&String.trim/1)
    |> Enum.map(&String.to_integer/1)
    |> Arrays.new(default: 0)

    # |> IO.inspect()
  end
end
