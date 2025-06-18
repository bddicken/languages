program main
    use benchmark
    use fibonacci_module
    implicit none
    integer(8) :: n
    integer(4) :: run_ms, warmup_ms
    character(len=256) :: arg
    type(benchmark_result_t) :: warmup_result, benchmark_result
    character(len = :), allocatable :: result_str

    call get_command_argument(1, arg)
    read(arg, *) run_ms                 ! Convert the command-line argument to integer
    call get_command_argument(2, arg)
    read(arg, *) warmup_ms              ! Convert the command-line argument to integer
    call get_command_argument(3, arg)
    read(arg, *) n                      ! Convert the command-line argument to integer

    call run(fibonacci_benchmark, warmup_ms, warmup_result)
    call run(fibonacci_benchmark, run_ms, benchmark_result)

    call format_results(benchmark_result, result_str)
    write(*, '(A)') trim(adjustl(result_str))

contains

    integer(8) function fibonacci_benchmark()
        implicit none
        integer(8) :: result

        result = fibonacci(n)
        fibonacci_benchmark = result
    end function fibonacci_benchmark

end program main