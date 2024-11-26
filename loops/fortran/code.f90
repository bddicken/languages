program main
    implicit none
    integer :: u, r, i, j
    integer, dimension(10000) :: a      ! Integer array with 10k elements
    real :: random_value                ! Temporary variable for random number generation
    character(len=256) :: arg           ! Single command-line argument storage

    call get_command_argument(1, arg)
    read(arg, *) u                      ! Convert the command-line argument to integer
    call random_seed()                  ! Initialize the random number generator
    call random_number(random_value)    ! Generate a random number (0 <= random_value < 1)
    r = int(random_value * 10000)       ! Scale and convert to an integer

    a = 0                               ! Initialize the array with zeros    
    do i = 1, 10000
        do j = 0, 99999
            a(i) = a(i) + mod(j, u)
        end do
        a(i) = a(i) + r
    end do

    print *, a(r + 1)                   
end program main