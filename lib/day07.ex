defmodule Day07 do
  def part1() do
    File.read!("input/day07.txt")
    |> solve()
  end

  def part2() do
    File.read!("input/day07.txt")
    |> solve2()
  end

  def solve(input) do
    prog = Day07.new_program(input)

    permutations([0, 1, 2, 3, 4])
    |> Enum.map(&feedbackLoop(&1, prog))
    |> Enum.max()
  end

  def permutations(list) do
    case list do
      [] ->
        [[]]

      [x | xs] ->
        Enum.flat_map(permutations(xs), fn elem ->
          for idx <- 0..length(elem) do
            List.insert_at(elem, idx, x)
          end
        end)
    end
  end

  def solve2(input) do
    prog = new_program(input)

    permutations([5, 6, 7, 8, 9])
    |> Enum.map(&feedbackLoop(&1, prog))
    |> Enum.max()
  end

  defp feedbackLoop(phaseSetting, program) do
    pid = setupProcessChain(phaseSetting, program)
    doLoop(pid, 0)
  end

  defp setupProcessChain(phaseSetting, program) do
    List.foldr(phaseSetting, self(), fn elem, pid ->
      child = spawn(Day07, :run, [program, pid])
      send(child, elem)
      child
    end)
  end

  defp doLoop(pid, value) do
    send(pid, value)

    receive do
      :end -> value
      output -> doLoop(pid, output)
    end
  end

  def run(program, ppid) do
    run(0, program, ppid)
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

  def run(pc, program, ppid) do
    instruction = decode(program[pc])
    opcode = elem(instruction, 0)
    # IO.inspect(pc)
    # IO.inspect(instruction)
    # IO.puts("pc=#{pc} op=#{instruction}")

    cond do
      opcode == 99 -> send(ppid, :end)
      opcode == 1 || opcode == 2 -> op_binary(pc, program, 4, ppid)
      opcode == 3 || opcode == 4 -> op_io(pc, program, 2, ppid)
      opcode == 5 || opcode == 6 -> op_jump(pc, program, ppid)
      opcode == 7 || opcode == 8 -> op_compare(pc, program, ppid)
    end
  end

  def op_io(pc, program, 2, ppid) do
    instruction = decode(program[pc])
    opcode = elem(instruction, 0)
    op1 = program[pc + 1]
    arg1 = load(program, pc + 1, elem(instruction, 1))

    case opcode do
      3 ->
        receive do
          input -> run(pc + 2, store(program, op1, input), ppid)
        end

      4 ->
        send(ppid, arg1)
        run(pc + 2, program, ppid)
    end
  end

  def op_binary(pc, program, 4, ppid) do
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

    run(pc + 4, prog, ppid)
  end

  defp op_jump(pc, program, ppid) do
    instruction = decode(program[pc])
    opcode = elem(instruction, 0)
    arg1 = load(program, pc + 1, elem(instruction, 1))
    arg2 = load(program, pc + 2, elem(instruction, 2))

    case opcode do
      # op_jump-if-true
      5 -> run(if(arg1 != 0, do: arg2, else: pc + 3), program, ppid)
      # op_jump-if-false
      6 -> run(if(arg1 == 0, do: arg2, else: pc + 3), program, ppid)
    end
  end

  def op_compare(pc, program, ppid) do
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

    run(pc + 4, prog, ppid)
  end

  def new_program(input) do
    String.trim(input)
    |> String.split(",", trim: true)
    |> Enum.map(&String.trim/1)
    |> Enum.map(&String.to_integer/1)
    |> Arrays.new()
  end
end
