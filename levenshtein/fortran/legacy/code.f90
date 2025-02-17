module levenshtein
    implicit none
    private
    public :: levenshtein_distance

contains
    ! Calculates the Levenshtein distance between two strings using Wagner-Fischer algorithm
    ! Space Complexity: O(min(m,n)) - only uses two arrays instead of full matrix
    ! Time Complexity: O(m*n) where m and n are the lengths of the input strings
    function levenshtein_distance(s1, s2) result(distance)
        character(len=*), intent(in) :: s1, s2
        integer :: distance
        
        integer :: m, n, i, j, cost
        integer, allocatable :: prev_row(:), curr_row(:)
        character(len=1) :: c1, c2
        character(len=:), allocatable :: str1, str2
        
        ! Early termination checks
        if (s1 == s2) then
            distance = 0
            return
        end if
        
        if (len_trim(s1) == 0) then
            distance = len_trim(s2)
            return
        end if
        
        if (len_trim(s2) == 0) then
            distance = len_trim(s1)
            return
        end if
        
        ! Make s1 the shorter string for space optimization
        if (len_trim(s1) > len_trim(s2)) then
            str1 = trim(s2)
            str2 = trim(s1)
        else
            str1 = trim(s1)
            str2 = trim(s2)
        end if
        
        m = len_trim(str1)
        n = len_trim(str2)
        
        ! Use two arrays instead of full matrix for space optimization
        allocate(prev_row(0:m), curr_row(0:m))
        
        ! Initialize first row
        do i = 0, m
            prev_row(i) = i
        end do
        
        ! Main computation loop
        do j = 1, n
            curr_row(0) = j
            
            do i = 1, m
                ! Get characters at current position
                c1 = str1(i:i)
                c2 = str2(j:j)
                
                ! Calculate cost
                if (c1 == c2) then
                    cost = 0
                else
                    cost = 1
                end if
                
                ! Calculate minimum of three operations
                curr_row(i) = min(prev_row(i) + 1,      & ! deletion
                                curr_row(i-1) + 1,      & ! insertion
                                prev_row(i-1) + cost)     ! substitution
            end do
            
            ! Swap rows
            prev_row = curr_row
        end do
        
        distance = prev_row(m)
        
        ! Clean up
        deallocate(prev_row, curr_row)
    end function levenshtein_distance
end module levenshtein

program main
    use levenshtein
    implicit none
    
    integer :: num_args, i, j, distance, min_distance, times
    integer :: max_len, arg_len
    character(len=:), allocatable :: args(:)
    
    ! Get command line arguments
    num_args = command_argument_count()
    
    if (num_args < 2) then
        write(*, '(a)') 'Please provide at least two strings as arguments.'
        stop 1
    end if
    
    ! Get max length of arguments
    max_len = 0
    do i = 1, num_args
        call get_command_argument(i, length=arg_len)
        max_len = max(max_len, arg_len)
    end do

    ! Single allocation of args array
    allocate(character(len=max_len) :: args(num_args))
    
    ! Read command line arguments directly into allocated array
    do i = 1, num_args
        call get_command_argument(i, args(i))
    end do
    
    min_distance = -1
    times = 0
    
    ! Compare all pairs of strings
    do i = 1, num_args
        do j = 1, num_args
            if (i /= j) then
                distance = levenshtein_distance(args(i), args(j))
                if (min_distance == -1 .or. distance < min_distance) then
                    min_distance = distance
                end if
                times = times + 1
            end if
        end do
    end do
    
    write(*, '(a,i0)') 'times: ', times
    write(*, '(a,i0)') 'min_distance: ', min_distance
    
    ! Clean up
    deallocate(args)
end program main
