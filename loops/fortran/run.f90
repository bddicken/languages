program main
    use benchmark
    implicit none
    integer :: run_ms, warmup_ms, u
    character(len=256) :: arg
    type(benchmark_result_t) :: warmup_result, benchmark_result
    character(len = :), allocatable :: result_str

    call get_command_argument(1, arg)
    read(arg, *) run_ms                 ! Convert the command-line argument to integer
    call get_command_argument(2, arg)
    read(arg, *) warmup_ms              ! Convert the command-line argument to integer
    call get_command_argument(3, arg)
    read(arg, *) u                      ! Convert the command-line argument to integer

    call run(loops_benchmark, warmup_ms, warmup_result)
    call run(loops_benchmark, run_ms, benchmark_result)

    call format_results(benchmark_result, result_str)
    write(*, '(A)') trim(adjustl(result_str))

contains

    integer(8) function loops_benchmark()
        implicit none
        integer :: i, j, r
        integer(8) :: result
        integer, dimension(10000) :: a
        real :: random_value

        call random_seed()                  ! Initialize the random number generator
        call random_number(random_value)    ! Generate a random number (0 <= random_value < 1)
        r = int(random_value * 10000)       ! Scale and convert to an integer

        a = 0                               ! Initialize the array with zeros    
        do i = 1, 10000
            do j = 0, 9999
                a(i) = a(i) + mod(j, u)
            end do
            a(i) = a(i) + r
        end do

        result = a(r)
        loops_benchmark = result
    end function loops_benchmark

end program main