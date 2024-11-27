program loop
    implicit none
    integer, parameter :: n = 10000, m = 100000
    integer :: i, j, r, u
    character(len=100) :: arg
    real :: a(n), rn

    a = 0.0 ! init a with zeros
    call get_command_argument(1,arg); read(arg,*) u ! read first argument
    call random_number(rn); u = ceiling(rn * n) ! u -> between 1 and 10000 at random

    do i = 1, n
        do j = 1, m
            a(i) = a(i) + mod(j, u)
        end do
        a(i) = a(i) + r

    end do

    ! print the result
    print *, a(u)

end program
