module benchmark
  implicit none
  private
  public :: run, format_results, benchmark_result_t  ! Make benchmark_result_t public

  type :: benchmark_result_t
    integer :: runs
    real(8) :: mean_ms
    real(8) :: std_dev_ms
    real(8) :: min_ms
    real(8) :: max_ms
    integer(8) :: result
  end type benchmark_result_t

contains

  subroutine run(f, run_ms, result)
    implicit none
    interface
      integer(8) function f()
      end function f
    end interface
    procedure(f), pointer :: func_ptr
    integer, intent(in) :: run_ms
    type(benchmark_result_t), intent(out) :: result
    integer(8) :: start_time, end_time, elapsed_time, total_elapsed_time
    integer(8) :: count_rate
    integer :: count
    real(8) :: elapsed_times(1000000), mean, variance, std_dev, min_time, max_time
    logical :: print_status
    integer(8) :: last_status_t

    ! Check for run_ms being zero
    if (run_ms == 0) then
      result%runs = 0
      result%mean_ms = 0.0
      result%std_dev_ms = 0.0
      result%min_ms = 0.0
      result%max_ms = 0.0
      result%result = 0
      return
    end if

    func_ptr => f
    total_elapsed_time = 0
    count = 0
    min_time = 1.0e12
    max_time = 0.0
    print_status = (run_ms > 1)
    call system_clock(count_rate=count_rate)  ! Get the count rate
    last_status_t = 0

    if (print_status) then
      write(0, '(A)', advance='no') "."
      flush(0)
    end if

    do while (total_elapsed_time < run_ms * 1.0e6)
      if (print_status .and. (total_elapsed_time - last_status_t) > 1.0e9) then
        last_status_t = total_elapsed_time
        write(0, '(A)', advance='no') "."
        flush(0)
      end if
      call system_clock(start_time, count_rate=count_rate)  ! Use nanosecond precision
      result%result = func_ptr()
      call system_clock(end_time, count_rate=count_rate)    ! Use nanosecond precision
      elapsed_time = end_time - start_time
      if (elapsed_time == 0) cycle  ! Skip zero elapsed time measurements
      if (count < size(elapsed_times)) then
        elapsed_times(count + 1) = elapsed_time / 1.0e6
      else
        write(0,*) "Error: Exceeded maximum number of iterations"
        exit
      end if
      total_elapsed_time = total_elapsed_time + elapsed_time
      count = count + 1
      if (elapsed_times(count) < min_time) min_time = elapsed_times(count)
      if (elapsed_times(count) > max_time) max_time = elapsed_times(count)
    end do

    if (print_status) then
      write(0, '(A)') ""
    end if

    mean = sum(elapsed_times(1:count)) / count
    variance = sum((elapsed_times(1:count) - mean)**2) / count
    std_dev = sqrt(variance)

    result%runs = count
    result%mean_ms = mean
    result%std_dev_ms = std_dev
    result%min_ms = min_time
    result%max_ms = max_time
  end subroutine run

  subroutine format_results(benchmark_result, result_str)
      implicit none
      type(benchmark_result_t), intent(in) :: benchmark_result
      character(len=:), allocatable, intent(out) :: result_str
      character(len=256) :: temp_str

      write(temp_str, '(f0.6,",",f0.6,",",f0.6,",",f0.6,",",i0,",",i0)') &
        benchmark_result%mean_ms, benchmark_result%std_dev_ms, benchmark_result%min_ms, benchmark_result%max_ms, benchmark_result%runs, benchmark_result%result

      result_str = trim(adjustl(temp_str))
  end subroutine format_results

end module benchmark