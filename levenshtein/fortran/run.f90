program main
   use benchmark
   use levenshtein
   implicit none

   integer :: run_ms, warmup_ms, iostat, word_count
   character(len = 256) :: run_ms_str, warmup_ms_str, input_path
   character(len = :), allocatable :: args(:)
   integer, allocatable :: distances(:)
   type(benchmark_result_t) :: warmup_result, benchmark_result
   character(len = :), allocatable :: result_str

   call get_command_argument(1, run_ms_str)
   call get_command_argument(2, warmup_ms_str)
   call get_command_argument(3, input_path)
   read(run_ms_str, *) run_ms
   read(warmup_ms_str, *) warmup_ms

   call read_all_words(input_path, args, iostat)
   if (iostat /= 0) stop "Error reading file."
   word_count = size(args)
   if (word_count == 0) stop "No words read."

   allocate(distances((word_count * (word_count - 1)) / 2))
   call run(benchmark_function, warmup_ms, warmup_result)
   call run(benchmark_function, run_ms, benchmark_result)

   ! Sum the distances outside the benchmarked function
   benchmark_result%result = sum(distances)

   call format_results(benchmark_result, result_str)
   write(*, '(A)') trim(adjustl(result_str))

   deallocate(args, distances)

contains

   integer(8) function benchmark_function()
      implicit none
      integer :: i, j, idx
      integer(8) :: sum_distances
      sum_distances = 0
      idx = 1
      do i = 1, size(args)
         do j = i + 1, size(args)
            distances(idx) = levenshtein_distance(trim(args(i)), trim(args(j)))
            sum_distances = sum_distances + distances(idx)
            idx = idx + 1
         end do
      end do
      benchmark_function = sum_distances
   end function benchmark_function

   subroutine read_all_words(filename, all_words, iostat)
      implicit none
      character(len = *), intent(in) :: filename
      character(len = :), allocatable, intent(out) :: all_words(:)
      integer, intent(out) :: iostat
      integer :: unit, num_words, i
      integer, parameter :: max_len = 10000 ! Allow for really long words
      character(len = max_len) :: word

      open(newunit = unit, file = filename, status = 'old', action = 'read', iostat = iostat)
      if (iostat /= 0) return

      num_words = 0
      do
         read(unit, '(A)', iostat = iostat) word
         if (iostat /= 0) exit
         num_words = num_words + 1
      end do

      if (num_words > 0) then
         allocate(character(len = max_len) :: all_words(num_words))
         rewind(unit)
         do i = 1, num_words
            read(unit, '(A)', iostat = iostat) all_words(i)
            if (iostat /= 0) exit
         end do
      else
         allocate(all_words, mold = [character(len = max_len) :: ''])
      end if

      close(unit)
   end subroutine read_all_words

end program main