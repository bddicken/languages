program main
    implicit none
    integer(kind=4) :: u, r, i
    character(len=256) :: arg

    call get_command_argument(1, arg)
    read(arg, *) u

    r = 0

    do i = 1, u - 1
        r = r + fibonacci(i)
    end do

    print *, r

contains

    recursive function fibonacci(n) result(f)
        integer(kind=4), intent(in) :: n
        integer(kind=4) :: f

        if (n == 0) then
            f = 0
        elseif (n == 1) then
            f = 1
        else
            f = fibonacci(n - 1) + fibonacci(n - 2)
        end if
    end function fibonacci

end program main
